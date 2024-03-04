package com.epsilon.rule.domain.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;

@Data
public class EpsilonEdgeVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 边的ID，唯一标识一条边
     */
    private String edgeId;

    /**
     * 规则ID，关联到特定的规则
     */
    private Integer ruleId;

    /**
     * 起始节点ID
     */
    private String sourceId;

    /**
     * 目标节点ID
     */
    private String targetId;
}
