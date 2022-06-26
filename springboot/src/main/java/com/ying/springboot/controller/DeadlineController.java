package com.ying.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Constants;
import com.ying.springboot.common.Result;
import com.ying.springboot.controller.dto.UserDTO;
import com.ying.springboot.entity.User;
import com.ying.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import java.util.List;

import com.ying.springboot.service.IDeadlineService;
import com.ying.springboot.entity.Deadline;


import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-26
 */
@RestController
@RequestMapping("/deadline")
public class DeadlineController {

        @Resource
        private IDeadlineService deadlineService;


        @GetMapping
        public Result getAll(){return Result.success(deadlineService.list());}
        //根据id查询
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id){return Result.success(deadlineService.getById(id));}
        //新增和修改
        @PostMapping
        public Result save(@RequestBody Deadline deadline){return Result.success(deadlineService.saveOrUpdate(deadline));}

        @DeleteMapping("/{id}")
        public Result delete(@PathVariable Integer id) {
                return Result.success(deadlineService.removeById(id));
        }

        @PostMapping("/del/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(deadlineService.removeByIds(ids));
        }
        //分页查询
        @GetMapping("/page")
        public Result findPage(@RequestParam Integer pageNum,
                                        @RequestParam Integer pageSize){

        IPage<Deadline> page=new Page<>(pageNum,pageSize);
        QueryWrapper<Deadline> queryWrapper=new QueryWrapper<>();

        return Result.success(deadlineService.page(page,queryWrapper));

        }





}

