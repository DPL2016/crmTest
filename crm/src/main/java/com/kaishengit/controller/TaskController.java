package com.kaishengit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping(value = "/task")
public class TaskController {
    @RequestMapping(method = RequestMethod.GET)
    public String show(){
        return "task/view";
    }

}
