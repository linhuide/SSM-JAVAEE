package com.service;

import com.domain.Order;

import java.util.List;

public interface OrderService {

    //查询所有
    public List<Order> findAll(int page, int size,String orderNum,Integer userid) throws Exception;

    //查询所有，没有搜索框
    public List<Order> findAll2() throws Exception;

    //增加
    public int insert(Order order) throws Exception;

    //删除
    public int delete(Integer id)  throws Exception;

    //修改
    public int update(Order order)   throws Exception;

    //根据id去查询，添加到修改里
    public Order findById(Integer id)   throws Exception;

    //根据id去查询状态
    public Integer findStatus(Integer id)  throws Exception;
}
