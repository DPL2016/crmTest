package com.kaishengit.mapper;

import com.kaishengit.pojo.Task;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TaskMapper {
    List<Task> findByUserId(Integer userid);

    void save(Task task);

    void del(Integer id);

    Task findById(Integer id);

    void update(Task task);


    List<Task> findTimeOutTasks(@Param("userId") Integer userID, @Param("today") String today);

    List<Task> findTaskByCustid(Integer custid);

    List<Task> findTaskBySalesId(Integer salesid);
}
