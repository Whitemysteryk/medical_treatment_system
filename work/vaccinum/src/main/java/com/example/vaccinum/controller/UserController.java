package com.example.vaccinum.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.example.vaccinum.entity.User;
import com.example.vaccinum.entity.UserInfo;
import com.example.vaccinum.service.IUserService;
import com.example.vaccinum.service.UserInfoService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;

/**
 * <p>
 * 患者用户 前端控制器
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@RestController
@RequestMapping("/user")
public class UserController {

    //依赖user业务层,自动注入
    @Autowired
    IUserService userService;

// jason 解析工具

     ObjectMapper jason = new ObjectMapper();

    // 根据手机号码查询
    @RequestMapping("/loginUser")
    public String loginUser(String phone , String password, String code, HttpSession session ) throws JsonProcessingException {
// 映射结果集map
        HashMap result = new HashMap<>();

//获取验证码
        String captcha = (String)session.getAttribute("captcha");
//进行验证码判断
        if(!code.equalsIgnoreCase(captcha)){
            result.put("flag",false);
            result.put("message","验证码错误！");
//返回json解析数据结果
            return jason.writeValueAsString(result);
        }

// QueryWrapper 定义查询条件
        QueryWrapper<User> wrapper = new QueryWrapper<>();
        wrapper.eq("phone",phone).eq("password",password);



// 通过条件获取到用户
        User user = userService.getOne(wrapper);
// 判断是否存在用户
        if (user!=null){
            result.put("flag",true);
            result.put("user",user);
            result.put("role","user");
        }else {
            result.put("flag", false);
            result.put("message","用户账号或密码错误");
        }
        return jason.writeValueAsString(result);
    }

    @RequestMapping("/query")
    //定义查询user的接口
    public List<User> query(){
        List<User> list = userService.list();
        return list;
    };
//    实现插入(注意需要一一对应,并且大小写都要一致)
//    http://localhost:8085/user/insert?id=123&name=xx&   ....
    @RequestMapping("/insert")
    public boolean insert(User user){
        boolean save = userService.save(user);
        return save;
    }

//    更新
    @RequestMapping("/update")
    public boolean update(User user){
        boolean updateById = userService.updateById(user);
        return updateById;
    }

//    删除
    @RequestMapping("/delete")
    public boolean delete(int id){
        boolean b = userService.removeById(id);
        return b;
    }

    @Autowired
    UserInfoService userInfoService;

    //定义一个请求接口来实现用户的注册 user、userinfo
    @RequestMapping("/register")
    public String register(User user, UserInfo userInfo) throws JsonProcessingException {
//        1.创建json解析工具
        ObjectMapper json = new ObjectMapper();
//       2.返回的结果集
        HashMap map = new HashMap<>();
//        3.调用方法添加数据
        boolean save = userService.save(user);
//        4.添加userInfo的数据  需要设置 user的id主键 为 userinfo id的值
        userInfo.setUserId(Long.valueOf(user.getId()));
        boolean save1 = userInfoService.save(userInfo);
//        响应结果
        map.put("flag",save&&save1);
//        返回解析好的json数据
        return json.writeValueAsString(map);
    }
}
