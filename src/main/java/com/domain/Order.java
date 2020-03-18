package com.domain;


import com.domain.Customer;
import com.utils.DateUtils;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Calendar;
import java.util.Date;


/**
 * 订单表
 * id，订单编号（唯一），缴费人(客户外键)，缴费日期，到期日期(自动计算)，费用，缴费类型(1为包年/0为包月)，经办人(登录用户外键)
 * 包月：30，包年：330
 * id,orderNum,customerid,orderTime,maturityTime,money,orderStatus,userid
 */
public class Order {
    private Integer id;                         //id
    private String orderNum;                    //订单编号
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date orderTime;                     //下单时间
    private String orderTimeStr;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date maturityTime;                  //到期日期(自动计算)
    private String maturityTimeStr;
    private Integer money;                     //费用
    private Integer orderStatus;                //缴费类型(包年/包月)
    private String orderStatusStr;              //订单状态转str
    private Integer customerid;
    private Customer customer;
    private Integer userid;                     //经办人(登录用户外键)
    private UserInfo user;                      //用户值

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getOrderNum() {
        return orderNum;
    }

    public void setOrderNum(String orderNum) {
        this.orderNum = orderNum;
    }

    public Date getOrderTime() {
        return orderTime;
    }

    public void setOrderTime(Date orderTime) {
        this.orderTime = orderTime;
        if(orderTime!=null){
            orderTimeStr= DateUtils.date2String(orderTime,"yyyy-MM-dd HH:mm:ss");
        }

    }

    public Date getMaturityTime() {
        return maturityTime;
    }

    //如果参数 Date 等于此 Date，则返回值 0；
    //如果此 Date 在 Date 参数之前，则返回小于 0 的值
    public void setMaturityTime(Date maturityTime) {
        this.maturityTime = maturityTime;
        if(maturityTime!=null){
            //对时间进行减5天操作
            Date time=new Date();
            Calendar cal = Calendar.getInstance();
            cal.setTime(maturityTime);
            cal.add(Calendar.DATE,-5);
            maturityTime=cal.getTime();
            if(maturityTime.compareTo(time)<=0){
                maturityTimeStr= DateUtils.date2String(maturityTime,"yyyy-MM-dd HH:mm:ss")+"   请尽快在5天内缴费，时间快到期";
            }else{
                maturityTimeStr= DateUtils.date2String(maturityTime,"yyyy-MM-dd HH:mm:ss");
            }

        }
    }

    public Integer getMoney() {
        return money;
    }

    public void setMoney(Integer money) {
        this.money = money;
    }

    public Integer getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(Integer orderStatus) {
        this.orderStatus = orderStatus;
        //(1为包年/0为包月)
        if(orderStatus!=null){
            if(orderStatus==1){
                orderStatusStr="包月";
                money=30;
            }
            if(orderStatus==2){
                orderStatusStr="包年";
                money=320;
            }
        }
    }

    public String getOrderStatusStr() {
        return orderStatusStr;
    }

    public void setOrderStatusStr(String orderStatusStr) {
        this.orderStatusStr = orderStatusStr;
    }

    public Integer getUserid() {
        return userid;
    }

    public void setUserid(Integer userid) {
        this.userid = userid;
    }

    public UserInfo getUser() {
        return user;
    }

    public void setUser(UserInfo user) {
        this.user = user;
    }

    public String getOrderTimeStr() {
        return orderTimeStr;
    }

    public void setOrderTimeStr(String orderTimeStr) {
        this.orderTimeStr = orderTimeStr;
    }

    public String getMaturityTimeStr() {
        return maturityTimeStr;
    }

    public void setMaturityTimeStr(String maturityTimeStr) {
        this.maturityTimeStr = maturityTimeStr;
    }

    public Integer getCustomerid() {
        return customerid;
    }

    public void setCustomerid(Integer customerid) {
        this.customerid = customerid;
    }

    public Customer getCustomer() {
        return customer;
    }

    public void setCustomer(Customer customer) {
        this.customer = customer;
    }
}
