package com.ying.springboot.mapper;

import com.ying.springboot.entity.Student;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-18
 */
@Mapper
public interface StudentMapper extends BaseMapper<Student> {

}
