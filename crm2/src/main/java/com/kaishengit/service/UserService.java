package com.kaishengit.service;

import com.google.common.collect.Maps;
import com.kaishengit.mapper.RoleMapper;
import com.kaishengit.mapper.UserLogMapper;
import com.kaishengit.mapper.UserMapper;
import com.kaishengit.pojo.User;
import com.kaishengit.pojo.UserLog;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class UserService {

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
        userLog.setUserid(ShiroUtil.getCurrentUserId());
        userLogMapper.save(userLog);
    }

    public void changePassword(String password) {
        User user = ShiroUtil.getCurrentUser();
        user.setPassword(DigestUtils.md5Hex(password));
        userMapper.updateUser(user);
    }

    public List<UserLog> findCurrentUserLog(String start, String length) {
        Map<String,Object> param = Maps.newHashMap();
        param.put("userId",ShiroUtil.getCurrentUserId());
        param.put("length",length);
        param.put("start",start);
        return userMapper.findByParam(param);
    }

    public Long findCurrentUserLogCount() {
        Map<String,Object> param = Maps.newHashMap();
        param.put("userId",ShiroUtil.getCurrentUserId());
        return userMapper.countByParam(param);
    }

    public List<User> findCurrentUser(String start, String length) {
        Map<String,Object> param = Maps.newHashMap();
        param.put("length",length);
        param.put("start",start);
        return userMapper.findUserByParam(param);
    }

    public Long findCurrentUserCount() {
        Map<String,Object> param = Maps.newHashMap();
        return userMapper.countUserByParam(param);
    }
}
