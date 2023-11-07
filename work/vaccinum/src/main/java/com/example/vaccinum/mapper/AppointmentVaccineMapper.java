package com.example.vaccinum.mapper;

import com.example.vaccinum.entity.AppointmentVaccine;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 可预约疫苗列表 Mapper 接口
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Mapper
public interface AppointmentVaccineMapper extends BaseMapper<AppointmentVaccine> {

}
