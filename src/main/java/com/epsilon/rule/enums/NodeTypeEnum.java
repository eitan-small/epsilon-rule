package com.epsilon.rule.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum NodeTypeEnum implements Enumerable<String,String> {

    START_NODE("start-node","开始节点"),
    END_NODE("end-node","结束节点"),
    SWITCH_NODE("switch-node","条件分支节点"),
    CALCULATE_NODE("calculate-node","赋值运算节点");

    private final String key;
    private final String value;
}
