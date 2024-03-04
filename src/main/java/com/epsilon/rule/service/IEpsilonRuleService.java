package com.epsilon.rule.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.entity.EpsilonRule;
import com.epsilon.rule.domain.vo.EpsilonGraphVo;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;

public interface IEpsilonRuleService extends IService<EpsilonRule> {
    CommonResult<EpsilonRuleResponse> execute(EpsilonRuleRequest request);

    void updateGraph(EpsilonGraphVo epsilonGraph);

    EpsilonGraphVo selectGraph(Integer ruleId);
}
