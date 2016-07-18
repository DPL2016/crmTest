package com.kaishengit.service;

import com.kaishengit.mapper.TaskMapper;
import com.kaishengit.pojo.Task;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.lang3.StringUtils;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;

@Named
public class TaskService {
    @Inject
    private TaskMapper taskMapper;
    public List<Task> findTaskByUserId() {
        return taskMapper.findByUserId(ShiroUtil.getCurrentUserID());
    }

    /**
     * 保存待办事件
     * @param task
     * @param hour
     * @param min
     */
    public void saveTask(Task task, String hour, String min) {
        if (StringUtils.isNotEmpty(hour)&&StringUtils.isNotEmpty(min)){
            String remindertime = task.getStart()+" "+hour+ ":" + min + ":00";
            task.setRemindertime(remindertime);
        }
        task.setUserid(ShiroUtil.getCurrentUserID());
        taskMapper.save(task);
    }

}
