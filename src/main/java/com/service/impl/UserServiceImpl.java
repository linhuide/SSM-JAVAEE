package com.service.impl;

import com.dao.UserDao;
import com.domain.UserInfo;
import com.github.pagehelper.PageHelper;
import com.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;
    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    //根据名字查询用户和员工
    @Override
    public UserInfo findByUsername(String username) throws Exception {
        return userDao.findByUsername(username);
    }

    //查询所有信息，并分页
    @Override
    public List<UserInfo> findAll(int page, int size,String username,Integer status) throws Exception {
        UserInfo user=new UserInfo();
        if(StringUtils.isNotBlank(username)){
            user.setUsername(username);
        }
        if(status!=null){
            user.setStatus(status);
        }
        //参数pageNum 是页码值   参数pageSize 代表是每页显示条数
        PageHelper.startPage(page, size);
        return userDao.findAll(user);
    }

    //查询所有信息，没有搜索框
    @Override
    public List<UserInfo> findAll2() throws Exception {
        UserInfo user=new UserInfo();
        return userDao.findAll2(user);
    }

    //增加
    @Override
    public int insert(UserInfo user) throws Exception {
        //对密码进行加密处理
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        return userDao.insert(user);
    }

    //删除
    @Override
    public int delete(Integer id) throws Exception {
        return userDao.delete(id);
    }

    //修改
    @Override
    public int update(UserInfo user) throws Exception {
        return userDao.update(user);
    }

    //根据id查询，添加到修改页面
    @Override
    public UserInfo findById(Integer id) throws Exception {
        return userDao.findById(id);
    }
}
