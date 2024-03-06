package com.epsilon.rule.domain.vo;

import lombok.Data;

@Data
public class EpsilonRuleVo {

    /**
     * 规则ID
     */
    private Integer ruleId;

    /**
     * 规则ID
     */
    private Integer projectId;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 规则链名称
     */
    private String chainName;

    /**
     * 规则描述
     */
    private String ruleDesc;

    /**
     * 是否启用，默认为0（未启用）
     */
    private Boolean enable;

    /**
     * 是否校验，默认为0（未校验）
     */
    private Boolean validated;
}
