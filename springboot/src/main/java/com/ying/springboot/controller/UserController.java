package com.ying.springboot.controller;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.common.Constants;
import com.ying.springboot.common.Result;
import com.ying.springboot.controller.dto.UserDTO;
import com.ying.springboot.entity.Period;
import com.ying.springboot.entity.User;
import com.ying.springboot.service.IPeriodService;
import com.ying.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;
    @Resource
    private IPeriodService periodService;

    //用户登陆
    @PostMapping("/login")
    public Result login(@RequestBody UserDTO userDTO){
        String username=userDTO.getUsername();
        String password=userDTO.getPassword();
        if (StrUtil.isBlank(username)||StrUtil.isBlank(password)){
            return Result.error(Constants.CODE_400,"参数错误");
        }
        UserDTO dto=userService.login(userDTO);
        return Result.success(dto);
    }
    //用户注册
    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO){
        String username=userDTO.getUsername();
        String password=userDTO.getPassword();
        if (StrUtil.isBlank(username)||StrUtil.isBlank(password)){
            return Result.error(Constants.CODE_400,"参数错误");
        }
        return Result.success(userService.register(userDTO));
    }
    //查询所有数据
    @GetMapping
    public Result getAll(){return Result.success(userService.list());}
    //根据id查询
    @GetMapping("/{id}")
    public Result getById(@PathVariable Integer id){return Result.success(userService.getById(id));}
    //新增和修改
    @PostMapping
    public Result save(@RequestBody User user){return Result.success(userService.saveOrUpdate(user));}
    //修改
    //@PutMapping
//    public Boolean update(@RequestBody User user){return UserService.modify(user); }
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
       return Result.success(userService.removeById(id));
    }
    @GetMapping("/username/{username}")
    public Result findOne(@PathVariable String username){
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("username",username);
        return Result.success(userService.getOne(queryWrapper));
    }



    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success(userService.removeByIds(ids));
    }
    //分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize,
                                @RequestParam (defaultValue="") String username ,
                                @RequestParam (defaultValue="") String email,
                                @RequestParam (defaultValue="") String address
                                                                                ){

        IPage<User> page=new Page<>(pageNum,pageSize);
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        if (!"".equals(username)){
            queryWrapper.like("username",username);
        }
        if (!"".equals(email)){
            queryWrapper.like("email",email);
        }
        if (!"".equals(address)){
            queryWrapper.like("address",address);
        }
        return Result.success(userService.page(page,queryWrapper));

    }
    //分页查询所有老师
    @GetMapping("/page/teacher")
    public Result findTeacher(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam (defaultValue="") String username

                                                                        ){

        IPage<User> page=new Page<>(pageNum,pageSize);
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.eq("role","老师");
        if (!"".equals(username)){
            queryWrapper.like("username",username);
        }

        return Result.success(userService.page(page,queryWrapper));

    }
    //分页查询志愿学生
    @GetMapping("/page/student")
    public Result findStudent(@RequestParam Integer pageNum,
                              @RequestParam Integer pageSize,
                              @RequestParam (defaultValue="") Integer id

    ){
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
        } else if(now.isAfter(activePeriod.getThirdPeriod())&& now.isBefore(activePeriod.getEndTime())) {
            sequence = 3;
        } else {
            // 如果不在任何定义时间段内，返回错误或默认逻辑
            return Result.error(Constants.CODE_400,"当前不在教师决策时间内");
        }
        IPage<User> page=new Page<>(pageNum,pageSize);
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.inSql("id","SELECT student_id FROM intention WHERE teacher_id="+id+" AND sequence="+sequence);


        return Result.success(userService.page(page,queryWrapper));

    }
    //分页查询已选学生
    @GetMapping("/page/ChosenStudent")
    public Result findChosenStudent(@RequestParam Integer pageNum,
                              @RequestParam Integer pageSize,
                              @RequestParam (defaultValue="") Integer id

    ){

        IPage<User> page=new Page<>(pageNum,pageSize);
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.inSql("id","SELECT id FROM student WHERE teacher_id="+id);


        return Result.success(userService.page(page,queryWrapper));

    }
    //分页查询志愿老师
    @GetMapping("/page/findSelectedTeacher")
    public Result findSelectedTeacher(@RequestParam Integer pageNum,
                              @RequestParam Integer pageSize,
                              @RequestParam (defaultValue="") Integer id

    ){

        IPage<User> page=new Page<>(pageNum,pageSize);
        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
        queryWrapper.inSql("id","SELECT teacher_id FROM intention WHERE student_id="+id);


        return Result.success(userService.page(page,queryWrapper));

    }
    //分页查询结果
    @GetMapping("/page/result")
    public Result getResult(@RequestParam Integer pageNum,
                                      @RequestParam Integer pageSize

    ){

        IPage<User> page=userService.getResult(new Page<>(pageNum,pageSize));
//        QueryWrapper<User> queryWrapper=new QueryWrapper<>();
//        queryWrapper.eq("role","学生");
//        List<User> stu=userService.list(queryWrapper);
//        for (User stu:stu){
//            User user =userService.getById(stu.get)
//        }
//
//
        return Result.success(page);

    }



}

