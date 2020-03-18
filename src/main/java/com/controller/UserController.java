package com.controller;

import com.domain.Role;
import com.domain.UserInfo;
import com.github.pagehelper.PageInfo;
import com.service.LoginService;
import com.service.RoleService;
import com.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.security.RolesAllowed;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private LoginService loginService;

    //查询个人信息
    @RequestMapping("/findstaff.do")
    public String findstaff(String username,Model model) throws Exception {
        UserInfo user= userService.findByUsername(username);
        model.addAttribute("user", user);
        return "user/staff";
    }

    //查询所有顾客
    @RequestMapping("/findAll.do")
    @RolesAllowed({"ADMIN"})
    public String findAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                          @RequestParam(name = "size", required = true, defaultValue = "4") Integer size,
                          String username, Integer status, Model model) throws Exception {
        List<UserInfo> user2= userService.findAll2();
        List<UserInfo> user= userService.findAll(page,size,username,status);
        List<Role> role= roleService.findAll(page,size);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo = new PageInfo(user);
        model.addAttribute("pageInfo", pageInfo);
        model.addAttribute("user2", user2);
        model.addAttribute("role", role);
        return "user/user";
    }

    //查询单个顾客
    @RequestMapping("/findById.do")
    @ResponseBody
    public UserInfo findById(Integer id) throws Exception {
        UserInfo user= userService.findById(id);
        System.out.println(user);
        return user;
    }

    //增加
    @RequestMapping("/create.do")
    @ResponseBody
    public String create(UserInfo user) throws Exception {
        if(user.getUsername().isEmpty()){
            return "FAIL";
        }
        if(user.getPassword().isEmpty()){
            return "FAIL";
        }

        int rows = userService.insert(user);
        if (rows > 0) {
            return "OK";
        } else {
            return "FAIL";
        }
    }

    //删除
    @RequestMapping(value="/delete.do",produces = "text/plain;charset=utf-8")
    @ResponseBody
    public String delete(Integer id) throws Exception {
        int rows = userService.delete(id);
        if (rows > 0) {
            return "OK";
        } else {
            return "删除失败,请检查";
        }
    }

    //修改
    @RequestMapping("/update.do")
    @ResponseBody
    public String update(UserInfo user) throws Exception {
        System.out.println("要修改的："+user);
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName(); //主体名，即登录用户名
        boolean remove=name.equals(userService.findById(user.getId()).getUsername());
        //true,是改自己名字，false，不是改自己名字
        int rows=0;
        if(remove){
            rows=loginService.changeName(name,user);
        }else {
            rows = userService.update(user);
        }
        if (rows >0) {
            return "OK";
        }else {
            return "FAIL";
        }
    }

}
