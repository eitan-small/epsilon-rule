package com.epsilon.rule.convert.node;

import com.epsilon.rule.domain.entity.EpsilonNode;
import com.epsilon.rule.domain.entity.EpsilonScript;
import com.epsilon.rule.domain.vo.EpsilonNodeVo;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.Mappings;
import org.mapstruct.factory.Mappers;

@Mapper
public interface EpsilonNodeConvert {
    EpsilonNodeConvert INSTANCE = Mappers.getMapper(EpsilonNodeConvert.class);

    EpsilonNode convert(EpsilonNodeVo epsilonEdgeVo);

    EpsilonNodeVo convert(EpsilonNode epsilonEdge);

    @Mappings({
            @Mapping(source = "nodeId", target = "scriptId"),
            @Mapping(source = "label", target = "scriptName"),
            @Mapping(source = "epsilonScript", target = "scriptData")
    })
    EpsilonScript convertToScript(EpsilonNodeVo epsilonEdgeVo);
}
