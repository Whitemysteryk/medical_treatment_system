package com.example.vaccinum;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.example.vaccinum.mapper")
public class VaccinumApplication {

    public static void main(String[] args) {
        SpringApplication.run(VaccinumApplication.class, args);
    }

}
