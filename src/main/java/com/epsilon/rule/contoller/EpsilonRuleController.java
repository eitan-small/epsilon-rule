package com.epsilon.rule.contoller;

import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;
import com.epsilon.rule.service.IEpsilonRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/epsilon/rule")
public class EpsilonRuleController {
    private final IEpsilonRuleService epsilonRuleService;

    @Autowired
    public EpsilonRuleController(IEpsilonRuleService epsilonRuleService) {
        this.epsilonRuleService = epsilonRuleService;
    }

    @PostMapping("/execute")
    public CommonResult<EpsilonRuleResponse> execute(@RequestBody EpsilonRuleRequest request) {
        return epsilonRuleService.execute(request);
    }
}
