package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Posts;
import com.example.vaccinum.mapper.PostsMapper;
import com.example.vaccinum.service.IPostsService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 问诊记录 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class PostsServiceImpl extends ServiceImpl<PostsMapper, Posts> implements IPostsService {

}
