package com.kaishengit.service;

import com.google.common.collect.Maps;
import com.kaishengit.mapper.RoleMapper;
import com.kaishengit.mapper.UserLogMapper;
import com.kaishengit.mapper.UserMapper;
import com.kaishengit.pojo.Role;
import com.kaishengit.pojo.User;
import com.kaishengit.pojo.UserLog;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.joda.time.DateTime;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class UserService {
    private Logger logger = LoggerFactory.getLogger(UserService.class);
    @Inject
    private UserMapper userMapper;
    @Inject
    private UserLogMapper userLogMapper;
    @Inject
    private RoleMapper roleMapper;

    public void saveUserLogin(String ip) {
        UserLog userLog = new UserLog();
        userLog.setLoginip(ip);
        userLog.setLogintime(DateTime.now().toString("yyyy-MM-dd HH:mm"));
        userLog.setUserid(ShiroUtil.getCurrentUserID());
        userLogMapper.save(userLog);
    }

    public void changePassword(String password) {
        User user = ShiroUtil.getCurrentUser();
        user.setPassword(DigestUtils.md5Hex(password));
        userMapper.updateUser(user);
    }

    /**
     * 获取当前用户的登录日志
     * @param start
     * @param length
     * @return
     */
    public List<UserLog> findCurrentUserLog(String start, String length) {
        Map<String,Object>param = Maps.newHashMap();
        param.put("userId",ShiroUtil.getCurrentUserID());
        param.put("start",start);
        param.put("length",length);
        return userLogMapper.findByParam(param);
    }

    public Long findCurrentUserLogCount() {
        Map<String,Object>param = Maps.newHashMap();
        param.put("userId",ShiroUtil.getCurrentUserID());
        return userLogMapper.countByParam(param);
    }

    public List<User> findByParam(Map<String, Object> param) {
        return userMapper.findByParam(param);
    }

    public Long countUser() {
        return userMapper.countUser();
    }

    public Long countByParam() {
        return userMapper.countByParam();
    }


    public List<Role> findAllRole() {
        return roleMapper.findAllRole();
    }

    public void saveUser(User user) {
        user.setEnable(true);
        user.setPassword(DigestUtils.md5Hex(user.getPassword()));
        userMapper.save(user);
    }

    public User findUserByUserName(String username) {
        return userMapper.findUserByUserName(username);
    }

    /**
     * 重置用户密码
     * @param id 用户id
     */
    public void resetUserPassword(Integer id) {
        User user = userMapper.findById(id);
        if (user!=null){
            user.setPassword(DigestUtils.md5Hex("000000"));
            userMapper.updateUser(user);
        }
    }

    public void editUser(User user) {
        userMapper.updateUser(user);
    }

    public User findUserById(Integer id) {
        return userMapper.findById(id);
    }
}
