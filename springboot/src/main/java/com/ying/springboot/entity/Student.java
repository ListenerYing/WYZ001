package com.ying.springboot.entity;

import java.io.Serializable;
import java.math.BigDecimal;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

/**
 * <p>
 * 
 * </p>
 *
 * @author 应健霆
 * @since 2022-06-18
 */
@Getter
@Setter
@ApiModel(value = "Student对象", description = "")
public class Student implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    @ApiModelProperty("绩点")
    private BigDecimal gpa;

    @ApiModelProperty("自我介绍")
    private String introduction;

    @ApiModelProperty("导师id")
    private Integer teacherId;


}
