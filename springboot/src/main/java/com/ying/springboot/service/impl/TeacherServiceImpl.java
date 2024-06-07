package com.ying.springboot.service.impl;

import com.ying.springboot.entity.Teacher;
import com.ying.springboot.mapper.TeacherMapper;
import com.ying.springboot.service.ITeacherService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 应健霆
 * @since
 */
@Service
public class TeacherServiceImpl extends ServiceImpl<TeacherMapper, Teacher> implements ITeacherService {

}
