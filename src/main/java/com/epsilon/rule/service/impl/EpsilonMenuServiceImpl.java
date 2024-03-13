package com.epsilon.rule.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.epsilon.rule.convert.menu.EpsilonMenuConvert;
import com.epsilon.rule.domain.entity.EpsilonMenu;
import com.epsilon.rule.domain.vo.EpsilonMenuVo;
import com.epsilon.rule.mapper.EpsilonMenuMapper;
import com.epsilon.rule.service.IEpsilonMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author eitan
 * @since 2024-02-20
 */
@Service
public class EpsilonMenuServiceImpl extends ServiceImpl<EpsilonMenuMapper, EpsilonMenu> implements IEpsilonMenuService {

    private final EpsilonMenuMapper epsilonMenuMapper;

    @Autowired
    public EpsilonMenuServiceImpl(EpsilonMenuMapper epsilonMenuMapper) {
        this.epsilonMenuMapper = epsilonMenuMapper;
    }

    @Override
    public List<EpsilonMenuVo> selectMenuTree(Integer projectId, String menuCategory) {
        // 查询出项目所有的规则菜单列表
        List<EpsilonMenu> epsilonMenuList = new LambdaQueryChainWrapper<>(epsilonMenuMapper)
                .eq(EpsilonMenu::getProjectId, projectId)
                .eq(EpsilonMenu::getMenuCategory, menuCategory).list();

        return buildMenuTree(epsilonMenuList);
    }

    @Override
    public EpsilonMenu selectRuleMenu(Integer ruleId) {
        return new LambdaQueryChainWrapper<>(epsilonMenuMapper).eq(EpsilonMenu::getRuleId, ruleId).one();
    }

    private List<EpsilonMenuVo> buildMenuTree(List<EpsilonMenu> epsilonMenuList) {
        List<EpsilonMenuVo> menuVoList = epsilonMenuList.stream().map(EpsilonMenuConvert.INSTANCE::convert).toList();

        Map<Integer, EpsilonMenuVo> menuVoMap = menuVoList.stream().collect(Collectors.toMap(EpsilonMenuVo::getId, i -> i));

        List<EpsilonMenuVo> topLevelMenuList = new ArrayList<>();

        for (EpsilonMenuVo menuVo : menuVoList) {
            Integer parentId = menuVo.getParentId();
            if (ObjectUtil.isNull(parentId) || parentId == 0) {
                topLevelMenuList.add(menuVo);
            } else {
                EpsilonMenuVo parentMenu = menuVoMap.get(parentId);
                addMenuChildren(parentMenu, menuVo);
            }
        }

        return topLevelMenuList;
    }

    private void addMenuChildren(EpsilonMenuVo parent, EpsilonMenuVo children) {
        if (parent == null) {
            return;
        }
        List<EpsilonMenuVo> childrenList = parent.getChildren();
        if (ObjectUtil.isNotNull(childrenList)) {
            childrenList.add(children);
        } else {
            childrenList = new ArrayList<>();
            childrenList.add(children);
            parent.setChildren(childrenList);
        }
    }
}
