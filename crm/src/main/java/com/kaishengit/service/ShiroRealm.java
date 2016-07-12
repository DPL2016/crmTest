package com.kaishengit.service;

import com.kaishengit.mapper.RoleMapper;
import com.kaishengit.mapper.UserMapper;
import com.kaishengit.pojo.Role;
import com.kaishengit.pojo.User;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.inject.Named;

@Named
public class ShiroRealm extends AuthorizingRealm {
    private Logger logger = LoggerFactory.getLogger(ShiroRealm.class);
    @Inject
    private UserMapper userMapper;
    @Inject
    private RoleMapper roleMapper;

    /**
     * 验证用户是否具有权限
     *
     * @param principalCollection
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        User user = (User) principalCollection.getPrimaryPrincipal();
        if (user!=null){
            Integer roleId = user.getRoleid();
            Role role = roleMapper.findById(roleId);
            SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
            info.addRole(role.getRolename());
            return info;
        }
        return null;
    }

    /**
     * 验证账号密码是否正确
     *
     * @param authenticationToken
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        UsernamePasswordToken token = (UsernamePasswordToken) authenticationToken;
        String username = token.getUsername();
        User user = userMapper.findByUsername(username);
        if (user != null) {
            if (!user.getEnable()) {
                throw new LockedAccountException("账号已被禁用");
            }
            return new SimpleAuthenticationInfo(user,user.getPassword(),getName());
        } else {
            throw new UnknownAccountException("账号或密码错误");
        }


    }
}
