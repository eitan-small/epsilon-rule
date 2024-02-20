package com.epsilon.rule.domain.vo;

import com.yomahub.liteflow.core.NodeComponent;
import com.yomahub.liteflow.enums.CmpStepTypeEnum;
import com.yomahub.liteflow.flow.element.Node;
import lombok.Data;

import java.util.Date;

@Data
public class StepDetail {
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

    // 有exception，success一定为false
    // 但是success为false，不一定有exception，因为有可能没执行到，或者没执行结束(any)
    private Exception exception;

    // 回滚消耗的时间
    private Long rollbackTimeSpent;
}
