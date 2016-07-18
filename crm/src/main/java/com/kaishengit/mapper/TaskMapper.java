package com.kaishengit.mapper;

import com.kaishengit.pojo.Task;

import java.util.List;

public interface TaskMapper {
    List<Task> findByUserId(Integer userid);

    void save(Task task);
}
