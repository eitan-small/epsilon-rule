package com.epsilon.rule.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.entity.EpsilonRule;
import com.epsilon.rule.domain.vo.*;

public interface IEpsilonRuleService extends IService<EpsilonRule> {
    CommonResult<EpsilonRuleResponse> execute(EpsilonRuleRequest request);

    void updateGraph(EpsilonGraphVo epsilonGraph);

    EpsilonGraphVo selectGraph(Integer ruleId);

    EpsilonRuleVo selectRule(Integer ruleId);

    EpsilonMenuVo saveOrUpdateRule(EpsilonRuleVo epsilonRule);

    void validate(EpsilonGraphVo epsilonGraph);
}
