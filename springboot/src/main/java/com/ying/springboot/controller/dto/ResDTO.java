package com.ying.springboot.controller.dto;

import lombok.Data;

@Data
public class ResDTO {
    private Integer id;
    private String 学号;
    private String 姓名;
    private String 导师姓名;
    private String 导师邮箱;
}
