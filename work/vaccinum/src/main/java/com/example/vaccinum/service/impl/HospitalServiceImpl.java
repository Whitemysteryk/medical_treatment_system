package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Hospital;
import com.example.vaccinum.mapper.HospitalMapper;
import com.example.vaccinum.service.IHospitalService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 医院 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class HospitalServiceImpl extends ServiceImpl<HospitalMapper, Hospital> implements IHospitalService {

}
