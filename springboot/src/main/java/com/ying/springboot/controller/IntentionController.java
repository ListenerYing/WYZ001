package com.ying.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Result;
import com.ying.springboot.entity.User;
import com.ying.springboot.mapper.IntentionMapper;
import com.ying.springboot.service.UserService;
import io.swagger.models.auth.In;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.Console;
import java.util.List;
import java.util.concurrent.TimeUnit;

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
@Transactional(isolation = Isolation.SERIALIZABLE )
@RestController
@RequestMapping("/intention")
public class IntentionController {

        @Resource
        private IIntentionService intentionService;
        @Resource
        private UserService userService;


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
                                        @RequestParam Integer pageSize,
                                        @RequestParam (defaultValue="") Integer id) {

//        IPage<Intention> page=new Page<>(pageNum,pageSize);
        QueryWrapper<Intention> queryWrapper=new QueryWrapper<>();
        queryWrapper.orderByAsc("sequence");
                queryWrapper.eq("student_id",id);

        Page<Intention> page=intentionService.page(new Page<>(pageNum,pageSize),queryWrapper);

                List<Intention> records=page.getRecords();
                for (Intention record :records){
                        User user = userService.getById(record.getTeacherId());
                        if (user!=null){
                                record.setTeacherName(user.getNickname());
                        }
                }
        return Result.success(records);

        }
        //添加志愿
        @GetMapping("/addIntention")
        public Result addIntention(@RequestParam Integer student_id,
                                   @RequestParam Integer teacher_id){
                QueryWrapper<Intention> queryWrapper=new QueryWrapper<>();
                queryWrapper.eq("student_id",student_id);
                List<Intention> intentionList=intentionService.list(queryWrapper);

                Intention intention=new Intention();
                intention.setStudentId(student_id);
                intention.setTeacherId(teacher_id);
                intention.setSequence(intentionList.size()+1);





                return Result.success(intentionService.save(intention));


        }

        //根据学生id和志愿顺序修改,把小的加1
        @GetMapping("/plus")
        public Result sequencePlus(@RequestParam Integer studentId,
                                   @RequestParam  Integer sequence){

                UpdateWrapper<Intention> updateWrapper=new UpdateWrapper<>();
                updateWrapper.eq("student_id",studentId)
                        .eq("sequence",sequence-1);
                updateWrapper.set("sequence",sequence);
                return Result.success();

        }
        //根据id修改志愿顺序,把大的减小1
        @GetMapping("/intentionUp")
        public Result sequenceReduce(@RequestParam Integer id,
                                     @RequestParam Integer studentId,
                                     @RequestParam Integer sequence) {
                UpdateWrapper<Intention> plusWrapper=new UpdateWrapper<>();
                plusWrapper.eq("student_id",studentId)
                        .eq("sequence",sequence-1);
                plusWrapper.set("sequence",sequence);
                intentionService.update(null, plusWrapper);
                UpdateWrapper<Intention> reduceWrapper=new UpdateWrapper<>();
                reduceWrapper.eq("id",id);

                reduceWrapper.set("sequence",sequence-1);

                return Result.success(intentionService.update(null, reduceWrapper));

        }
        //根据学生id和志愿顺序修改,
//        @PostMapping("/change/{id}/{sequence}")
//        public Result sequenceChange(@PathVariable Integer id,
//                                    @PathVariable  Integer sequence){
//
//                UpdateWrapper<Intention> updateWrapper=new UpdateWrapper<>();
//                updateWrapper.orderByAsc("sequence");
//                updateWrapper.eq("student_id",id)
//                        .eq("sequence",sequence-1)
//                        .or()
//                        .eq("student_id",id)
//                        .eq("sequence",sequence);
//                updateWrapper.set("sequence",sequence);
//                return Result.success(intentionService.update(null, updateWrapper));
//
//        }

        //志愿前移
        @GetMapping("/push/{id}")
        public Result sequencePush(@PathVariable Integer id){
              QueryWrapper<Intention> queryWrapper=new QueryWrapper<>();
              queryWrapper.eq("student_id",id)
                      .eq("sequence",1);
                Intention intention=intentionService.getOne(queryWrapper);
                Integer sid=intention.getStudentId();
                Integer seq=intention.getSequence();
                UpdateWrapper<Intention> updateWrapper=new UpdateWrapper<>();
//                updateWrapper.orderByAsc("sequence");
                updateWrapper.eq("student_id",sid)
                        .gt("sequence",seq)
                .setSql("sequence=sequence-1");
                intentionService.update(null, updateWrapper);





                return Result.success(intentionService.removeById(intention.getId()));
        }





}

