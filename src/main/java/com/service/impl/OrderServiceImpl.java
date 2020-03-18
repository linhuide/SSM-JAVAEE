package com.service.impl;


import com.dao.OrderDao;
import com.domain.Order;
import com.github.pagehelper.PageHelper;
import com.service.OrderService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {

    @Autowired
    private OrderDao OrderDao;

    //查询所有信息，并分页
    @Override
    public List<Order> findAll(int page, int size,String orderNum,Integer userid) throws Exception {
        Order order=new Order();
        if(StringUtils.isNotBlank(orderNum)){
            order.setOrderNum(orderNum);
        }
        if(userid!=null){
            order.setUserid(userid);
        }
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page, size);
        return OrderDao.findAll(order);
    }

    //查询所有信息，没有搜索框
    @Override
    public List<Order> findAll2() throws Exception {
        Order order=new Order();
        return OrderDao.findAll2(order);
    }

    //增加
    @Override
    public int insert(Order order) throws Exception {
        return OrderDao.insert(order);
    }

    //删除
    @Override
    public int delete(Integer id) throws Exception {
        return OrderDao.delete(id);
    }

    //修改
    @Override
    public int update(Order order) throws Exception {
        return OrderDao.update(order);
    }

    //根据id查询，添加到修改页面
    @Override
    public Order findById(Integer id) throws Exception {
        return OrderDao.findById(id);
    }

    //根据id去查询状态
    @Override
    public Integer findStatus(Integer id) throws Exception {
        return OrderDao.findStatus(id);
    }


}
