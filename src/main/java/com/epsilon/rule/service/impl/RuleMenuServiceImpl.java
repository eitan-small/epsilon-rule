package com.epsilon.rule.service.impl;

import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.extension.conditions.query.LambdaQueryChainWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.epsilon.rule.convert.menu.RuleMenuConvert;
import com.epsilon.rule.domain.entity.RuleMenu;
import com.epsilon.rule.domain.vo.RuleMenuVo;
import com.epsilon.rule.mapper.RuleMenuMapper;
import com.epsilon.rule.service.IRuleMenuService;
import org.springframework.beans.BeanUtils;
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
public class RuleMenuServiceImpl extends ServiceImpl<RuleMenuMapper, RuleMenu> implements IRuleMenuService {

    private final RuleMenuMapper ruleMenuMapper;

    @Autowired
    public RuleMenuServiceImpl(RuleMenuMapper ruleMenuMapper) {
        this.ruleMenuMapper = ruleMenuMapper;
    }

    @Override
    public List<RuleMenuVo> selectMenuTree(Integer projectId) {
        // 查询出项目所有的规则菜单列表
        List<RuleMenu> ruleMenuList = new LambdaQueryChainWrapper<>(ruleMenuMapper).eq(RuleMenu::getProjectId, projectId).list();

        return buildMenuTree(ruleMenuList);
    }

    private List<RuleMenuVo> buildMenuTree(List<RuleMenu> ruleMenuList) {
        List<RuleMenuVo> menuVoList = ruleMenuList.stream().map(RuleMenuConvert.INSTANCE::convert).toList();

        Map<Integer, RuleMenuVo> menuVoMap = menuVoList.stream().collect(Collectors.toMap(RuleMenuVo::getId, i -> i));

        List<RuleMenuVo> topLevelMenuList = new ArrayList<>();

        for (RuleMenuVo menuVo : menuVoList) {
            Integer parentId = menuVo.getParentId();
            if (ObjectUtil.isNull(parentId) || parentId == 0) {
                topLevelMenuList.add(menuVo);
            } else {
                RuleMenuVo parentMenu = menuVoMap.get(parentId);
                addMenuChildren(parentMenu, menuVo);
            }
        }

        return topLevelMenuList;
    }

    private void addMenuChildren(RuleMenuVo parent, RuleMenuVo children) {
        if (parent == null) {
            return;
        }
        List<RuleMenuVo> childrenList = parent.getChildren();
        if (ObjectUtil.isNotNull(childrenList)) {
            childrenList.add(children);
        } else {
            childrenList = new ArrayList<>();
            childrenList.add(children);
            parent.setChildren(childrenList);
        }
    }
}
