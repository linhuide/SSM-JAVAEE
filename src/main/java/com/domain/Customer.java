package com.domain;

/**
 * 客户实体类
 * id,username,sex,phone,email,indestry,level,number
 * id，名字，性别，联系方式，邮件,所在专业,客户级别,账户余额
 * （0为新建用户，还没下订单，1为包月客户，2为包年客户）
 */
public class Customer {
    private Integer id;         //id
    private String username;    //名字
    private String sex;         //性别
    private String phone;       //联系方式
    private String email;       //邮件
    private String indestry;    //所在专业
    private Integer level;      //客户级别（0为包月客户，1为包年客户）
    private String levelStr;
    private Integer number;     //账户余额

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

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
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

    public String getIndestry() {
        return indestry;
    }

    public void setIndestry(String indestry) {
        this.indestry = indestry;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
        //客户级别（0为新建用户，还没下订单，1为包月客户，2为包年客户）
        if (level != null) {
            if(level==0)
                levelStr="新建用户，还没下订单";
            if(level==1)
                levelStr="包月客户";
            if(level==2)
                levelStr="包年客户";
        }
    }

    public String getLevelStr() {
        return levelStr;
    }

    public void setLevelStr(String levelStr) {
        this.levelStr = levelStr;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    @Override
    public String toString() {
        return "{" +
                "\"id\"=" + id +
                ",\"username\"=\"" + username + "\"" +
                ",\"sex\"=\"" + sex + "\"" +
                ",\"phone\"=\"" + phone + "\"" +
                ",\"email\"=\"" + email + "\"" +
                ",\"indestry\"=\"" + indestry + "\"" +
                ",\"level\"=" + level +
                ",\"levelStr\"=\"" + levelStr + "\"" +
                ",\"number\"=" + number +
                "}";
    }
}
