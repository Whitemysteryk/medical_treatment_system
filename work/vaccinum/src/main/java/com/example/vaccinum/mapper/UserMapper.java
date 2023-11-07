package com.example.vaccinum.mapper;

import com.example.vaccinum.entity.User;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 患者用户 Mapper 接口
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

}
