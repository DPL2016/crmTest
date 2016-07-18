package com.kaishengit.controller;

import com.kaishengit.dto.JSONResult;
import com.kaishengit.pojo.Task;
import com.kaishengit.service.TaskService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/task")
public class TaskController {
    @Inject
    private TaskService taskService;

    @RequestMapping(method = RequestMethod.GET)
    public String show(){
        return "task/view";
    }

    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public List<Task> load(){
        return taskService.findTaskByUserId();
    }

    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public JSONResult save(Task task,String hour,String min){
        taskService.saveTask(task,hour,min);
        return new JSONResult(task);
    }

}
