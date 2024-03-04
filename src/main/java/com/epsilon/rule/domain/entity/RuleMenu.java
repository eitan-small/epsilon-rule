package com.epsilon.rule.domain.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.epsilon.rule.domain.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import java.io.Serial;
import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author eitan
 * @since 2024-02-20
 */
@Getter
@Setter
@TableName("rule_menu")
public class RuleMenu extends BaseEntity {

    /**
     * 菜单ID
     */
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    /**
     * 项目ID
     */
    private Integer projectId;

    /**
     * 菜单名称
     */
    private String menuName;

    /**
     * 菜单类型 1:目录 | 2:名称
     */
    private String menuType;

    /**
     * 规则ID，关联到特定的规则
     */
    private Integer ruleId;

    /**
     * 父菜单ID，指向上级菜单的ID
     */
    private Integer parentId;
}
