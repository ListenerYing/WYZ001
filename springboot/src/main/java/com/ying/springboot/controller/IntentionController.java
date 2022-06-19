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

import com.ying.springboot.service.IIntentionService;
import com.ying.springboot.entity.Intention;


import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-19
 */
@RestController
@RequestMapping("/intention")
public class IntentionController {

        @Resource
        private IIntentionService intentionService;


        @GetMapping
        public Result getAll(){return Result.success(intentionService.list());}
        //根据id查询
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id){return Result.success(intentionService.getById(id));}
        //新增和修改
        @PostMapping
        public Result save(@RequestBody Intention intention){return Result.success(intentionService.saveOrUpdate(intention));}

        @DeleteMapping("/{id}")
        public Result delete(@PathVariable Integer id) {
                return Result.success(intentionService.removeById(id));
        }

        @PostMapping("/del/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(intentionService.removeByIds(ids));
        }
        //分页查询
        @GetMapping("/page")
        public Result findPage(@RequestParam Integer pageNum,
                                        @RequestParam Integer pageSize){

        IPage<Intention> page=new Page<>(pageNum,pageSize);
        QueryWrapper<Intention> queryWrapper=new QueryWrapper<>();

        return Result.success(intentionService.page(page,queryWrapper));

        }





}

