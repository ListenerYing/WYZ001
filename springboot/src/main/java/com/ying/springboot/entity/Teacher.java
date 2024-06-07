package com.ying.springboot.entity;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author 应健霆

 */
@Getter
@Setter
@ApiModel(value = "Teacher对象", description = "")
public class Teacher implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer id;

    @ApiModelProperty("职称")
    private String title;

    @ApiModelProperty("招生人数")
    private Integer enrollment;



    @ApiModelProperty("要求")
    private String requirement;

    @ApiModelProperty("自我介绍")
    private String introduction;


}
