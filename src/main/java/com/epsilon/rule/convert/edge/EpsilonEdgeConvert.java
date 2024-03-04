package com.epsilon.rule.convert.edge;

import com.epsilon.rule.domain.entity.EpsilonEdge;
import com.epsilon.rule.domain.vo.EpsilonEdgeVo;
import org.mapstruct.Mapper;
import org.mapstruct.factory.Mappers;

@Mapper
public interface EpsilonEdgeConvert {
    EpsilonEdgeConvert INSTANCE = Mappers.getMapper(EpsilonEdgeConvert.class);

    EpsilonEdge convert(EpsilonEdgeVo epsilonEdgeVo);

    EpsilonEdgeVo convert(EpsilonEdge epsilonEdge);
}
