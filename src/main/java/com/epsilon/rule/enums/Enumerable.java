package com.epsilon.rule.enums;

public interface Enumerable<K, V> {
    K getKey();
    V getValue();

    static <E extends Enum<E> & Enumerable<K, V>, K, V> E fromKey(Class<E> enumClass, K key) {
        for (E e : enumClass.getEnumConstants()) {
            if (e.getKey().equals(key)) {
                return e;
            }
        }
        throw new IllegalArgumentException("未知的枚举键: " + key);
    }

    static <E extends Enum<E> & Enumerable<K, V>, K, V> E fromValue(Class<E> enumClass, V value) {
        for (E e : enumClass.getEnumConstants()) {
            if (e.getValue().equals(value)) {
                return e;
            }
        }
        throw new IllegalArgumentException("未知的枚举值: " + value);
    }
}

