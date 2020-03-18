package com.service.impl;


import com.dao.RoleDao;
import com.domain.Role;
import com.github.pagehelper.PageHelper;
import com.service.RoleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleDao roleDao;


    @Override
    public List<Role> findAll2() throws Exception {
        return roleDao.findAll();
    }

    //查询所有信息，并分页
    @Override
    public List<Role> findAll(int page, int size) throws Exception {
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page, size);
        return roleDao.findAll();
    }

    //增加
    @Override
    public int insert(Role role) throws Exception {
        return roleDao.insert(role);
    }

    //删除
    @Override
    public int delete(Integer id) throws Exception {
        return roleDao.delete(id);
    }

    //修改
    @Override
    public int update(Role role) throws Exception {
        return roleDao.update(role);
    }

    //根据id查询，添加到修改页面
    @Override
    public Role findById(Integer id) throws Exception {
        return roleDao.findById(id);
    }

}
