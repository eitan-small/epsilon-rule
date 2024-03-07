package com.epsilon.rule.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.epsilon.rule.context.InputContext;
import com.epsilon.rule.context.OutputContext;
import com.epsilon.rule.convert.edge.EpsilonEdgeConvert;
import com.epsilon.rule.convert.menu.RuleMenuConvert;
import com.epsilon.rule.convert.node.EpsilonNodeConvert;
import com.epsilon.rule.convert.rule.EpsilonRuleConvert;
import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.entity.*;
import com.epsilon.rule.domain.vo.*;
import com.epsilon.rule.enums.MenuTypeEnum;
import com.epsilon.rule.enums.NodeTypeEnum;
import com.epsilon.rule.exception.ServiceException;
import com.epsilon.rule.mapper.EpsilonRuleMapper;
import com.epsilon.rule.parser.EpsilonGraphParser;
import com.epsilon.rule.service.*;
import com.yomahub.liteflow.core.FlowExecutor;
import com.yomahub.liteflow.flow.LiteflowResponse;
import com.yomahub.liteflow.flow.entity.CmpStep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;

@Service
public class EpsilonRuleServiceImpl extends ServiceImpl<EpsilonRuleMapper, EpsilonRule> implements IEpsilonRuleService {
    private final FlowExecutor flowExecutor;

    private final IEpsilonNodeService nodeService;

    private final IEpsilonEdgeService edgeService;

    private final IRuleMenuService ruleMenuService;

    private final IEpsilonChainService chainService;

    private final IEpsilonScriptService scriptService;

    @Autowired
    public EpsilonRuleServiceImpl(FlowExecutor flowExecutor, IEpsilonNodeService nodeService, IEpsilonEdgeService edgeService, IRuleMenuService ruleMenuService, IEpsilonChainService chainService, IEpsilonScriptService scriptService) {
        this.flowExecutor = flowExecutor;
        this.nodeService = nodeService;
        this.edgeService = edgeService;
        this.ruleMenuService = ruleMenuService;
        this.chainService = chainService;
        this.scriptService = scriptService;
    }

    @Override
    public CommonResult<EpsilonRuleResponse> execute(EpsilonRuleRequest request) {
        EpsilonRuleResponse epsilonRuleResponse = new EpsilonRuleResponse();
        // 执行规则链
        InputContext inputContext = request.getData();
        if (inputContext == null) {
            inputContext = new InputContext();
        }
        OutputContext outputContext = new OutputContext();
        LiteflowResponse liteflowResponse = flowExecutor.execute2Resp(request.getChainId(), null, inputContext, outputContext);

        // 规则链执行失败
        if (!liteflowResponse.isSuccess()) {
            Exception exception = liteflowResponse.getCause();
            LinkedList<StepDetail> stepDetails = getStepDetails(liteflowResponse);
            epsilonRuleResponse.setStepDetail(stepDetails);
            return CommonResult.error(epsilonRuleResponse, exception.getMessage());
        }

        // 规则链执行成功
        epsilonRuleResponse.setContext(liteflowResponse.getContextBean(OutputContext.class));

        // 是否获取规则执行步骤详情
        if (request.getGetStepDetail() != null && request.getGetStepDetail()) {
            LinkedList<StepDetail> stepDetails = getStepDetails(liteflowResponse);
            epsilonRuleResponse.setStepDetail(stepDetails);
        }

        // 是否获取完整上下文
        if (request.getGetFullContext() != null && request.getGetFullContext()) {
            epsilonRuleResponse.setFullContext(liteflowResponse.getContextBean(InputContext.class));
        }

        return CommonResult.success(epsilonRuleResponse);
    }

    private static LinkedList<StepDetail> getStepDetails(LiteflowResponse liteflowResponse) {
        Queue<CmpStep> stepQueue = liteflowResponse.getExecuteStepQueue();
        // 转化为 Queue<StepDetail> 对象
        return stepQueue.stream().map(step -> {
            StepDetail stepDetail = new StepDetail();
            stepDetail.setNodeId(step.getNodeId());
            stepDetail.setNodeName(step.getNodeName());
            stepDetail.setTag(step.getTag());
            stepDetail.setStepType(step.getStepType());
            stepDetail.setStartTime(step.getStartTime());
            stepDetail.setEndTime(step.getEndTime());
            stepDetail.setTimeSpent(step.getTimeSpent());
            stepDetail.setSuccess(step.isSuccess());
            stepDetail.setException(step.getException());
            stepDetail.setRollbackTimeSpent(step.getRollbackTimeSpent());
            return stepDetail;
        }).collect(Collectors.toCollection(LinkedList::new));
    }

    @Override
    @Transactional
    public void updateGraph(EpsilonGraphVo epsilonGraph) {
        Integer ruleId = epsilonGraph.getRuleId();
        EpsilonRule rule = getOne(new LambdaQueryWrapper<EpsilonRule>().eq(EpsilonRule::getRuleId, ruleId));
        if (rule == null || rule.getEnable()) {
            throw new ServiceException("规则不存在或规则正在启用中！");
        }

        List<EpsilonNode> nodeList = epsilonGraph.getNodes().stream().map(EpsilonNodeConvert.INSTANCE::convert).toList();
        List<EpsilonEdge> edgeList = epsilonGraph.getEdges().stream().map(EpsilonEdgeConvert.INSTANCE::convert).toList();

        // 先删除旧数据
        nodeService.remove(new LambdaQueryWrapper<EpsilonNode>().eq(EpsilonNode::getRuleId, ruleId));
        edgeService.remove(new LambdaQueryWrapper<EpsilonEdge>().eq(EpsilonEdge::getRuleId, ruleId));

        // 添加新数据
        nodeService.saveBatch(nodeList);
        edgeService.saveBatch(edgeList);
    }

