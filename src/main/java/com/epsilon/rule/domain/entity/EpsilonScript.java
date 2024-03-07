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
@TableName("epsilon_script")
public class EpsilonScript {

    /**
     * 脚本ID
     */
    @TableId("script_id")
    private String scriptId;

    /**
     * 应用名称
     */
    private String applicationName;

    /**
     * 脚本名称
     */
    private String scriptName;

    /**
     * 脚本数据
     */
    private String scriptData;

    /**
     * 脚本类型
     */
    private String scriptType;

    /**
     * 脚本语言
     */
    private String scriptLanguage;

    /**
     * 是否启用，默认为1（启用）
     */
    private Boolean enable;
}
