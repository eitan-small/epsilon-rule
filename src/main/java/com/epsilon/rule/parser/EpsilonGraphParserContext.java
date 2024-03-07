package com.epsilon.rule.parser;

import com.epsilon.rule.domain.vo.EpsilonEdgeVo;
import com.epsilon.rule.domain.vo.EpsilonNodeVo;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class EpsilonGraphParserContext {

    /**
     * sourceId 映射边的集合
     * sourceId-> List<EpsilonEdgeVo>
     */
    Map<String, List<EpsilonEdgeVo>> sourceNodeToEdgesMap;

    /**
     *  所有的节点
     */
    Map<String, EpsilonNodeVo> nodeMap;

    /**
     * 真实初始节点 ID
     */
    String startNodeId;
}
