package com.epsilon.rule.domain.entity;

import com.baomidou.mybatisplus.annotation.TableField;
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
 * @since 2024-03-08
 */
@Getter
@Setter
@TableName("epsilon_chain")
public class EpsilonChain {

    /**
     * 规则链名称
     */
    @TableId("chain_name")
    private String chainName;

    /**
     * 应用名称
     */
    private String applicationName;

    /**
     * 规则链描述
     */
    private String chainDesc;

    /**
     * EL表达式
     */
    private String elData;

    /**
     * 是否启用，默认为1（启用）
     */
    private Boolean enable;
}
