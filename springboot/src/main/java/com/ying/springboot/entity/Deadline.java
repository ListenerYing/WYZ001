package com.ying.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
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
 * @since 2024-04-13
 */
@Getter
@Setter
@TableName("deadline")
@ApiModel(value = "Deadline对象", description = "")
public class Deadline implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("志愿填报开始时间")
    private LocalDateTime startTime;

    @ApiModelProperty("志愿填报结束时间")
    private LocalDateTime endTime;

    @ApiModelProperty("是否当前激活的配置")
    private Boolean isActive;

    @ApiModelProperty("时间配置描述")
    private String description;


}
