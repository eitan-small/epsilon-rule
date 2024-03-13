package com.epsilon.rule.convert.menu;

import com.epsilon.rule.domain.entity.EpsilonMenu;
import com.epsilon.rule.domain.vo.EpsilonMenuVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface EpsilonMenuConvert {
    EpsilonMenuConvert INSTANCE = Mappers.getMapper(EpsilonMenuConvert.class);

    EpsilonMenuVo convert(EpsilonMenu epsilonMenu);
}
