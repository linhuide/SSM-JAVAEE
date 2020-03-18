package com.service.impl;

import com.dao.UserDao;
import com.domain.Role;
import com.domain.UserInfo;
import com.service.LoginService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserCache;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.core.userdetails.cache.NullUserCache;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * 用户第一次登录使用的是旧密码，所以security框架中拥有的当前用户的凭证还是旧的，
 * 所以我们修改了密码之后要更新security框架中的用户凭证，而这个用户凭证是交给security框架中的securityContextHolder来维护的。
 * 所以我们修改了密码之后，只要创建一个新的用户凭证更新到色粗ContextHolder中，那么基于数据库修改密码的操作就真正的完成了
 */
@Service("loginservice")
@Transactional
public class LoginServiceImpl implements LoginService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private BCryptPasswordEncoder bCryptPasswordEncoder;

    private UserCache userCache = new NullUserCache();
    //修改名字
    @Override
    public int changeName(String name, UserInfo user) throws Exception {
        //需要创建一个新的凭证Authentication，并且更新到SecurityContextHolder
        Authentication currentuser = SecurityContextHolder.getContext().getAuthentication();
        if (currentuser == null) {
            //这表明某个地方的编码有问题
            throw new AccessDeniedException("Can't change password as no Authentication object found in context for current user.");
        }
        int rows = 0;
        try {
            rows = userDao.update(user);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("名字修改失败");
        }
        //移除用户缓存里面的缓存的旧数据
        SecurityContextHolder.getContext().setAuthentication(createNewAuthenticationName(currentuser, user.getUsername()));
        userCache.removeUserFromCache(name);
        System.out.println("修改自己名字成功");
        System.out.println("移除用户缓存里面的缓存的旧数据");
        return rows;
    }

    public Authentication createNewAuthenticationName(Authentication currentAuth, String name) {
        //移除用户缓存里面的缓存的旧数据,对新密码进行插入
        UserDetails user = loadUserByUsername(name);
        UsernamePasswordAuthenticationToken newAuthentication =
                new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
        newAuthentication.setDetails(currentAuth.getDetails());
        return newAuthentication;
    }


    //修改密码
    @Override
    public int changePassword(String username, String oldpassword, String newpassword) {
        //需要创建一个新的凭证Authentication，并且更新到SecurityContextHolder
        Authentication currentuser= SecurityContextHolder.getContext().getAuthentication();
        int rows=0;
        UserInfo userInfo = null;
        if(currentuser==null)
        {
            //这表明某个地方的编码有问题
            throw new AccessDeniedException("Can't change password as no Authentication object found in context for current user.");
        }
        //从SecurityContextHolder里面拿到这个Authentication凭证，然后再拿到相应的信息
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username2=((UserDetails)principal).getUsername();
        try {
            userInfo = userDao.findByUsername(username2);
        } catch (Exception e) {
            e.printStackTrace();
        }
        //旧密码比较，用方法进行
        //已经加密了
        if(bCryptPasswordEncoder.matches(oldpassword,userInfo.getPassword()))
        {
            try {
                //新密码进行加密
                newpassword=bCryptPasswordEncoder.encode(newpassword);
                rows=userDao.updateUserpwd(newpassword,username);
            } catch (Exception e) {
                System.out.println("新旧密码插入失败");
            }
            //移除用户缓存里面的缓存的旧数据
            SecurityContextHolder.getContext().setAuthentication(createNewAuthentication(currentuser, newpassword));
            userCache.removeUserFromCache(username);
        }else{
            System.out.println("旧密码不对");
        }
        return rows;
    }



    public Authentication createNewAuthentication(Authentication currentAuth, String newPassword)
    {
        //移除用户缓存里面的缓存的旧数据,对新密码进行插入
        UserDetails user = loadUserByUsername(currentAuth.getName());
        UsernamePasswordAuthenticationToken newAuthentication =
                new UsernamePasswordAuthenticationToken(user, user.getPassword(), user.getAuthorities());
        newAuthentication.setDetails(currentAuth.getDetails());
        return newAuthentication;
    }

    //登录验证
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UserInfo userInfo = null;
        try {
            userInfo = userDao.findByUsername(username);
        } catch (Exception e) {
            System.out.println("没有找到，出现异常");
            e.printStackTrace();
        }
        if(userInfo==null){
            throw new InternalAuthenticationServiceException("此用户不存在");
        }
        if(userInfo.getStatus() ==1 ){
            throw new DisabledException("账号被禁用");
        }
        //处理自己的用户对象封装成UserDetails
        User user = new User(userInfo.getUsername(), userInfo.getPassword(), userInfo.getStatus() == 0 ? true : false, true, true, true,
                getAuthority(userInfo.getRoles()));
        return user;
    }

    //作用就是返回一个List集合，集合中装入的是角色描述
    public List<SimpleGrantedAuthority> getAuthority(Role role) {
        List<SimpleGrantedAuthority> list = new ArrayList<>();
        list.add(new SimpleGrantedAuthority("ROLE_" + role.getRoleid()));
        list.add(new SimpleGrantedAuthority(role.getRoleDesc()));
        return list;
    }
}
