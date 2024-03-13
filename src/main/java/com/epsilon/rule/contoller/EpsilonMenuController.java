package com.epsilon.rule.contoller;

import com.epsilon.rule.domain.CommonResult;
import com.epsilon.rule.domain.vo.EpsilonMenuVo;
import com.epsilon.rule.service.IEpsilonMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 前端控制器
 * </p>
 *
 * @author eitan
 * @since 2024-02-20
 */
@RestController
@RequestMapping("/epsilon/menu")
public class EpsilonMenuController {
    private final IEpsilonMenuService epsilonMenuService;

    @Autowired
    public EpsilonMenuController(IEpsilonMenuService epsilonMenuService) {
        this.epsilonMenuService = epsilonMenuService;
    }

    @GetMapping("/tree")
    public CommonResult<List<EpsilonMenuVo>> selectMenuTree(@RequestParam("projectId") Integer projectId,
                                                            @RequestParam("menuCategory") String menuCategory) {
        return CommonResult.success(epsilonMenuService.selectMenuTree(projectId, menuCategory));
    }
}
