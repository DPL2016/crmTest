package com.kaishengit.pojo;

import java.io.Serializable;
import java.sql.Timestamp;

public class Sales implements Serializable {
    private static final long serialVersionUID = -5562166450183527435L;
    private Integer id;
    private String name;
    private String price;
    private Integer custid;
    private String custname;
    private String progress;
    private Timestamp createtime;
    private String lasttime;
    private Integer userid;
    private String username;
    private String successtime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public Integer getCustid() {
        return custid;
    }

    public void setCustid(Integer custid) {
        this.custid = custid;
    }

    public String getCustname() {
        return custname;
    }

    public void setCustname(String custname) {
        this.custname = custname;
    }

    public String getProgress() {
        return progress;
    }

    public void setProgress(String progress) {
        this.progress = progress;
    }

    public Timestamp getCreatetime() {
        return createtime;
    }

    public void setCreatetime(Timestamp createtime) {
        this.createtime = createtime;
    }

    public String getLasttime() {
        return lasttime;
    }

    public void setLasttime(String lasttime) {
        this.lasttime = lasttime;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getSuccesstime() {
        return successtime;
    }

    public void setSuccesstime(String successtime) {
        this.successtime = successtime;
    }
}
