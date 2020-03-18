package com.controller;


import com.domain.Customer;
import com.github.pagehelper.PageInfo;
import com.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    //查询所有顾客
    @RequestMapping("/findAll.do")
    public String findAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                          @RequestParam(name = "size", required = true, defaultValue = "4") Integer size,
                          String username,Integer level,Model model) throws Exception {
        List<Customer> customers2= customerService.findAll2();
        List<Customer> customers= customerService.findAll(page,size,username,level);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo = new PageInfo(customers);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("customers2", customers2);
        return "customer/customer";
    }

    //查询单个顾客
    @RequestMapping("/findById.do")
    @ResponseBody
    public Customer findById(Integer id) throws Exception {
        Customer customers= customerService.findById(id);
        return customers;
    }

    //增加
    @RequestMapping("/create.do")
    @ResponseBody
    public String create(Customer customer) throws Exception {
        customer.setLevel(0);
        int rows = customerService.insert(customer);
        if (rows > 0) {
            return "OK";
        } else {
            return "FAIL";
        }
    }

    //删除
    @RequestMapping(value="/delete.do", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String delete(Integer id) throws Exception {
        int rows = customerService.delete(id);
        if (rows > 0) {
            return "OK";
        } else {
            return "删除顾客信息失败,请检查订单中是否还有该客户的订单存在";
        }
    }

    //修改
    @RequestMapping("/update.do")
    @ResponseBody
    public String update(Customer customer) throws Exception {
        int rows = customerService.update(customer);
        if (rows > 0) {
            return "OK";
        } else {
            return "FAIL";
        }
    }

}
