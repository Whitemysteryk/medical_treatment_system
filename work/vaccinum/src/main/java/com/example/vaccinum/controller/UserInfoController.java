package com.example.vaccinum.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.vaccinum.entity.User;
import com.example.vaccinum.entity.UserInfo;
import com.example.vaccinum.service.IUserService;
import com.example.vaccinum.service.UserInfoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;
import java.util.List;

@RestController
@RequestMapping("/gec/user-info")
public class UserInfoController {

    @Autowired
    UserInfoService userInfoService;

    @Autowired
    IUserService service;

    ObjectMapper JsonTool = new ObjectMapper();

    @RequestMapping("/list")
    public String list(@RequestParam(required = false , defaultValue = "1") Integer pageNum,
                       @RequestParam(required = false , defaultValue = "3") Integer pageSize,
                       @RequestParam(required = false) String keyword) throws JsonProcessingException {

        ObjectMapper JsonTool = new ObjectMapper();

//        定义结果集
        HashMap map = new HashMap<>();

//        创建条件构造器
        QueryWrapper<UserInfo> wrapper = new QueryWrapper<>();
//        根据条件、字段名、值【身份证查询】
        wrapper.like(keyword!=null&&!keyword.equals(""),"code",keyword);
//        构建page对象
        Page<UserInfo> page = new Page<>(pageNum,pageSize);
//        进行分页查询
         page = userInfoService.page(page);
//         从分页page中获取数据
        List<UserInfo> records = page.getRecords();

//        遍历列表
        for (UserInfo userInfo:records){
//            根据UserInfo查询User
            User user = service.getById(userInfo.getUserId());
//            将user中的name赋值给UserInfo
            userInfo.setUserName(user.getName());
//            获取图片信息
            userInfo.setUser(user);
        }

//        将值赋值给结果集
        map.put("total",page.getTotal());
        map.put("list",records);

        return JsonTool.writeValueAsString(map);
    }

    @RequestMapping("/update")
    public String update(User user, UserInfo userInfo) throws JsonProcessingException {
        //       1.返回的结果集
        HashMap map = new HashMap<>();
//        isEmpty判断为null
        if (ObjectUtils.isEmpty(user.getId())) {
            //            添加
            user.setCodeid(userInfo.getCode());
            boolean save = service.saveOrUpdate(user);


            userInfo.setUserId(Long.valueOf(user.getId()));
            boolean save1 = userInfoService.save(userInfo);
            map.put("ok", save1 && save);
            map.put("message","添加成功");

        } else {
//            修改
            boolean b = service.saveOrUpdate(user);
            boolean b1 = userInfoService.saveOrUpdate(userInfo);
            map.put("ok", b && b1);
            map.put("message","修改成功");
        }

        return JsonTool.writeValueAsString(map);
    }

    @RequestMapping("/delete")
    public String delete(Integer id) throws JsonProcessingException {
        HashMap map = new HashMap<>();
        boolean save = service.removeById(id);
        boolean save1 = userInfoService.removeById(id);

        map.put("ok",save1&&save);

        return JsonTool.writeValueAsString(map);
    }

}
