package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.User;
import com.example.vaccinum.mapper.UserMapper;
import com.example.vaccinum.service.IUserService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 患者用户 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

}
