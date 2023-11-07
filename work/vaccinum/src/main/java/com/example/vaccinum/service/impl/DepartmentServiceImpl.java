package com.example.vaccinum.service.impl;

import com.example.vaccinum.entity.Department;
import com.example.vaccinum.mapper.DepartmentMapper;
import com.example.vaccinum.service.IDepartmentService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 科室 服务实现类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Service
public class DepartmentServiceImpl extends ServiceImpl<DepartmentMapper, Department> implements IDepartmentService {

}
