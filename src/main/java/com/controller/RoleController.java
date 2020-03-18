package com.controller;

import com.domain.Role;
import com.github.pagehelper.PageInfo;
import com.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.security.RolesAllowed;
import java.util.List;

@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    //查询所有顾客
    @RequestMapping("/findAll.do")
    @RolesAllowed({"ADMIN"})
    public String findAll(@RequestParam(name = "page", required = true, defaultValue = "1") Integer page,
                          @RequestParam(name = "size", required = true, defaultValue = "4") Integer size,
                          Model model) throws Exception {
        List<Role> role= roleService.findAll(page,size);
        //PageInfo就是一个分页Bean
        PageInfo pageInfo = new PageInfo(role);
        model.addAttribute("pageInfo", pageInfo);
        return "role/role";
    }

    //查询单个顾客
    @RequestMapping("/findById.do")
    @ResponseBody
    public Role findById(Integer id) throws Exception {
        Role role= roleService.findById(id);
        return role;
    }

    //增加
    @RequestMapping("/create.do")
    @ResponseBody
    public String create(Role role) throws Exception {

        int rows = roleService.insert(role);
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
        int rows = roleService.delete(id);
        if (rows > 0) {
            return "OK";
        } else {
            return "删除失败,请检查";
        }
    }

    //修改
    @RequestMapping("/update.do")
    @ResponseBody
    public String update(Role role) throws Exception {
        int rows = roleService.update(role);
        if (rows > 0) {
            return "OK";
        } else {
            return "FAIL";
        }
    }

}
