package com.example.vaccinum.mapper;

import com.example.vaccinum.entity.Appointment;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 预约记录 Mapper 接口
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Mapper
public interface AppointmentMapper extends BaseMapper<Appointment> {

}
