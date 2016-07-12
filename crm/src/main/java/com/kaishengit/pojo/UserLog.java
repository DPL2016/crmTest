package com.kaishengit.pojo;

import java.io.Serializable;

public class UserLog implements Serializable {
    private static final long serialVersionUID = 5583745757983800184L;
    private Integer id;
    private String logintime;
    private Integer userid;
    private String loginip;
    private User user;

    @Override
    public String toString() {
        return "UserLog{" +
                "id=" + id +
                ", logintime='" + logintime + '\'' +
                ", userid=" + userid +
                ", loginip='" + loginip + '\'' +
                ", user=" + user +
                '}';
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getLogintime() {
        return logintime;
    }

    public void setLogintime(String logintime) {
        this.logintime = logintime;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public String getLoginip() {
        return loginip;
    }

    public void setLoginip(String loginip) {
        this.loginip = loginip;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}
