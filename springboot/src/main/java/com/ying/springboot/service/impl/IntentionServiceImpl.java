package com.ying.springboot.service.impl;

import com.ying.springboot.entity.Intention;
import com.ying.springboot.mapper.IntentionMapper;
import com.ying.springboot.service.IIntentionService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-19
 */
@Service
public class IntentionServiceImpl extends ServiceImpl<IntentionMapper, Intention> implements IIntentionService {

}
