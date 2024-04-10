package com.ying.springboot.service.impl;

import com.ying.springboot.entity.Notice;
import com.ying.springboot.mapper.NoticeMapper;
import com.ying.springboot.service.INoticeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author 应健霆
 * @since 2024-04-06
 */
@Service
public class NoticeServiceImpl extends ServiceImpl<NoticeMapper, Notice> implements INoticeService {

}
