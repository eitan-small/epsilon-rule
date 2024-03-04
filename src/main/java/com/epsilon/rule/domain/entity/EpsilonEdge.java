package com.epsilon.rule.domain.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.epsilon.rule.domain.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author eitan
 * @since 2024-03-04
 */
@Getter
@Setter
@TableName("epsilon_edge")
public class EpsilonEdge extends BaseEntity  {

    /**
     * 边的ID，唯一标识一条边
     */
    @TableId("edge_id")
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
