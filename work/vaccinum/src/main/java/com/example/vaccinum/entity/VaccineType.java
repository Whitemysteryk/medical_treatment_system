package com.example.vaccinum.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 疫苗分类
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class VaccineType implements Serializable {

    private static final long serialVersionUID = 1L;


    @TableId(type = IdType.AUTO)
    private Integer id;
    /**
     * 疫苗种类
     */
    private String name;

    /**
     * 疫苗种类描述
     */
    private String remark;

    private Integer status;


}
