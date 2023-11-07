package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.VaccineType;
import com.example.vaccinum.mapper.VaccineTypeMapper;
import com.example.vaccinum.service.IVaccineTypeService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 疫苗分类 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class VaccineTypeServiceImpl extends ServiceImpl<VaccineTypeMapper, VaccineType> implements IVaccineTypeService {

}
