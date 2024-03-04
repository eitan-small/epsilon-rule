package com.epsilon.rule.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.epsilon.rule.context.InputContext;
import com.epsilon.rule.context.OutputContext;
import com.epsilon.rule.convert.edge.EpsilonEdgeConvert;
import com.epsilon.rule.convert.node.EpsilonNodeConvert;
import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.entity.EpsilonEdge;
import com.epsilon.rule.domain.entity.EpsilonNode;
import com.epsilon.rule.domain.entity.EpsilonRule;
import com.epsilon.rule.domain.vo.EpsilonGraphVo;
import com.epsilon.rule.domain.vo.StepDetail;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;
import com.epsilon.rule.mapper.EpsilonRuleMapper;
import com.epsilon.rule.service.IEpsilonEdgeService;
import com.epsilon.rule.service.IEpsilonNodeService;
import com.epsilon.rule.service.IEpsilonRuleService;
import com.yomahub.liteflow.core.FlowExecutor;
import com.yomahub.liteflow.flow.LiteflowResponse;
import com.yomahub.liteflow.flow.entity.CmpStep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
import java.util.stream.Collectors;

@Service
public class EpsilonRuleServiceImpl extends ServiceImpl<EpsilonRuleMapper, EpsilonRule> implements IEpsilonRuleService {
    private final FlowExecutor flowExecutor;

    private final IEpsilonNodeService nodeService;

    private final IEpsilonEdgeService edgeService;

    @Autowired
    public EpsilonRuleServiceImpl(FlowExecutor flowExecutor, IEpsilonNodeService nodeService, IEpsilonEdgeService edgeService) {
        this.flowExecutor = flowExecutor;
        this.nodeService = nodeService;
        this.edgeService = edgeService;
    }

    @Override
    public CommonResult<EpsilonRuleResponse> execute(EpsilonRuleRequest request) {
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
            return CommonResult.error(exception.getMessage());
        }

        // 规则链执行成功
        EpsilonRuleResponse epsilonRuleResponse = new EpsilonRuleResponse();
        epsilonRuleResponse.setContext(liteflowResponse.getContextBean(OutputContext.class));

        // 是否获取规则执行步骤详情
        if (request.getGetStepDetail() != null && request.getGetStepDetail()) {
            Queue<CmpStep> stepQueue = liteflowResponse.getExecuteStepQueue();
            // 转化为 Queue<StepDetail> 对象
            LinkedList<StepDetail> stepDetails = stepQueue.stream().map(step -> {
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
            epsilonRuleResponse.setStepDetail(stepDetails);
        }

        // 是否获取完整上下文
        if (request.getGetFullContext() != null && request.getGetFullContext()) {
            epsilonRuleResponse.setFullContext(liteflowResponse.getContextBean(InputContext.class));
        }

        return CommonResult.success(epsilonRuleResponse);
    }

    @Override
    @Transactional
    public void updateGraph(EpsilonGraphVo epsilonGraph) {
        Integer ruleId = epsilonGraph.getRuleId();
        List<EpsilonNode> nodeList = epsilonGraph.getNodes().stream().map(EpsilonNodeConvert.INSTANCE::convert).toList();
        List<EpsilonEdge> edgeList = epsilonGraph.getEdges().stream().map(EpsilonEdgeConvert.INSTANCE::convert).toList();

        // 先删除旧数据
        nodeService.remove(new LambdaQueryWrapper<EpsilonNode>().eq(EpsilonNode::getRuleId, ruleId));
        edgeService.remove(new LambdaQueryWrapper<EpsilonEdge>().eq(EpsilonEdge::getRuleId, ruleId));

        // 添加新数据
        nodeService.saveBatch(nodeList);
        edgeService.saveBatch(edgeList);
    }
}
