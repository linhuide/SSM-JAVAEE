package com.controller;

import com.domain.Customer;
import com.domain.Order;
import com.domain.UserInfo;
import com.github.pagehelper.PageInfo;
import com.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/order")
public class OrderController {

    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;
    @Autowired
    private CustomerService customerService;

    //查询所有顾客
    @RequestMapping("/show.do")
    public String show(Integer id, Model model) throws Exception {
        List<Order> orders = orderService.findAll2();
        for (Order order : orders) {
            if (order.getId().equals(id)) {
                model.addAttribute("order", order);
                System.out.println(order);
            }
        }
        return "order/order-show";
    }

    //查询所有顾客
    @RequestMapping("/findAll.do")
    public String findAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                          @RequestParam(name = "size", required = true, defaultValue = "4") Integer size,
                          String orderNum, Integer userid, Model model) throws Exception {
        List<Order> order2 = orderService.findAll2();
        List<Order> order = orderService.findAll(page, size, orderNum, userid);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo = new PageInfo(order);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("order2", order2);

        List<UserInfo> user2 = userService.findAll2();
        model.addAttribute("user2", user2);
        List<Customer> customers2 = customerService.findAll2();
        model.addAttribute("customers2", customers2);
        return "order/order";
    }

    //查询单个顾客
    @RequestMapping("/findById.do")
    @ResponseBody
    public Order findById(Integer id) throws Exception {
        Order order = orderService.findById(id);
        return order;
    }

    //查询**是否存在
    @RequestMapping("/findcheck.do")
    @ResponseBody
    public String findcheck(String orderNum) throws Exception {
        List<Order> orders = orderService.findAll2();
        for (Order order : orders) {
            if (order.getOrderNum().equals(orderNum)) {
                return "OK";
            }
        }
        return "FAIL";
    }

    //查询月额是否足够是否存在
    @RequestMapping("/findcheckmoney.do")
    @ResponseBody
    public String findcheckmoney(Integer money, Integer customerid) throws Exception {
        Customer customer = customerService.findcheckmoney(customerid, money);
        System.out.println(customer);
        if (customer == null) {
            return "FAIL";
        }
        return "OK";
    }

    //增加
    @RequestMapping(value = "/create.do", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String create(Order order) throws Exception {
        if (order.getOrderNum().isEmpty()) {
            return "FAIL";
        }
        int userid = order.getUserid();

        if (orderService.findById(userid) != null) {
            return "订单中已存在这个用户，不能再创建订单";
        }
        //对时间的设置
        if (order.getOrderTime() != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(order.getOrderTime());
            if (order.getOrderStatus() == 1) {
                cal.add(Calendar.MONTH, 1);
            }
            if (order.getOrderStatus() == 2) {
                cal.add(Calendar.YEAR, 1);
            }
            order.setMaturityTime(cal.getTime());
        }
        int rows = orderService.insert(order);
        if (rows > 0) {
            String ok = updatemoney("创建", order.getCustomerid(), order.getMoney(), order.getOrderStatus());
            return ok;
        } else {
            return "FAIL";
        }
    }

    //删除
    @RequestMapping(value = "/delete.do", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String delete(Integer id) throws Exception {
        int rows = orderService.delete(id);
        if (rows > 0) {
            return "OK";
        } else {
            return "删除失败,请检查";
        }
    }

    //修改
    @RequestMapping(value = "/update.do", produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String update(Order order) throws Exception {
        if (order.getOrderTime() != null) {
            Calendar cal = Calendar.getInstance();
            cal.setTime(order.getOrderTime());
            if (order.getOrderStatus() == 1) {
                cal.add(Calendar.MONTH, 1);
            }
            if (order.getOrderStatus() == 2) {
                cal.add(Calendar.YEAR, 1);
            }
            order.setMaturityTime(cal.getTime());
        }
        int oldstatus = orderService.findStatus(order.getId());
        int rows = orderService.update(order);
        if (rows > 0) {
            //当缴费类型不同才能改
            if (order.getOrderStatus() != oldstatus) {
                //月租改为年租，减290
                String ok = null;
                if (order.getOrderStatus() == 2)
                    ok = updatemoney("修改", order.getCustomerid(), 290, order.getOrderStatus());
                //年租改为月租，当月钱不扣
                if (order.getOrderStatus() == 1) {
                    ok = updatemoney("修改", order.getCustomerid(), 0, order.getOrderStatus());
                }
                return ok;
            }
            return "OK";
        } else {
            return "FAIL";
        }
    }

    private String updatemoney(String name, Integer id, Integer money, Integer status) throws Exception {
        //修改订单成功，要对客户的账户余额进行减
        int rows2 = customerService.updatemoney(id, money, status);
        if (rows2 > 0) {
            return "成功" + name + "订单，同时在客户账户余额减去相应的价钱" + money;
        }
        return "在客户账户余额减去相应的价钱失败";
    }

    //缴费功能
    @RequestMapping(value = "/insertmoney.do", produces = "text/plain;charset=utf-8")
    public String insertmoney(Integer id, Integer number, RedirectAttributes ra) throws Exception {
        if(number==null){
            ra.addFlashAttribute("jiaofei","金额不能为空");
            return "redirect:findAll.do";
        }
        int rows=customerService.insertmoney(id,number);
        if (rows > 0) {
            ra.addFlashAttribute("jiaofei","缴费成功");
        } else {
            ra.addFlashAttribute("jiaofei","缴费失败");
        }
        return "redirect:findAll.do";
    }
}
