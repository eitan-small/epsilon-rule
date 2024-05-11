package com.epsilon.rule.parser;


import com.epsilon.rule.domain.vo.EpsilonEdgeVo;
import com.epsilon.rule.domain.vo.EpsilonGraphVo;
import com.epsilon.rule.domain.vo.EpsilonNodeVo;
import com.epsilon.rule.enums.NodeTypeEnum;
import com.epsilon.rule.exception.ServiceException;
import com.epsilon.rule.utils.EpsilonGraphUtil;
import com.yomahub.liteflow.builder.el.ELBus;
import com.yomahub.liteflow.builder.el.ELWrapper;
import org.springframework.util.CollectionUtils;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

public class EpsilonGraphParser {
    /**
     * 带解析的数据
     */
    private final EpsilonGraphVo epsilonGraph;

    /**
     * 上下文
     */
    private EpsilonGraphParserContext context;

    public EpsilonGraphParser(EpsilonGraphVo epsilonGraph) {
        this.epsilonGraph = epsilonGraph;
        this.context = new EpsilonGraphParserContext();
    }

    public ELWrapper parse() {
        List<EpsilonNodeVo> nodes = epsilonGraph.getNodes();
        List<EpsilonEdgeVo> edges = epsilonGraph.getEdges();

        // 校验图的合法性
        EpsilonNodeVo startNode = validateGraph(nodes, edges);

        // 补全 context 信息
        Map<String, List<EpsilonEdgeVo>> sourceNodeToEdgesMap = edges.stream().collect(Collectors.groupingBy(EpsilonEdgeVo::getSourceId));
        Map<String, EpsilonNodeVo> nodeMap = nodes.stream().collect(Collectors.toMap(EpsilonNodeVo::getNodeId, Function.identity()));
        context.setSourceNodeToEdgesMap(sourceNodeToEdgesMap);
        context.setNodeMap(nodeMap);

        // start-node只起到标记的作用，是空实现，因此获取真实的第一节点
        String startNodeId = sourceNodeToEdgesMap.get(startNode.getNodeId()).get(0).getTargetId();

        return doBuild(startNodeId);
    }

    private ELWrapper doBuild(String currentId) {
        Map<String, EpsilonNodeVo> nodeMap = context.getNodeMap();
        Map<String, List<EpsilonEdgeVo>> sourceNodeToEdgesMap = context.getSourceNodeToEdgesMap();

        EpsilonNodeVo node = nodeMap.get(currentId);
        List<EpsilonEdgeVo> neighbours = sourceNodeToEdgesMap.get(currentId);
        if (NodeTypeEnum.SWITCH_NODE.getKey().equals(node.getShape())) {
            return ELBus.switchOpt(currentId).to(neighbours.stream().map(i -> doBuild(i.getTargetId())).toArray());
        }

        List<Object> thenList = new ArrayList<>();
        thenList.add(currentId);
        while (!CollectionUtils.isEmpty(neighbours)) { String targetId = neighbours.get(0).getTargetId();
            EpsilonNodeVo targetNode = nodeMap.get(targetId);
            if (NodeTypeEnum.SWITCH_NODE.getKey().equals(targetNode.getShape())) {
                thenList.add(doBuild(targetId));
                break;
            } else {
                thenList.add(targetId);
                neighbours = sourceNodeToEdgesMap.get(targetId);
            }
        }

        return ELBus.then(thenList.toArray()).id(currentId);
    }

    private EpsilonNodeVo validateGraph(List<EpsilonNodeVo> nodes, List<EpsilonEdgeVo> edges) {
        // 只允许有一个start-node
        List<EpsilonNodeVo> startNodes = nodes.stream().filter(i -> NodeTypeEnum.START_NODE.getKey().equals(i.getShape())).toList();
        if (startNodes.size() != 1) {
            throw new ServiceException(String.format("验证失败：期望有一个开始节点，但找到了 %d 个。", startNodes.size()));
        }

        // 检查是否有环
        if (EpsilonGraphUtil.hasCycle(nodes, edges)) {
            throw new ServiceException("验证失败：图中存在环。");
        }

        // 检查是否有节点不在start-node的链上
        if (!EpsilonGraphUtil.allNodesReachableFromStartNode(startNodes.get(0).getNodeId(), nodes, edges)) {
            throw new ServiceException("验证失败：存在节点不在开始节点的链上。");
        }

        return startNodes.get(0);
    }


}
