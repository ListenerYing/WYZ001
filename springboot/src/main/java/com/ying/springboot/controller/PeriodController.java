package com.ying.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Constants;
import com.ying.springboot.common.Result;
import com.ying.springboot.controller.dto.UserDTO;
import com.ying.springboot.entity.Deadline;
import com.ying.springboot.entity.User;
import com.ying.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

import com.ying.springboot.service.IPeriodService;
import com.ying.springboot.entity.Period;


import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应健霆
 * @since 2024-04-20
 */
@RestController
@RequestMapping("/period")
public class PeriodController {

        @Resource
        private IPeriodService periodService;


        @GetMapping
        public Result getAll(){return Result.success(periodService.list());}
        //根据id查询
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id){return Result.success(periodService.getById(id));}
        //新增和修改
        @PostMapping
        public Result save(@RequestBody Period period){return Result.success(periodService.saveOrUpdate(period));}

        @DeleteMapping("/{id}")
        public Result delete(@PathVariable Integer id) {
                return Result.success(periodService.removeById(id));
        }

        @PostMapping("/del/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(periodService.removeByIds(ids));
        }
        //分页查询
        @GetMapping("/page")
        public Result findPage(@RequestParam Integer pageNum,
                                        @RequestParam Integer pageSize){

        IPage<Period> page=new Page<>(pageNum,pageSize);
        QueryWrapper<Period> queryWrapper=new QueryWrapper<>();

        return Result.success(periodService.page(page,queryWrapper));

        }


        @GetMapping("/active")
        public Result getActivePeriod() {
                QueryWrapper<Period> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("is_active", 1); // 假设数据库中 is_active=1 表示激活状态
                Period activePeriod = periodService.getOne(queryWrapper);

                if (activePeriod != null) {
                        return Result.success(activePeriod);
                } else {
                        return Result.error(Constants.CODE_400, "当前没有激活的Deadline。");
                }
        }


}

