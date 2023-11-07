package com.example.vaccinum.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.vaccinum.entity.User;
import com.example.vaccinum.entity.Vaccine;
import com.example.vaccinum.entity.VaccineType;
import com.example.vaccinum.service.IUserService;
import com.example.vaccinum.service.IVaccineService;
import com.example.vaccinum.service.IVaccineTypeService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

/**
 * <p>
 * 疫苗分类 前端控制器
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@RestController
@RequestMapping("/vaccinetype")
public class VaccineTypeController {

    //依赖user业务层,自动注入
    @Autowired
    IVaccineTypeService typeService;

// jason 解析工具
    ObjectMapper jason = new ObjectMapper();

    @RequestMapping("/query")
    public  String query() throws JsonProcessingException {
//        映射结果集map
        HashMap result = new HashMap<>();
        List<VaccineType> list = typeService.list();
        result.put("list",list);
        return jason.writeValueAsString(result);
    }

    // http://localhost:8085/vaccinetype/update
    //    定义修改的请求接口
    @RequestMapping("/update")
    public String update(VaccineType type) throws JsonProcessingException {
        // map集合-结果集
        HashMap result =new HashMap();
        //調用业务层的查询方法
        boolean update = typeService.updateById(type);
        result.put("flag",update);
        //返回json格式的数据
        return jason.writeValueAsString(result);
    }

    // http://localhost:8085/vaccinetype/insert
    //    定义添加的请求接口
    @RequestMapping("/insert")
    public String insert(VaccineType type) throws JsonProcessingException {
        // map集合-结果集
        HashMap result =new HashMap();
        //調用业务层的查询方法
        boolean insert = typeService.save(type);
        result.put("flag",insert);
        //返回json格式的数据
        return jason.writeValueAsString(result);
    }

    // http://localhost:8085/vaccinetype/insert
    //    定义刪除的请求接口
    @RequestMapping("/delete")
    public String delete(Integer id) throws JsonProcessingException {
        // map集合-结果集
        HashMap result =new HashMap();
        //調用业务层的查询方法
        boolean delete = typeService.removeById(id);
        result.put("flag",delete);
        //返回json格式的数据
        return jason.writeValueAsString(result);
    }

}
