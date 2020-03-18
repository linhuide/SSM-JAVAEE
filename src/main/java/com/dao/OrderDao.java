package com.dao;

import com.domain.Customer;
import com.domain.Order;
import com.domain.UserInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 订单管理
 */
public interface OrderDao {

    //查询所有订单
    @Select({"<script> select * from orders <where> " +
            "<if test='orderNum!=null '> orderNum like concat('%',#{orderNum},'%') </if> "+
            "<if test='userid!=null '> userid=#{userid} </if> "+
            "</where> </script>"})
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "orderNum", column = "orderNum"),
            @Result(property = "customerid", column = "customerid"),
            @Result(property = "orderTime", column = "orderTime"),
            @Result(property = "maturityTime", column = "maturityTime"),
            @Result(property = "money", column = "money"),
            @Result(property = "orderStatus", column = "orderStatus"),
            @Result(property = "user", column = "userid", javaType = UserInfo.class,
                    one = @One(select = "com.dao.UserDao.findById")),
            @Result(property = "customer",column = "customerid",javaType = Customer.class,
                    one = @One(select = "com.dao.CustomerDao.findById")),
    })
    public List<Order> findAll(Order order) throws Exception;

    //查询所有订单,没有搜索框
    @Select("select * from orders")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "orderNum", column = "orderNum"),
            @Result(property = "customerid", column = "customerid"),
            @Result(property = "orderTime", column = "orderTime"),
            @Result(property = "maturityTime", column = "maturityTime"),
            @Result(property = "money", column = "money"),
            @Result(property = "orderStatus", column = "orderStatus"),
            @Result(property = "user", column = "userid", javaType = UserInfo.class,
                    one = @One(select = "com.dao.UserDao.findById")),
            @Result(property = "customer",column = "customerid",javaType = Customer.class,
                    one = @One(select = "com.dao.CustomerDao.findById")),
    })
    public List<Order> findAll2(Order order) throws Exception;

    //增加订单
    @Insert("INSERT INTO orders(orderNum,customerid,orderTime,maturityTime,money,orderStatus,userid) " +
            "VALUES(#{orderNum},#{customerid},#{orderTime},#{maturityTime},#{money},#{orderStatus},#{userid})")
    public int insert(Order order) throws Exception;

    //删除订单
    @Delete("delete from orders where id=#{id}")
    public int delete(Integer id)  throws Exception;

    //修改订单
    @Update({"<script> update orders <set> " +
            "<if test='orderNum!=null'>  orderNum=#{orderNum},</if>"+
            "<if test='customerid!=null'>	customerid=#{customerid},	</if>	"+
            "<if test='orderTime!=null'>  orderTime=#{orderTime},</if>"+
            "<if test='maturityTime!=null'>	maturityTime=#{maturityTime},	</if>	"+
            "<if test='money!=null'>  money=#{money},</if>"+
            "<if test='orderStatus!=null'>	orderStatus=#{orderStatus},	</if>	"+
            "<if test='userid!=null'>	userid=#{userid},	</if>	"+
            "</set> where id=#{id} </script>"})
    public int update(Order order)   throws Exception;

    //根据id去查询，添加到修改里
    @Select("select * from orders where id=#{id}")
    public Order findById(Integer id)   throws Exception;

    //根据id去查询，添加到修改里
    @Select("select orderStatus from orders where id=#{id}")
    public Integer findStatus(Integer id)   throws Exception;
}
