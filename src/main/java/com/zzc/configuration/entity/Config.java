package com.zzc.configuration.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * 配置
 * 
 * @author zk
 * @date 2015年9月11日 下午5:05:37
 */
@Entity
@Table(name = "t_cm_gowild_config")
public class Config {
    /** 主键 */

    @Id
    @GeneratedValue
    private Integer id;
    /** 配置项 */
    @Column(name = "ckey", length = 50)
    private String ckey;
    /** 配置值 */
    @Column(name = "cvalue", length = 100)
    private String cvalue;
    /** 含义 */
    @Column(name = "meaning", length = 100)
    private String meaning;
    /** 分类 */
    @Column(name = "category", length = 20)
    private String category;

    public Integer getId() {
        return this.id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCkey() {
        return this.ckey;
    }

    public void setCkey(String ckey) {
        this.ckey = ckey;
    }

    public String getCvalue() {
        return this.cvalue;
    }

    public void setCvalue(String cvalue) {
        this.cvalue = cvalue;
    }

    public String getMeaning() {
        return this.meaning;
    }

    public void setMeaning(String meaning) {
        this.meaning = meaning;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }
}
