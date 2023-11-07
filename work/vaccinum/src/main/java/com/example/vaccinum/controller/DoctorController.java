package com.example.vaccinum.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.vaccinum.entity.Doctor;
import com.example.vaccinum.service.IDoctorService;
import com.example.vaccinum.service.IRegistrationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Value;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.print.Doc;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.Function;

/**
 * <p>
 * 医生 前端控制器
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */

@RestController
@RequestMapping("/vaccinum/doctor")
@AllArgsConstructor
public class DoctorController {
//    自动注入
    @Autowired
    IDoctorService doctorService;

    @Autowired
    IRegistrationService registrationService;

//    Jason格式化对象
    ObjectMapper JsonTool = new ObjectMapper();


//    接口
//    TODO:接口功能：查询医生一般信息
@RequestMapping("/list")
public String query(@RequestParam(defaultValue = "1") Integer pageNum,
                    @RequestParam(defaultValue = "8") Integer pageSize) throws JsonProcessingException {

    // 创建分页对象
    Page<Doctor> page = new Page<>(pageNum, pageSize);

    // 执行分页查询
    IPage<Doctor> doctorIPage = doctorService.page(page);

    // 从分页对象中获取分页数据和总记录数
    List<Doctor> pageInfoList = doctorIPage.getRecords();
    long total = doctorIPage.getTotal();
    long pages = doctorIPage.getPages();
    System.out.println("pages = " + pages);

    // 构造返回的医生信息列表
    List<DoctorSummary> doctorSummaryList = new ArrayList<>();
    for (Doctor doctor:pageInfoList){
        doctorSummaryList.add(new DoctorSummary(doctor.getHostId(),doctor.getName(),doctor.getPhone(),doctor.getImage(),doctor.getMajor()));
    }

    // 返回医生不敏感信息的信息
    return JsonTool.writeValueAsString(doctorSummaryList);
}


//  TODO:根据搜索栏查找对应医生
    @RequestMapping("/SerchByName")
    public String SerchByName(@RequestParam("name")String name,
                              @RequestParam(defaultValue = "1") Integer pageNum,
                              @RequestParam(defaultValue = "8") Integer pageSize) throws JsonProcessingException {
//        创建分页对象
        Page<Doctor> page = new Page<>(pageNum,pageSize);
//        查询模块
        QueryWrapper<Doctor> wrapper = new QueryWrapper<>();
        wrapper.eq("name",name);

//        创建分页结果对象
        IPage<Doctor> iPage = doctorService.page(page,wrapper);
        List<Doctor> list = iPage.getRecords();

        List<DoctorSummary> doctorSummaryList = new ArrayList<>();
        for (Doctor doctor:list){
            doctorSummaryList.add(new DoctorSummary(doctor.getHostId(),doctor.getName(),doctor.getPhone(),doctor.getImage(),doctor.getMajor()));
        }
        return JsonTool.writeValueAsString(doctorSummaryList);
    }


//  TODO:根据医院的科室查询对应医生
    @RequestMapping("/SerchByMajor")
    public String SerchByMajor(@RequestParam("major") String major,
                               @RequestParam(defaultValue = "1") Integer pageNum,
                               @RequestParam(defaultValue = "8") Integer pageSize) throws JsonProcessingException {

        Page<Doctor> page = new Page<>(pageNum,pageSize);

        QueryWrapper<Doctor> wrapper = new QueryWrapper<>();
        wrapper.eq("major",major);

        IPage<Doctor> iPage = doctorService.page(page,wrapper);
        List<Doctor> list = iPage.getRecords();

//        获取信息
        List<DoctorSummary> doctorSummaryList = new ArrayList<>();
        for (Doctor doctor:list){
            doctorSummaryList.add(new DoctorSummary(doctor.getHostId(),doctor.getName(),doctor.getPhone(),doctor.getImage(),doctor.getMajor()));
        }
        return JsonTool.writeValueAsString(doctorSummaryList);
    }


//    TODO：获取医生的详细信息
    @RequestMapping("/getDetail")
    public String getDetail(@RequestParam("id") Integer id) throws JsonProcessingException {

        QueryWrapper<Doctor> wrapper = new QueryWrapper<>();
        wrapper.eq("id",id);

        Doctor doctorServiceById = doctorService.getOne(wrapper);
        DoctorDetailSummary doctorDetailSummary =
                new DoctorDetailSummary(doctorServiceById.getHostId(),
                                        doctorServiceById.getName(),
                                        doctorServiceById.getPhone(),
                                        doctorServiceById.getImage(),
                                        doctorServiceById.getMajor(),
                                        doctorServiceById.getSchool());
        return JsonTool.writeValueAsString(doctorDetailSummary);
    }


//  医生的基础信息实体
    @Value
    private static class DoctorSummary {
        Integer host_id;
        String name;
        String phone;
        String image;
        String major;
    }
//    医生的详细信息集
@Value
private static class DoctorDetailSummary {
    Integer host_id;
    String name;
    String phone;
    String image;
    String major;
    String school;

    }
}
