package com.epsilon.rule.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum NodeTypeEnum implements Enumerable<String,String> {

    STARTNODE("start-node","开始节点"),
    ENDNODE("end-node","结束节点"),
    SWITCHNODE("switch-node","条件分支节点"),
    CALCULATENODE("calculate-node","赋值运算节点");

    private final String key;
    private final String value;
}
