package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Doctor;
import com.example.vaccinum.mapper.DoctorMapper;
import com.example.vaccinum.service.IDoctorService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 医生 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class DoctorServiceImpl extends ServiceImpl<DoctorMapper, Doctor> implements IDoctorService {

}
