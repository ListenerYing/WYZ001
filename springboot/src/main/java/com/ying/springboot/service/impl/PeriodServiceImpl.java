package com.ying.springboot.service.impl;

import com.ying.springboot.entity.Period;
import com.ying.springboot.mapper.PeriodMapper;
import com.ying.springboot.service.IPeriodService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 应健霆
 * @since 2024-04-20
 */
@Service
public class PeriodServiceImpl extends ServiceImpl<PeriodMapper, Period> implements IPeriodService {

}
