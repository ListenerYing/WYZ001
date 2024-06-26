package com.ying.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
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
 * @since 2024-04-06
 */
@Getter
@Setter
@TableName("notice")
@ApiModel(value = "Notice对象", description = "")
public class Notice implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @ApiModelProperty("标题")
    private String name;

    @ApiModelProperty("内容")
    private String content;

    @ApiModelProperty("发布时间")
    private String time;

    @ApiModelProperty("发布人")
    private String user;

    @ApiModelProperty("封面")
    private String img;

    @ApiModelProperty("1-简单的公告，2富文本")
    private Integer type;


}
