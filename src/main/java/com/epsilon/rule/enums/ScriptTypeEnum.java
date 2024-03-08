package com.epsilon.rule.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ScriptTypeEnum implements Enumerable<String,String> {

    SCRIPT("script","普通脚本"),
    SWITCH_SCRIPT("switch_script","选择脚本");

    private final String key;
    private final String value;
}
