package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Appointment;
import com.example.vaccinum.mapper.AppointmentMapper;
import com.example.vaccinum.service.IAppointmentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 预约记录 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class AppointmentServiceImpl extends ServiceImpl<AppointmentMapper, Appointment> implements IAppointmentService {

}
