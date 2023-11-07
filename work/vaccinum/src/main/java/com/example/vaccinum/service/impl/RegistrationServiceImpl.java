package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Registration;
import com.example.vaccinum.mapper.RegistrationMapper;
import com.example.vaccinum.service.IRegistrationService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 挂号帖 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class RegistrationServiceImpl extends ServiceImpl<RegistrationMapper, Registration> implements IRegistrationService {

}
