package com.example.vaccinum.entity;

import java.time.LocalDateTime;
import java.io.Serializable;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * <p>
 * 问诊记录
 * </p>
 *
 * @author jerry
 * @since 2023-10-21
 */
@Data
@EqualsAndHashCode(callSuper = false)
public class Posts implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * 问诊记录内容
     */
    private String postsContent;

    /**
     * 描述图片
     */
    private String postsImage;

    /**
     * 创建时间
     */
    private LocalDateTime createTime;

    /**
     * 医生id
     */
    private Integer publisher;

    /**
     * 挂号帖id
     */
    private Integer registrationId;


}
