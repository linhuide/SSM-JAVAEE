package com.domain;

import java.util.List;

/**
 * 用户表（User）
 * id，username,password,phone,email,status,roleid
 * id,名字，密码，联系方式，邮件，状态（0，正常使用，1，异常中）,角色id
 */
public class UserInfo {
    private Integer id;
    private String username;
    private String password;
    private String phone;
    private String email;
    private Integer status;
    private String statusStr;
    private Integer roleid;
    private Role roles;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
        //状态（0，正常使用，1，异常中）
        if(status==0){
            statusStr="正常使用";
        }else if(status==1){
            statusStr="异常中";
        }
    }

    public String getStatusStr() {
        return statusStr;
    }

    public void setStatusStr(String statusStr) {
        this.statusStr = statusStr;
    }

    public Role getRoles() {
        return roles;
    }

    public void setRoles(Role roles) {
        this.roles = roles;
    }

    public Integer getRoleid() {
        return roleid;
    }

    public void setRoleid(Integer roleid) {
        this.roleid = roleid;
    }

    @Override
    public String toString() {
        return "{" +
                "\"id\"=" + id +
                ",\"username\"=\"" + username + "\"" +
                ",\"password\"=\"" + password + "\"" +
                ",\"phone\"=\"" + phone + "\"" +
                ",\"email\"=\"" + email + "\"" +
                ",\"status\"=" + status +
                ",\"statusStr\"=\"" + statusStr + "\"" +
                ",\"roleid\"=" + roleid +
                ",\"roles\"=" + roles +
                "}";
    }
}
