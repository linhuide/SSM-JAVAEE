package com.service;

import com.domain.Role;

import java.util.List;

public interface RoleService {

    //查询所有
    public List<Role> findAll2() throws Exception;

    //查询所有
    public List<Role> findAll(int page, int size) throws Exception;

    //增加
    public int insert(Role role) throws Exception;

    //删除
    public int delete(Integer id)  throws Exception;

    //修改
    public int update(Role role)   throws Exception;

    //根据id去查询，添加到修改里
    public Role findById(Integer id)   throws Exception;

}
