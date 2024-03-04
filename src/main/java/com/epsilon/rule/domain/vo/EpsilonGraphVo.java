package com.epsilon.rule.domain.vo;

import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.List;

@Data
public class EpsilonGraphVo implements Serializable {

    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 规则 id
     */
    private Integer ruleId;

    /**
     * 节点列表
     */
    private List<EpsilonNodeVo> nodes;

    /**
     * 边列表
     */
    private List<EpsilonEdgeVo> edges;

}
