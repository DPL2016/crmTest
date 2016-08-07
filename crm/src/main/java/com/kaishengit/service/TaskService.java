package com.kaishengit.service;

import com.cronutils.builder.CronBuilder;
import com.cronutils.model.Cron;
import com.cronutils.model.CronType;
import com.cronutils.model.definition.CronDefinitionBuilder;
import com.cronutils.model.field.expression.QuestionMark;
import com.kaishengit.job.TaskReminJob;
import com.kaishengit.mapper.TaskMapper;
import com.kaishengit.pojo.Task;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.quartz.*;
import org.springframework.scheduling.quartz.SchedulerFactoryBean;

import javax.inject.Inject;
import javax.inject.Named;
import java.text.DateFormat;
import java.util.List;

import static com.cronutils.model.field.expression.FieldExpressionFactory.on;
import static com.cronutils.model.field.expression.FieldExpressionFactory.questionMark;

@Named
public class TaskService {
    @Inject
    private TaskMapper taskMapper;

    @Inject
    private SchedulerFactoryBean schedulerFactoryBean;

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
            task.setUserid(ShiroUtil.getCurrentUserID());
            taskMapper.save(task);
            DateTime dateTime = DateTimeFormat.forPattern("yyyy-MM-dd HH:mm:ss").parseDateTime(remindertime);
            //datetime -> cron
            Cron cron = CronBuilder.cron(CronDefinitionBuilder.instanceDefinitionFor(CronType.QUARTZ))
                    .withYear(on(dateTime.getYear()))
                    .withMonth(on(dateTime.getMonthOfYear()))
                    .withDoM(on(dateTime.getDayOfMonth()))
                    .withHour(on(dateTime.getHourOfDay()))
                    .withMinute(on(dateTime.getMinuteOfHour()))
                    .withSecond(on(0))
                    .withDoW(questionMark()).instance();
            String cronExpress = cron.asString();
            JobDetail jobDetail = JobBuilder.newJob(TaskReminJob.class)
                    .usingJobData("context",task.getTitle())
                    .withIdentity("task:"+task.getId(),"task")
                    .build();
            ScheduleBuilder scheduleBuilder = CronScheduleBuilder.cronSchedule(cronExpress);
            Trigger trigger = TriggerBuilder.newTrigger().withSchedule(scheduleBuilder).build();
            Scheduler scheduler = schedulerFactoryBean.getScheduler();
            try {
                scheduler.scheduleJob(jobDetail,trigger);
            } catch (SchedulerException e) {
                throw new RuntimeException(e);
            }
        }else {
            task.setUserid(ShiroUtil.getCurrentUserID());

            taskMapper.save(task);
        }
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

    public List<Task> findTaskByCustid(Integer userid, Integer custid) {
        return taskMapper.findTaskByCustid(userid,custid);
    }

    public List<Task> findTaskBySalesId(Integer salesid) {
        return taskMapper.findTaskBySalesId(salesid);
    }

}
