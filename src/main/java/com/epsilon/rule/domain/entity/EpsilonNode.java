package com.epsilon.rule.domain.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.epsilon.rule.domain.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.math.BigDecimal;

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
@TableName("epsilon_node")
public class EpsilonNode extends BaseEntity {

    /**
     * 节点ID，唯一标识一个节点
     */
    @TableId("node_id")
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
