package com.kaishengit.mapper;

import com.kaishengit.pojo.User;
import com.kaishengit.pojo.UserLog;

import java.util.List;
import java.util.Map;

public interface UserMapper {


    User findByUsername(String username);

    void updateUser(User user);

    List<UserLog> findByParam(Map<String, Object> param);

    Long countByParam(Map<String, Object> param);

    Long countUserByParam(Map<String, Object> param);

    List<User> findUserByParam(Map<String, Object> param);
}
