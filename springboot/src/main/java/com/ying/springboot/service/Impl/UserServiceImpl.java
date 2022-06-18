package com.ying.springboot.service.Impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.ying.springboot.common.Constants;
import com.ying.springboot.controller.dto.UserDTO;
import com.ying.springboot.ecxeption.ServiceException;
import com.ying.springboot.entity.User;
import com.ying.springboot.mapper.UserMapper;
import com.ying.springboot.service.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {

    private static final Log LOG= Log.get();
    @Override
    public UserDTO login(UserDTO userDTO) {
        User one=getUserInfo(userDTO);
        if(one!=null){
            BeanUtil.copyProperties(one,userDTO,true);
            return userDTO;
        }
        else{
            throw new ServiceException(Constants.CODE_600,"用户名或密错误");
        }
    }

    @Override
    public User register(UserDTO userDTO) {
        User one=getUserInfo(userDTO);
        if (one==null){
            one=new User();
            BeanUtil.copyProperties(userDTO,one,true);
            save(one);//把userDTO数据copy完后存储到数据库中

        }else{
            throw new ServiceException(Constants.CODE_600,"用户名已存在");
        }
        return one;


    }
    private User getUserInfo(UserDTO userDTO){
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", userDTO.getUsername());
        queryWrapper.eq("password", userDTO.getPassword());
        // 处理异常情况
        User one;
        try {
            one = getOne(queryWrapper);//从数据库查询用户信息


        } catch (Exception e) {
            LOG.error(e);
            throw new ServiceException(Constants.CODE_500,"系统错误");
        }
        return one;
    }

}
