package com.example.demo;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class Controller {
    //定义功能http请求接口

    //定义功能的请求接口
    @RequestMapping("loginUser")
    public String login(String name,String password)
    {
        if (name.equals("admin")&&password.equals("123456")){
            return "Login Success";
        }else {
            return " Login Fail";
        }
    }
}
