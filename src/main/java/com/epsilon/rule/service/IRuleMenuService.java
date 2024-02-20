package com.epsilon.rule.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.entity.RuleMenu;
import com.epsilon.rule.domain.vo.RuleMenuVo;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author eitan
 * @since 2024-02-20
 */
public interface IRuleMenuService extends IService<RuleMenu> {

    List<RuleMenuVo> selectMenuTree(String projectId);
}
