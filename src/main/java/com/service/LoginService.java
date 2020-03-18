package com.service;

import com.domain.UserInfo;
import org.springframework.security.core.userdetails.UserDetailsService;

public interface LoginService extends UserDetailsService {
    public int changePassword(String username,String oldpassword,String newpassword);
    //修改名字
    public int changeName(String name,UserInfo user) throws Exception;
}
