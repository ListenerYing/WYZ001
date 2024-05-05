package com.ying.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Constants;
import com.ying.springboot.common.Result;
import com.ying.springboot.entity.Deadline;
import com.ying.springboot.entity.Period;
import com.ying.springboot.entity.User;
import com.ying.springboot.mapper.IntentionMapper;
import com.ying.springboot.service.IDeadlineService;
import com.ying.springboot.service.IPeriodService;
import com.ying.springboot.service.UserService;
import io.swagger.models.auth.In;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.io.Console;
import java.time.LocalDateTime;
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
        private IDeadlineService deadlineService;
        @Resource
        private IIntentionService intentionService;
        @Resource
        private UserService userService;

        @Resource
        private IPeriodService periodService;

        @GetMapping
        public Result getAll() {
                return Result.success(intentionService.list());
        }

        //根据id查询
        @GetMapping("/{id}")
        public Result getById(@PathVariable Integer id) {
                return Result.success(intentionService.getById(id));
        }

        //新增和修改
        @PostMapping
        public Result save(@RequestBody Intention intention) {
                return Result.success(intentionService.saveOrUpdate(intention));
        }

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
                               @RequestParam(defaultValue = "") Integer id) {

//        IPage<Intention> page=new Page<>(pageNum,pageSize);
                QueryWrapper<Intention> queryWrapper = new QueryWrapper<>();
                queryWrapper.orderByAsc("sequence");
                queryWrapper.eq("student_id", id);

                Page<Intention> page = intentionService.page(new Page<>(pageNum, pageSize), queryWrapper);

                List<Intention> records = page.getRecords();
                for (Intention record : records) {
                        User user = userService.getById(record.getTeacherId());
                        if (user != null) {
                                record.setTeacherName(user.getNickname());
                        }
                }
                return Result.success(records);

        }

        //添加志愿
        @GetMapping("/addIntention")
        public Result addIntention(@RequestParam Integer student_id,
                                   @RequestParam Integer teacher_id) {


                QueryWrapper<Deadline> queryWrapper1 = new QueryWrapper<>();
                queryWrapper1.eq("is_active", 1); // 假设数据库中 is_active=1 表示激活状态
                Deadline activeDeadline = deadlineService.getOne(queryWrapper1);
                LocalDateTime now = LocalDateTime.now();
                if (activeDeadline == null || now.isBefore(activeDeadline.getStartTime()) || now.isAfter(activeDeadline.getEndTime())) {
                        return Result.error(Constants.CODE_400, "还没有到选择时间。");
                }
                QueryWrapper<Intention> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("student_id", student_id);
                List<Intention> intentionList = intentionService.list(queryWrapper);
                // 判断志愿数量是否已经达到上限
                if (intentionList.size() >= 3) {
                        // 用Constants.CODE_400表示请求参数错误或请求方式错误
                        return Result.error(Constants.CODE_400, "已达到添加志愿的数量上限");
                }
                Intention intention = new Intention();
                intention.setStudentId(student_id);
                intention.setTeacherId(teacher_id);
                intention.setSequence(intentionList.size() + 1);


                return Result.success(intentionService.save(intention));


        }

        //根据学生id和志愿顺序修改,把小的加1
        @GetMapping("/plus")
        public Result sequencePlus(@RequestParam Integer studentId,
                                   @RequestParam Integer sequence) {

                UpdateWrapper<Intention> updateWrapper = new UpdateWrapper<>();
                updateWrapper.eq("student_id", studentId)
                        .eq("sequence", sequence - 1);
                updateWrapper.set("sequence", sequence);
                return Result.success();

        }

        //根据id修改志愿顺序,把大的减小1
        @GetMapping("/intentionUp")
        public Result sequenceReduce(@RequestParam Integer id,
                                     @RequestParam Integer studentId,
                                     @RequestParam Integer sequence) {
                UpdateWrapper<Intention> plusWrapper = new UpdateWrapper<>();
                plusWrapper.eq("student_id", studentId)
                        .eq("sequence", sequence - 1);
                plusWrapper.set("sequence", sequence);
                intentionService.update(null, plusWrapper);
                UpdateWrapper<Intention> reduceWrapper = new UpdateWrapper<>();
                reduceWrapper.eq("id", id);

                reduceWrapper.set("sequence", sequence - 1);

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
        public Result sequencePush(@PathVariable Integer id) {
                QueryWrapper<Intention> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("student_id", id)
                        .eq("sequence", 1);
                Intention intention = intentionService.getOne(queryWrapper);
                Integer sid = intention.getStudentId();
                Integer seq = intention.getSequence();
                UpdateWrapper<Intention> updateWrapper = new UpdateWrapper<>();
//                updateWrapper.orderByAsc("sequence");
                updateWrapper.eq("student_id", sid)
                        .gt("sequence", seq)
                        .setSql("sequence=sequence-1");
                intentionService.update(null, updateWrapper);


                return Result.success(intentionService.removeById(intention.getId()));
        }


        //删除学生志愿
        @PostMapping("/deleteByStudentIdAndSeq/{id}")
        public Result deleteByStudentId(@PathVariable Integer id) {
                QueryWrapper<Intention> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("student_id", id);
                // 获取当前激活的时间配置
                QueryWrapper<Period> queryWrapper0 = new QueryWrapper<>();
                queryWrapper0.eq("is_active", 1); // 假设数据库中 is_active=1 表示激活状态
                Period activePeriod = periodService.getOne(queryWrapper0);
                LocalDateTime now = LocalDateTime.now();
                int sequence;

                // 判断当前时间处于哪个节点
                if (now.isAfter(activePeriod.getFirstPeriod()) && now.isBefore(activePeriod.getSecondPeriod())) {
                        sequence = 1;
                } else if (now.isAfter(activePeriod.getSecondPeriod()) && now.isBefore(activePeriod.getThirdPeriod())) {
                        sequence = 2;
                } else if (now.isAfter(activePeriod.getThirdPeriod())&& now.isBefore(activePeriod.getEndTime())) {
                        sequence = 3;
                } else {
                        // 如果不在任何定义时间段内，返回错误或默认逻辑
                        return Result.error(Constants.CODE_400, "当前不在教师决策时间内");
                }
                queryWrapper.eq("sequence", sequence);
                boolean removed = intentionService.remove(queryWrapper);

                if (removed) {
                        return Result.success("志愿退回成功");
                } else {
                        return Result.error(Constants.CODE_400, "志愿退回失败");
                }
        }



                @Scheduled(fixedRate = 12 * 60 * 60 * 1000, initialDelay = 12 * 60 * 60 * 1000)
                public void clearIntentionRecords() {
                // 获取当前激活的时间配置
                QueryWrapper<Period> queryWrapper0 = new QueryWrapper<>();
                queryWrapper0.eq("is_active", 1); // 假设数据库中 is_active=1 表示激活状态
                Period activePeriod = periodService.getOne(queryWrapper0);
                LocalDateTime now = LocalDateTime.now();

                LocalDateTime EndTime = activePeriod.getEndTime();

                if (EndTime != null && now.isAfter(EndTime)) {
                        // 使用MyBatis Plus提供的方法删除整个表的内容
                        intentionService.remove(new QueryWrapper<Intention>());
                        System.out.println("All intentions have been cleared after the deadline.");
                }
        }
}