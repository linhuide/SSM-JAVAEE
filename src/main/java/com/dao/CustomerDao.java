package com.dao;

import com.domain.Customer;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 客户管理
 * id,username,sex,phone,email,indestry,level,number
 */
public interface CustomerDao {
    //根据id去查询，添加到修改里
    @Select("select * from customer where id=#{id} and number>=#{money}")
    public Customer findcheckmoney(@Param(value="id")Integer id,@Param(value="money")Integer money)   throws Exception;


    //查询所有
    @Select({"<script> select * from customer <where> " +
            "<if test='username!=null '> username like concat('%',#{username},'%')  </if> "+
            "<if test='level!=null '> level=#{level} </if> "+
            "</where> </script>"})
    public List<Customer> findAll(Customer customer) throws Exception;

    //查询所有,没有搜索框
    @Select("select * from customer")
    public List<Customer> findAll2(Customer customer) throws Exception;

    //增加
    @Insert("INSERT INTO customer(username,sex,phone,email,indestry,level,number) VALUES" +
            "(#{username},#{sex},#{phone},#{email},#{indestry},#{level},#{number})")
    public int insert(Customer customer) throws Exception;

    //修改
    @Update({"<script> update customer <set> <if test='username!=null'>  username=#{username},</if>"+
            "  <if test='sex!=null'>	sex=#{sex},	</if>	"+
            "  <if test='phone!=null'>	phone=#{phone},	</if>"+
            "  <if test='email!=null'>	email=#{email},	</if>"+
            "  <if test='indestry!=null'>	indestry=#{indestry},	</if>	"+
            "  <if test='level!=null'>	level=#{level},	</if>"+
            "  <if test='number!=null'>	number=#{number},	</if>"+
            "  </set> where id=#{id} </script>"})
    public int update(Customer customer)   throws Exception;

    //删除
    @Delete("delete from customer where id=#{id} and id not in (select customerid from orders)")
    public int delete(Integer id)  throws Exception;

    //根据id去查询，添加到修改里
    @Select("select * from customer where id=#{id}")
    public Customer findById(Integer id)   throws Exception;

    @Update({"<script> update customer <set> "+
            "  <if test='number!=null'>	number=number-#{number},	</if>"+
            "  <if test='level!=null'>	level=#{level},	</if>"+
            "  </set> where id=#{id} </script>"})
    public int updatemoney(@Param(value="id")Integer id,@Param(value="number") Integer number,@Param(value="level") Integer level) throws Exception;

    @Update({"<script> update customer <set> "+
            "  <if test='number!=null'>	number=number+#{number},	</if>"+
            "  </set> where id=#{id} </script>"})
    public int insertmoney(@Param(value="id")Integer id,@Param(value="number") Integer number) throws Exception;
}
