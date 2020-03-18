package com.domain;

import java.util.List;

/**
 * 角色表（Role）
 * id,roleid,roleDesc
 * id，角色id，角色描述
 */
public class Role {
    private Integer id;
    private String roleid;                //角色id
    private String roleDesc;              //角色描述

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getRoleid() {
        return roleid;
    }

    public void setRoleid(String roleid) {
        this.roleid = roleid;
    }

    public String getRoleDesc() {
        return roleDesc;
    }

    public void setRoleDesc(String roleDesc) {
        this.roleDesc = roleDesc;
    }

    @Override
    public String toString() {
        return "{" +
                "\"id\"=\"" + id + "\"" +
                ",\"roleid\"=\"" + roleid + "\"" +
                ",\"roleDesc\"=\"" + roleDesc + "\"" +
                "}";
    }
}
