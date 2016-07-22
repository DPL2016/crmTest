package com.kaishengit.controller;

import com.kaishengit.dto.JSONResult;
import com.kaishengit.pojo.Task;
import com.kaishengit.service.TaskService;
import org.apache.commons.lang3.ObjectUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/task")
public class TaskController {
    @Inject
    private TaskService taskService;

    @RequestMapping(method = RequestMethod.GET)
    public String show(Model model) {
        List<Task> timeoutTaskList = taskService.findTimeOutTasks();
        model.addAttribute("timeoutTaskList",timeoutTaskList);
        return "task/view";
    }

    @RequestMapping(value = "/load", method = RequestMethod.GET)
    @ResponseBody
    public List<Task> load(Model model) {

        return taskService.findTaskByUserId();
    }

    /**
     * 新建待办事件
     *
     * @param task
     * @param hour
     * @param min
     * @return
     */
    @RequestMapping(value = "/new", method = RequestMethod.POST)
    @ResponseBody
    public JSONResult save(Task task, String hour, String min) {
        taskService.saveTask(task, hour, min);
        return new JSONResult(task);
    }
    /**
     * 删除
     */
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public String delTask(@PathVariable Integer id){
        taskService.delTask(id);
        return "success";
    }

    @RequestMapping(value = "/{id:\\d+}/done",method = RequestMethod.POST)
    @ResponseBody
    public JSONResult doneTask(@PathVariable Integer id){
        Task task = taskService.doneTask(id);
        return new JSONResult(task);
    }
}
