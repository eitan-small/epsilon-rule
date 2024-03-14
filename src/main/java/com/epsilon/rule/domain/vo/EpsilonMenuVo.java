package com.epsilon.rule.domain.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

@Data
public class EpsilonMenuVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 菜单ID
     */
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
    private Integer associateId;

    /**
     * 父菜单ID，指向上级菜单的ID
     */
    private Integer parentId;

    /**
     * 子节点
     */
    private List<EpsilonMenuVo> children;
}
