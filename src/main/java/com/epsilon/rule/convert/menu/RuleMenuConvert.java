package com.epsilon.rule.convert.menu;

import com.epsilon.rule.domain.entity.RuleMenu;
import com.epsilon.rule.domain.vo.RuleMenuVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface RuleMenuConvert {
    RuleMenuConvert INSTANCE = Mappers.getMapper(RuleMenuConvert.class);

    RuleMenuVo convert(RuleMenu ruleMenu);
}
