package com.ying.springboot.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import com.ying.springboot.controller.dto.UserDTO;
import com.ying.springboot.entity.User;

public interface UserService extends IService<User> {

    UserDTO login(UserDTO userDTO);
    User register(UserDTO userDTO);

    IPage<User> getResult(Page<User> page);
}
