package com.kaishengit.pojo;

import java.io.Serializable;

public class Role implements Serializable{
    private static final long serialVersionUID = 5272521009572978372L;
    private Integer id;
    private String rolename;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRolename() {
        return rolename;
    }

    public void setRolename(String rolename) {
        this.rolename = rolename;
    }

    @Override
    public String toString() {
        return "Role{" +
                "id=" + id +
                ", rolename='" + rolename + '\'' +
                '}';
    }
}
