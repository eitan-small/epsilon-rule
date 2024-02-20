package com.epsilon.rule.contoller;

import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.vo.EpsilonRuleRequest;
import com.epsilon.rule.domain.vo.EpsilonRuleResponse;
import com.epsilon.rule.domain.vo.RuleMenuVo;
import com.epsilon.rule.service.IRuleMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author eitan
 * @since 2024-02-20
 */
@RestController
@RequestMapping("/rule/menu")
public class RuleMenuController {
    private final IRuleMenuService ruleMenuService;

    @Autowired
    public RuleMenuController(IRuleMenuService ruleMenuService) {
        this.ruleMenuService = ruleMenuService;
    }

    @GetMapping("/tree")
    public CommonResult<List<RuleMenuVo>> selectMenuTree(@RequestParam("projectId") String projectId) {
        return CommonResult.success(ruleMenuService.selectMenuTree(projectId));
    }
}
