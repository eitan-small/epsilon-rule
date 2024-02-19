package com.epsilon.rule.service.impl;

import com.epsilon.rule.context.InputContext;
import com.epsilon.rule.context.OutputContext;
import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.StepDetail;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;
import com.epsilon.rule.service.IEpsilonRuleService;
import com.yomahub.liteflow.core.FlowExecutor;
import com.yomahub.liteflow.flow.LiteflowResponse;
import com.yomahub.liteflow.flow.entity.CmpStep;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.LinkedList;
import java.util.Queue;
import java.util.stream.Collectors;

@Service
public class EpsilonRuleServiceImpl implements IEpsilonRuleService {
    private FlowExecutor flowExecutor;

    @Autowired
    public EpsilonRuleServiceImpl(FlowExecutor flowExecutor) {
        this.flowExecutor = flowExecutor;
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
}
