package com.epsilon.rule.service;

import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;

public interface IEpsilonRuleService {
    CommonResult<EpsilonRuleResponse> execute(EpsilonRuleRequest request);
}
