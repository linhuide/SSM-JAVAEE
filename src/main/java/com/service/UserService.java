package com.service;

import com.domain.UserInfo;

import java.util.List;

public interface UserService {

    //查询所有
    public UserInfo findByUsername(String username) throws Exception;

    //查询所有
    public List<UserInfo> findAll(int page, int size, String username,Integer status) throws Exception;

    //查询所有，没有搜索框
    public List<UserInfo> findAll2() throws Exception;

    //增加
    public int insert(UserInfo user) throws Exception;

    //删除
    public int delete(Integer id)  throws Exception;

    //修改
    public int update(UserInfo user)   throws Exception;

    //根据id去查询，添加到修改里
    public UserInfo findById(Integer id)   throws Exception;
}
