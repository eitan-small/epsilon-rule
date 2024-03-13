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
 * @since 2024-02-20
 */
@Getter
@Setter
@TableName("epsilon_menu")
public class EpsilonMenu extends BaseEntity {

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
     * 菜单类型 1:目录 | 2:文件
     */
    private String menuType;

    /**
     * 菜单种类 1:规则菜单 | 2:模型菜单
     */
    private String menuCategory;

    /**
     * 规则ID，关联到特定的规则
     */
    private Integer ruleId;

    /**
     * 父菜单ID，指向上级菜单的ID
     */
    private Integer parentId;
}
