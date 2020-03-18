package com.service;


import com.domain.Customer;

import java.util.List;

public interface CustomerService {
    //根据id和缴费，查询够不够钱
    public Customer findcheckmoney(Integer id,Integer money)   throws Exception;

    //查询所有
    public List<Customer> findAll(int page, int size, String username, Integer level) throws Exception;

    //查询所有，没有搜索框
    public List<Customer> findAll2() throws Exception;

    //增加
    public int insert(Customer customer) throws Exception;

    //删除
    public int delete(Integer id)  throws Exception;

    //修改
    public int update(Customer customer)   throws Exception;

    //根据id去查询，添加到修改里
    public Customer findById(Integer id)   throws Exception;

    //创建订单，减去相应的金钱
    public int updatemoney(Integer id, Integer money,Integer status) throws Exception;

    //创建订单，减去相应的金钱
    public int insertmoney(Integer id, Integer money)   throws Exception;
}
