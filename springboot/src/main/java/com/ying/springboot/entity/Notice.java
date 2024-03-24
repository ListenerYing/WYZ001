package com.ying.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import io.swagger.annotations.ApiModel;
import lombok.Getter;
import lombok.Setter;

import java.io.Serializable;

/**
 * <p>
 *
 * </p>
 *
 * @author 应健霆
 * @since 2024-03-24
 */
@Getter
@Setter
@ApiModel(value = "Notice公告", description = "")
public class Notice implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String title;

    private String content;
    private Integer userid;
    private String time;
    //该字段并不在数据库里 只用于业务处理
    @TableField(exist = false)
    private String user;


}
