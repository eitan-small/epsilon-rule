package com.epsilon.rule.domain.vo;

import com.yomahub.liteflow.enums.CmpStepTypeEnum;
import lombok.Data;

import java.io.Serial;
import java.io.Serializable;
import java.util.Date;

@Data
public class StepDetail implements Serializable {
    @Serial
    private static final long serialVersionUID = 1L;

    private String nodeId;

    private String nodeName;

    private String tag;

    private CmpStepTypeEnum stepType;

    private Date startTime;

    private Date endTime;

    // 消耗的时间，毫秒为单位
    private Long timeSpent;

    // 是否成功
    private boolean success;

    // 回滚消耗的时间
    private Long rollbackTimeSpent;
}
