package com.ying.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Result;
import com.ying.springboot.entity.Student;
import com.ying.springboot.service.IStudentService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-18
 */
@RestController
@RequestMapping("/student")
public class StudentController {

        @Resource
        private IStudentService studentService;


        @GetMapping
        public Result getAll(){return Result.success(studentService.list());}
        //根据id查询
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id){return Result.success(studentService.getById(id));}
        //新增和修改
        @PostMapping
        public Result save(@RequestBody Student student){return Result.success(studentService.saveOrUpdate(student));}

        @DeleteMapping("/{id}")
        public Result delete(@PathVariable Integer id) {
                return Result.success(studentService.removeById(id));
        }

        @PostMapping("/del/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(studentService.removeByIds(ids));
        }
        //分页查询
        @GetMapping("/page")
        public Result findPage(@RequestParam Integer pageNum,
                                        @RequestParam Integer pageSize){

        IPage<Student> page=new Page<>(pageNum,pageSize);
        QueryWrapper<Student> queryWrapper=new QueryWrapper<>();

        return Result.success(studentService.page(page,queryWrapper));

        }





}

