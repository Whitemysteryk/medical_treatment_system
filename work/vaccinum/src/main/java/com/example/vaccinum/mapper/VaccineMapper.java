package com.example.vaccinum.mapper;

import com.example.vaccinum.entity.Vaccine;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 疫苗 Mapper 接口
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Mapper
public interface VaccineMapper extends BaseMapper<Vaccine> {

}
