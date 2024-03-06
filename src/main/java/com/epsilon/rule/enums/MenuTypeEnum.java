package com.epsilon.rule.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum MenuTypeEnum implements Enumerable<String, String> {
    DIRECTORY("1", "目录"),
    FILE("2", "名称");

    private final String key;
    private final String value;
}
