package com.example.vaccinum.controller;


import com.example.vaccinum.entity.Registration;
import com.example.vaccinum.service.IRegistrationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.RestController;

import java.util.HashMap;

/**
 * <p>
 * 挂号帖 前端控制器
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@RestController
@RequestMapping("/vaccinum/registration")
public class RegistrationController {
    @Autowired
    IRegistrationService registrationService;
    ObjectMapper JSon_Tool = new ObjectMapper();

    @RequestMapping("/insert")
    public String register(Registration registration) throws JsonProcessingException {
        HashMap map = new HashMap();
        boolean save = registrationService.save(registration);
        map.put("flag",save);
        return JSon_Tool.writeValueAsString(map);

    }


}
