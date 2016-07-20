package com.kaishengit.service;

import com.kaishengit.mapper.TaskMapper;
import com.kaishengit.pojo.Task;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

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

    public void delTask(Integer id) {
        taskMapper.del(id);
    }

    public Task doneTask(Integer id) {
        Task task = taskMapper.findById(id);
        task.setDone(true);
        task.setColor("#cccccc");
        taskMapper.update(task);
        return task;
    }

    public List<Task> findTimeOutTasks() {
        String today = DateTime.now().toString("yyyy-MM-dd");
        return taskMapper.findTimeOutTasks(ShiroUtil.getCurrentUserID(),today);
    }

    public List<Task> findTaskByCustid(Integer custid) {
        return taskMapper.findTaskByCustid(custid);
    }

    public List<Task> findTaskBySalesId(Integer salesid) {
        return taskMapper.findTaskBySalesId(salesid);
    }

    public List<Task> findDoneTask() {
        return taskMapper.findDoneTask();
    }
}
