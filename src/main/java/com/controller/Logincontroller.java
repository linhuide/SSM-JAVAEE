package com.controller;

import com.domain.Role;
import com.service.LoginService;
import com.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;

@Controller
@RequestMapping("/login")
public class Logincontroller {

    @Autowired
    private LoginService loginService;
    @Autowired
    private RoleService roleService;



    @RequestMapping("/login.do")
    public String login(){
        return "login/login";
    }

    @RequestMapping("/main.do")
    public String main(Model model) throws Exception {
        //如果登录了，name即用户名；如果没有登录，默认为 anonymousUser
        //方法一、
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        String name = auth.getName(); //主体名，即登录用户名
        model.addAttribute("username",name);
        return "main";
    }

    //修改密码页面跳转
    @RequestMapping("/update.do")
    public String update() {
        return "login/updatepwd";
    }

    //修改密码
    @RequestMapping("/updatepwd.do")
    public String updatepwd(String username, String oldpassword, String newpassword, Model ra) {
        int rows=loginService.changePassword(username,oldpassword,newpassword);
        if (rows > 0) {
            ra.addAttribute("updatepwd", "密码修改成功，请重新登录");
        } else {
            ra.addAttribute("updatepwd", "修改失败");
        }
        return "main";
    }
}
