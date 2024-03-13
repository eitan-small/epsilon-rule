package com.epsilon.rule.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.epsilon.rule.domain.entity.EpsilonMenu;
import com.epsilon.rule.domain.vo.EpsilonMenuVo;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author eitan
 * @since 2024-02-20
 */
public interface IEpsilonMenuService extends IService<EpsilonMenu> {

    List<EpsilonMenuVo> selectMenuTree(Integer projectId, String menuCategory);

    EpsilonMenu selectRuleMenu(Integer ruleId);
}
