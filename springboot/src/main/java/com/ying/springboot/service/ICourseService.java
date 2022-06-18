package com.ying.springboot.service;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import com.ying.springboot.entity.Course;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-07
 */
public interface ICourseService extends IService<Course> {
    Page<Course> findPage(Page<Course> page, String name);
}
