package com.ying.springboot.controller;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Result;
import com.ying.springboot.entity.Course;
import com.ying.springboot.service.ICourseService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-07
 */
@RestController
@RequestMapping("/course")
public class CourseController {

        @Resource
        private ICourseService courseService;


        @GetMapping
        public Result getAll(){return Result.success(courseService.list());}
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id){return Result.success(courseService.getById(id));}
        //新增和修改
        @PostMapping
        public Result save(@RequestBody Course course){return Result.success(courseService.saveOrUpdate(course));}

        @DeleteMapping("/{id}")
        public Result delete(@PathVariable Integer id) {
                return Result.success(courseService.removeById(id));
        }

        @PostMapping("/del/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(courseService.removeByIds(ids));
        }
        //分页查询
        @GetMapping("/page")
        public Result findPage(@RequestParam String name,
                                       @RequestParam Integer pageNum,
                                        @RequestParam Integer pageSize){

        Page<Course> page=courseService.findPage(new Page<>(pageNum,pageSize),name);


        return Result.success(page);

        }





}

