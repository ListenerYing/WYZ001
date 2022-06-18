package com.ying.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.ying.springboot.entity.Course;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-07
 */
@Mapper
public interface CourseMapper extends BaseMapper<Course> {
    Page<Course> findPage(Page<Course> page,@Param("name") String name);
}
