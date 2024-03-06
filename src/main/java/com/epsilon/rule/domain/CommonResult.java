package com.epsilon.rule.domain;

import cn.hutool.core.util.StrUtil;
import lombok.Data;
import org.springframework.http.HttpStatus;

import java.io.Serial;
import java.io.Serializable;

@Data
public class CommonResult<T> implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    /**
     * 成功
     */
    public static final int SUCCESS = HttpStatus.OK.value();

    /**
     * 失败
     */
    public static final int ERROR = HttpStatus.INTERNAL_SERVER_ERROR.value();

    /**
     * 状态码
     */
    private int code;

    /**
     * 返回信息
     */
    private String message;

    /**
     * 数据对象
     */
    private T data;

    public static <T> CommonResult<T> success() {
        return restResult(null, SUCCESS, StrUtil.EMPTY);
    }

    public static <T> CommonResult<T> success(T data) {
        return restResult(data, SUCCESS, StrUtil.EMPTY);
    }

    public static <T> CommonResult<T> success(T data, String msg) {
        return restResult(data, SUCCESS, msg);
    }

    public static <T> CommonResult<T> error() {
        return restResult(null, ERROR, StrUtil.EMPTY);
    }

    public static <T> CommonResult<T> error(String msg) {
        return restResult(null, ERROR, msg);
    }

    public static <T> CommonResult<T> error(int code, String msg) {
        return restResult(null, code, msg);
    }

    public static <T> CommonResult<T> error(T data, String msg) {
        return restResult(data, ERROR, msg);
    }

    private static <T> CommonResult<T> restResult(T data, int code, String msg) {
        CommonResult<T> apiResult = new CommonResult<>();
        apiResult.setCode(code);
        apiResult.setData(data);
        apiResult.setMessage(msg);
        return apiResult;
    }
}