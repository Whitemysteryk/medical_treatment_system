package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Manager;
import com.example.vaccinum.mapper.ManagerMapper;
import com.example.vaccinum.service.IManagerService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 管理员 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class ManagerServiceImpl extends ServiceImpl<ManagerMapper, Manager> implements IManagerService {

}
