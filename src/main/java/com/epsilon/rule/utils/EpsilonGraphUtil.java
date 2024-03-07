package com.epsilon.rule.utils;

import com.epsilon.rule.domain.vo.EpsilonEdgeVo;
import com.epsilon.rule.domain.vo.EpsilonNodeVo;

import java.util.*;

public class EpsilonGraphUtil {
    public static boolean hasCycle(List<EpsilonNodeVo> nodes, List<EpsilonEdgeVo> edges) {
        // 构建图的邻接表
        Map<String, List<String>> graph = new HashMap<>();
        for (EpsilonEdgeVo edge : edges) {
            graph.putIfAbsent(edge.getSourceId(), new ArrayList<>());
            graph.get(edge.getSourceId()).add(edge.getTargetId());
        }

        Set<String> visited = new HashSet<>();
        Set<String> recStack = new HashSet<>();

        for (EpsilonNodeVo node : nodes) {
            if (dfs(node.getNodeId(), graph, visited, recStack)) {
                return true;
            }
        }
        return false;
    }

    private static boolean dfs(String nodeId, Map<String, List<String>> graph, Set<String> visited, Set<String> recStack) {
        if (recStack.contains(nodeId)) {
            // 发现环
            return true;
        }
        if (visited.contains(nodeId)) {
            // 已访问过此节点，未发现环
            return false;
        }

        visited.add(nodeId);
        recStack.add(nodeId);

        List<String> neighbours = graph.get(nodeId);
        if (neighbours != null) {
            for (String neighbour : neighbours) {
                if (dfs(neighbour, graph, visited, recStack)) {
                    return true;
                }
            }
        }

        // 移除递归栈
        recStack.remove(nodeId);
        return false;
    }

    // 使用BFS来检查是否所有节点都能从start-node访问到
    public static boolean allNodesReachableFromStartNode(String startNodeId, List<EpsilonNodeVo> nodes, List<EpsilonEdgeVo> edges) {
        Map<String, List<String>> graph = new HashMap<>();
        edges.forEach(edge -> {
            graph.computeIfAbsent(edge.getSourceId(), k -> new ArrayList<>()).add(edge.getTargetId());
        });

        Set<String> visited = new HashSet<>();
        Queue<String> queue = new LinkedList<>();
        queue.offer(startNodeId);
        visited.add(startNodeId);

        while (!queue.isEmpty()) {
            String current = queue.poll();
            List<String> neighbours = graph.get(current);
            if (neighbours != null) {
                for (String neighbour : neighbours) {
                    if (!visited.contains(neighbour)) {
                        visited.add(neighbour);
                        queue.offer(neighbour);
                    }
                }
            }
        }

        // 检查是否所有节点都被访问
        return nodes.stream().allMatch(node -> visited.contains(node.getNodeId()));
    }
}
