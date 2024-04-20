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
 * @since 2024-04-20
 */
@Getter
@Setter
@TableName("period")
@ApiModel(value = "Period对象", description = "")
public class Period implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "period_id", type = IdType.AUTO)
    private Integer periodId;

    @ApiModelProperty("第一志愿开始判断时间")
    private LocalDateTime firstPeriod;

    @ApiModelProperty("第二志愿开始判断时间")
    private LocalDateTime secondPeriod;

    @ApiModelProperty("第三志愿开始判断时间")
    private LocalDateTime thirdPeriod;

    @ApiModelProperty("当前记录是否激活，0为未激活，1为激活")
    private Boolean isActive;

    @ApiModelProperty("时间周期配置描述")
    private String description;


}
