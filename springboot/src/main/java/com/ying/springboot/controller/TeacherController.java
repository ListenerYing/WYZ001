package com.ying.springboot.controller;

import com.ying.springboot.common.Result;
import com.ying.springboot.entity.Teacher;
import com.ying.springboot.service.ITeacherService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  前端控制器
 * </p>
 *
 * @author 应健霆
 * @since 2024-04-18
 */
@RestController
@RequestMapping("/teacher")
public class TeacherController {

        @Resource
        private ITeacherService teacherService;


        @GetMapping
        public Result getAll(){return Result.success(teacherService.list());}
        //根据id查询
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id){return Result.success(teacherService.getById(id));}
        //新增和修改
        @PostMapping
        public Result save(@RequestBody Teacher teacher){return Result.success(teacherService.saveOrUpdate(teacher));}

        @DeleteMapping("/{id}")
        public Result delete(@PathVariable Integer id) {
                return Result.success(teacherService.removeById(id));
        }

        @PostMapping("/del/batch")
        public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(teacherService.removeByIds(ids));
        }
        //分页查询
//        @GetMapping("/page")
//        public Result findPage(@RequestParam Integer pageNum,
//                                        @RequestParam Integer pageSize){
//
//        IPage<Teacher> page=new Page<>(pageNum,pageSize);
//        QueryWrapper<Teacher> queryWrapper=new QueryWrapper<>();
//
//        return Result.success(teacherService.page(page,queryWrapper));
//
//        }





}

