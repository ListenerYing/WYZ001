package com.ying.springboot.service.impl;

import com.ying.springboot.entity.Deadline;
import com.ying.springboot.mapper.DeadlineMapper;
import com.ying.springboot.service.IDeadlineService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-26
 */
@Service
public class DeadlineServiceImpl extends ServiceImpl<DeadlineMapper, Deadline> implements IDeadlineService {

}
