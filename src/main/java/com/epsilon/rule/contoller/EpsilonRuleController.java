package com.epsilon.rule.contoller;

import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.vo.*;
import com.epsilon.rule.parser.EpsilonGraphParser;
import com.epsilon.rule.service.IEpsilonRuleService;
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


    @PostMapping("saveOrUpdate")
    public CommonResult<EpsilonMenuVo> saveOrUpdateRule(@RequestBody EpsilonRuleVo epsilonRule) {
        return CommonResult.success(epsilonRuleService.saveOrUpdateRule(epsilonRule));
    }

    @PostMapping("/buildEL")
    public CommonResult<String> buildEL(@RequestBody EpsilonGraphVo epsilonGraph) {
        String el = new EpsilonGraphParser(epsilonGraph).parse().toEL(true);
        System.out.println(el);
        return CommonResult.success(el);
    }

    @PostMapping("/validate")
    public CommonResult<String> validate(@RequestBody EpsilonGraphVo epsilonGraph) {
        epsilonRuleService.validate(epsilonGraph);
        return CommonResult.success();
    }
}