    @Override
    public EpsilonGraphVo selectGraph(Integer ruleId) {
        // 查询节点和边
        List<EpsilonNode> nodeList = nodeService.list(new LambdaQueryWrapper<EpsilonNode>().eq(EpsilonNode::getRuleId, ruleId));
        List<EpsilonEdge> edgeList = edgeService.list(new LambdaQueryWrapper<EpsilonEdge>().eq(EpsilonEdge::getRuleId, ruleId));

        // 转化为 EpsilonGraphVo 对象
        EpsilonGraphVo epsilonGraph = new EpsilonGraphVo();
        epsilonGraph.setRuleId(ruleId);
        epsilonGraph.setNodes(nodeList.stream().map(EpsilonNodeConvert.INSTANCE::convert).toList());
        epsilonGraph.setEdges(edgeList.stream().map(EpsilonEdgeConvert.INSTANCE::convert).toList());
        return epsilonGraph;
    }

    @Override
    public EpsilonRuleVo selectRule(Integer ruleId) {
        EpsilonRule rule = getById(ruleId);
        if (rule == null) {
            return null;
        }
        EpsilonRuleVo ruleVo = EpsilonRuleConvert.INSTANCE.convert(rule);

        // 查询规则菜单
        RuleMenu ruleMenu = ruleMenuService.selectRuleMenu(ruleId);
        if (ruleMenu != null) {
            ruleVo.setMenuName(ruleMenu.getMenuName());
            ruleVo.setProjectId(ruleMenu.getProjectId());
        }

        return ruleVo;
    }

    @Override
    @Transactional
    public RuleMenuVo saveOrUpdateRule(EpsilonRuleVo epsilonRule) {
        Map<String, Object> resp = new HashMap<>();

        Integer ruleId = epsilonRule.getRuleId();
        if (ruleId == null) {
            // 新建规则和目录
            EpsilonRule rule = new EpsilonRule();
            rule.setChainName(epsilonRule.getChainName());
            rule.setRuleDesc(epsilonRule.getRuleDesc());
            save(rule);

            RuleMenu ruleMenu = new RuleMenu();

            ruleMenu.setProjectId(epsilonRule.getProjectId());
            ruleMenu.setMenuName(epsilonRule.getMenuName());
            ruleMenu.setMenuType(MenuTypeEnum.FILE.getKey());
            ruleMenu.setRuleId(rule.getRuleId());
            ruleMenuService.save(ruleMenu);

            return RuleMenuConvert.INSTANCE.convert(ruleMenu);
        }

        EpsilonRule rule = getById(ruleId);
        rule.setRuleDesc(epsilonRule.getRuleDesc());
        rule.setEnable(epsilonRule.getEnable());
        // 将规则停用时
        if (!epsilonRule.getEnable()) {
            // 重置校验状态
            rule.setValidated(false);
            // 删除 epsilonChain
            chainService.remove(new LambdaQueryWrapper<EpsilonChain>().eq(EpsilonChain::getChainName, rule.getChainName()));
            // 删除 epsilonScript
            List<String> nodeIdList = nodeService.list(new LambdaQueryWrapper<EpsilonNode>().eq(EpsilonNode::getRuleId, ruleId))
                    .stream().filter(i -> !NodeTypeEnum.STARTNODE.getKey().equals(i.getShape())).map(i -> i.getNodeId()).toList();
            scriptService.remove(new LambdaQueryWrapper<EpsilonScript>().in(EpsilonScript::getScriptId, nodeIdList));
        } else {
            chainService.update(new LambdaUpdateWrapper<EpsilonChain>().eq(EpsilonChain::getChainName, rule.getChainName())
                    .set(EpsilonChain::getEnable, true));
        }
        updateById(rule);

        LambdaQueryWrapper<RuleMenu> queryWrapper = new LambdaQueryWrapper<RuleMenu>()
                .eq(RuleMenu::getRuleId, epsilonRule.getRuleId()).last("LIMIT 1");
        RuleMenu ruleMenu = ruleMenuService.getOne(queryWrapper);
        ruleMenu.setMenuName(epsilonRule.getMenuName());
        ruleMenuService.updateById(ruleMenu);
        return RuleMenuConvert.INSTANCE.convert(ruleMenu);
    }

    @Override
    @Transactional
    public void validate(EpsilonGraphVo epsilonGraph) {
        EpsilonRule epsilonRule = getById(epsilonGraph.getRuleId());
        List<EpsilonNodeVo> nodes = epsilonGraph.getNodes();

        // 获取El表达式
        String el = new EpsilonGraphParser(epsilonGraph).parse().toEL(true);

        // 保存 epsilonScript 注意这里要忽略 STARTNODE 节点
        List<EpsilonScript> scriptList = nodes.stream().filter(i -> !NodeTypeEnum.STARTNODE.getKey().equals(i.getShape())).map(EpsilonNodeConvert.INSTANCE::convertToScript).toList();
        scriptService.saveBatch(scriptList);

        // 保存 epsilonChain
        EpsilonChain epsilonChain = EpsilonRuleConvert.INSTANCE.convertToChain(epsilonRule);
        epsilonChain.setElData(el);
        epsilonChain.setEnable(false);
        chainService.save(epsilonChain);

        // 更新图信息
        updateGraph(epsilonGraph);

        // 更新 epsilonRule
        epsilonRule.setValidated(true);
        updateById(epsilonRule);
    }
}
