package com.epsilon.rule.domain.vo;

import com.epsilon.rule.context.InputContext;
import lombok.Data;

@Data
public class EpsilonRuleRequest {
    /**
     * 规则链ID
     */
    private String chainId;

    /**
     * 规则上下文数据
     */
    private InputContext data;

    /**
     * 是否获取规则详情
     */
    private Boolean getStepDetail;

    /**
     * 是否获取完整上下文
     */
    private Boolean getFullContext;
}
