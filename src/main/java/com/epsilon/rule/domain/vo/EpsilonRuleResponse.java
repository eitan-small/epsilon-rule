package com.epsilon.rule.domain.vo;

import com.epsilon.rule.context.InputContext;
import com.epsilon.rule.context.OutputContext;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Queue;

@Data
public class EpsilonRuleResponse implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 输出上下文
     */
    private OutputContext context;

    /**
     * 规则完整上下文
     */
    private InputContext fullContext;

    /**
     * 规则链执行步骤详情
     */
    private Queue<StepDetail> stepDetail;
}
