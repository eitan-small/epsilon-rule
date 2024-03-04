package com.epsilon.rule.domain.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.math.BigDecimal;

@Data
public class EpsilonNodeVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 节点ID，唯一标识一个节点
     */
    private String nodeId;

    /**
     * 规则ID，关联到特定的规则
     */
    private Integer ruleId;

    /**
     * 节点类型
     */
    private String shape;

    /**
     * 节点名称
     */
    private String label;

    /**
     * 节点的X坐标位置
     */
    private BigDecimal positionX;

    /**
     * 节点的Y坐标位置
     */
    private BigDecimal positionY;

    /**
     * 节点的脚本
     */
    private String epsilonScript;
}
