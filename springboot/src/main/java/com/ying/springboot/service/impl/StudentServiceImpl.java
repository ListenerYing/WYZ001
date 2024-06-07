package com.ying.springboot.service.impl;

import com.ying.springboot.entity.Student;
import com.ying.springboot.mapper.StudentMapper;
import com.ying.springboot.service.IStudentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 应健霆
 * @since 2024-04-18 */
@Service
public class StudentServiceImpl extends ServiceImpl<StudentMapper, Student> implements IStudentService {

}
