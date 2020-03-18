package com.dao;

import com.domain.Role;
import com.domain.UserInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 管理
 */
public interface UserDao {

    //修改密码
    @Update({"<script> update user <set> <if test='password!=null'>  password=#{password}, </if>"+
            "  </set> where username=#{username} </script>"})
    public int updateUserpwd(@Param("password") String password,@Param("username") String username)  throws Exception;



    //根据username查询user和role
    @Select("select * from user where username=#{username}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "phone", column = "phone"),
            @Result(property = "email", column = "email"),
            @Result(property = "status", column = "status"),
            @Result(property = "roleid", column = "roleid"),
            @Result(property = "roles",column = "roleid",javaType = Role.class,
                    one = @One(select = "com.dao.RoleDao.findById"))
    })
    public UserInfo findByUsername(String username)   throws Exception;


    //查询所有
    @Select({"<script> select * from user <where> " +
            "<if test='username!=null '> username=#{username} </if> "+
            "<if test='status!=null '> status=#{status} </if> "+
            "</where> </script>"})
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "phone", column = "phone"),
            @Result(property = "email", column = "email"),
            @Result(property = "status", column = "status"),
            @Result(property = "roleid", column = "roleid"),
            @Result(property = "roles",column = "roleid",javaType = Role.class,
                    one = @One(select = "com.dao.RoleDao.findById"))
    })
    public List<UserInfo> findAll(UserInfo user) throws Exception;

    //查询所有,没有搜索框
    @Select("select * from user")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "phone", column = "phone"),
            @Result(property = "email", column = "email"),
            @Result(property = "status", column = "status"),
            @Result(property = "roleid", column = "roleid"),
            @Result(property = "roles",column = "roleid",javaType = Role.class,
                    one = @One(select = "com.dao.RoleDao.findById"))
    })
    public List<UserInfo> findAll2(UserInfo user) throws Exception;

    //增加
    @Insert("INSERT INTO user(username,password,phone,email,status,roleid) " +
            "VALUES(#{username},#{password},#{phone},#{email},#{status},#{roleid})")
    public int insert(UserInfo user);

    //删除
    @Delete("delete from user where id=#{id}")
    public int delete(Integer id)  throws Exception;

    //修改
    @Update({"<script> update user <set> <if test='username!=null'>  username=#{username},</if>"+
            "  <if test='password!=null'>	password=#{password},	</if>	"+
            "  <if test='phone!=null'>	phone=#{phone},	</if>"+
            "  <if test='email!=null'>	email=#{email},	</if>	"+
            "  <if test='status!=null'>	status=#{status},	</if>"+
            "  <if test='roleid!=null'>	roleid=#{roleid},	</if>"+
            "  </set> where id=#{id} </script>"})
    public int update(UserInfo user)   throws Exception;

    //根据id去查询，添加到修改里
    @Select("select * from user where id=#{id}")
    @Results({
            @Result(id = true, property = "id", column = "id"),
            @Result(property = "username", column = "username"),
            @Result(property = "password", column = "password"),
            @Result(property = "phone", column = "phone"),
            @Result(property = "email", column = "email"),
            @Result(property = "status", column = "status"),
            @Result(property = "roleid", column = "roleid"),
            @Result(property = "roles",column = "roleid",javaType = Role.class,
                    one = @One(select = "com.dao.RoleDao.findById"))
    })
    public UserInfo findById(Integer id)   throws Exception;

}
