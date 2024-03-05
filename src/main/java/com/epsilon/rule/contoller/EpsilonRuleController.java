package com.epsilon.rule.contoller;

import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.vo.EpsilonGraphVo;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;
import com.epsilon.rule.domain.vo.EpsilonRuleVo;
import com.epsilon.rule.service.IEpsilonRuleService;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @PostMapping("/updateGraph")
    public CommonResult<String> updateGraph(@RequestBody EpsilonGraphVo epsilonGraph) {
        epsilonRuleService.updateGraph(epsilonGraph);
        return CommonResult.success();
    }

    @GetMapping("/selectGraph")
    public CommonResult<EpsilonGraphVo> selectGraph(@RequestParam("ruleId") Integer ruleId) {
        return CommonResult.success(epsilonRuleService.selectGraph(ruleId));
    }

    @GetMapping("/select")
    public CommonResult<EpsilonRuleVo> selectRule(@RequestParam("ruleId") Integer ruleId) {
        return CommonResult.success(epsilonRuleService.selectRule(ruleId));
    }
}
