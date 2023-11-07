package com.example.vaccinum.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.example.vaccinum.entity.UserInfo;
import com.example.vaccinum.service.UserInfoService;
import com.example.vaccinum.mapper.UserInfoMapper;
import org.springframework.stereotype.Service;

/**
* @author 何嘉豪
* @description 针对表【user_info(用户信息)】的数据库操作Service实现
* @createDate 2023-10-28 14:40:05
*/
@Service
public class UserInfoServiceImpl extends ServiceImpl<UserInfoMapper, UserInfo>
    implements UserInfoService{

}




