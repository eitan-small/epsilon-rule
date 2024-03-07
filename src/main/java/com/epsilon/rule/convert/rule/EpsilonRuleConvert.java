package com.epsilon.rule.convert.rule;

import com.epsilon.rule.domain.entity.EpsilonChain;
import com.epsilon.rule.domain.entity.EpsilonRule;
import com.epsilon.rule.domain.vo.EpsilonRuleVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;

@Mapper
public interface EpsilonRuleConvert {
    EpsilonRuleConvert INSTANCE = Mappers.getMapper(EpsilonRuleConvert.class);

    EpsilonRuleVo convert(EpsilonRule epsilonRule);

    @Mapping(source = "ruleDesc", target = "chainDesc")
    EpsilonChain convertToChain(EpsilonRule epsilonRule);
}
