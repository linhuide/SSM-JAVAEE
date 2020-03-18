package com.dao;

import com.domain.Role;
import com.domain.UserInfo;
import org.apache.ibatis.annotations.*;

import java.util.List;

/**
 * 管理
 */
public interface RoleDao {

    //查询所有
    @Select("select * from role ")
    public List<Role> findAll() throws Exception;

    //增加
    @Insert("INSERT INTO role(roleid,roleDesc) " +
            "VALUES(#{roleid},#{roleDesc})")
    public int insert(Role role);

    //删除
    @Delete("delete from role where id=#{id}")
    public int delete(Integer id)  throws Exception;

    //修改
    @Update({"<script> update role <set> <if test='roleid!=null'>  roleid=#{roleid},</if>"+
            "  <if test='roleDesc!=null'>	roleDesc=#{roleDesc},	</if>	"+
            "  </set> where id=#{id} </script>"})
    public int update(Role role)   throws Exception;

    //根据id去查询，添加到修改里
    @Select("select * from role where id=#{id}")
    public Role findById(Integer id)   throws Exception;

}
