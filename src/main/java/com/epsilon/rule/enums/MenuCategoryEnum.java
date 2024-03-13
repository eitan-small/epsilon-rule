package com.epsilon.rule.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum MenuCategoryEnum implements Enumerable<String, String> {
    DIRECTORY("1", "规则菜单"),
    FILE("2", "模型菜单");

    private final String key;
    private final String value;
}
