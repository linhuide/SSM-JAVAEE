package com.service.impl;

import com.dao.CustomerDao;
import com.domain.Customer;
import com.github.pagehelper.PageHelper;
import com.service.CustomerService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Override
    public Customer findcheckmoney(Integer id, Integer money) throws Exception {
        return customerDao.findcheckmoney(id,money);
    }

    //查询所有信息，并分页
    @Override
    public List<Customer> findAll(int page, int size,String username,Integer level) throws Exception {
        Customer customer=new Customer();
        if(StringUtils.isNotBlank(username)){
            customer.setUsername(username);
        }
        if(level!=null){
            customer.setLevel(level);
        }
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page, size);
        return customerDao.findAll(customer);
    }

    //查询所有信息，没有搜索框
    @Override
    public List<Customer> findAll2() throws Exception {
        Customer customer=new Customer();
        return customerDao.findAll2(customer);
    }

    //增加
    @Override
    public int insert(Customer customer) throws Exception {
        return customerDao.insert(customer);
    }

    //删除
    @Override
    public int delete(Integer id) throws Exception {
        return customerDao.delete(id);
    }

    //修改
    @Override
    public int update(Customer customer) throws Exception {
        return customerDao.update(customer);
    }

    //根据id查询，添加到修改页面
    @Override
    public Customer findById(Integer id) throws Exception {
        return customerDao.findById(id);
    }

    //下订单，修改金额
    @Override
    public int updatemoney(Integer id, Integer money,Integer status) throws Exception {
        return customerDao.updatemoney(id,money,status);
    }

    //缴费功能
    @Override
    public int insertmoney(Integer id, Integer money) throws Exception {
        return customerDao.insertmoney(id,money);
    }
}
