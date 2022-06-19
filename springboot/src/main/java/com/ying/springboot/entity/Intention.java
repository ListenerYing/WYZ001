package com.ying.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import java.io.Serializable;
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
 * @since 2022-06-19
 */
@Getter
@Setter
@ApiModel(value = "Intention对象", description = "")
public class Intention implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private Integer studentId;

    private Integer teacherId;

    @ApiModelProperty("志愿顺序")
    private Integer sequence;


}
