package com.epsilon.rule.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.epsilon.rule.domain.BaseEntity;
import lombok.Getter;
import lombok.Setter;

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
@TableName("epsilon_rule")
public class EpsilonRule extends BaseEntity {

    @TableId(value = "rule_id", type = IdType.AUTO)
    private Integer ruleId;

    /**
     * 规则链名称
     */
    private String chainName;

    /**
     * 规则描述
     */
    private String ruleDesc;
}
