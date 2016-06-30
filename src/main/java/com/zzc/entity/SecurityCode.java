package com.zzc.entity;

import org.springframework.format.annotation.DateTimeFormat;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by Zheng.Ke
 * Date 2016/6/30.
 */
@Entity
@Table(name = "t_security_code")
public class SecurityCode {
    /** id */
    private Integer id;
    /** 验证码 */
    private String code;
    /** 状态  0--未验证  1--已验证 */
    private Integer status;
    /** 修改时间 */
    private Date modifyTime;

    @Id
    @GeneratedValue
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    @Column(name = "modify_time")
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }
}
