package com.kaishengit.mapper;

import com.kaishengit.pojo.User;

import java.util.List;
import java.util.Map;

public interface UserMapper {
    User findByUsername(String username);

    void updateUser(User user);

    List<User> findByParam(Map<String, Object> param);

    Long countUser();

    Long countByParam();

    void save(User user);

    User findUserByUserName(String username);

    User findById(Integer id);
}
