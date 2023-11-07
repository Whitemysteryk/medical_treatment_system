package com.example.vaccinum.controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@RestController
@RequestMapping("/file")
public class FileController {

    @RequestMapping("/upload")
    public String upload(MultipartFile file) throws IOException {
        String uuid = UUID.randomUUID().toString();
//        1.1获取文件真实名称   123.jpg
        String filename = file.getOriginalFilename();

//        2.图片名称修改
//        后缀
        String substring = filename.substring(filename.lastIndexOf("."));
//        拼接uuid和后缀名
        filename = uuid +substring;

        //        3.如何存到本地磁盘中 文件的上传
        file.transferTo(new File("E:\\实训\\upload\\"+filename));

        return "http://localhost:8085/" + filename;
    }
}
