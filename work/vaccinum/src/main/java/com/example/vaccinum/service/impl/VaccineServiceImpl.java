package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Vaccine;
import com.example.vaccinum.mapper.VaccineMapper;
import com.example.vaccinum.service.IVaccineService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 疫苗 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class VaccineServiceImpl extends ServiceImpl<VaccineMapper, Vaccine> implements IVaccineService {

}
