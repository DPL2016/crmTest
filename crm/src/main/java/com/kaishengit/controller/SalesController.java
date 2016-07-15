package com.kaishengit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
@RequestMapping("/sales")
public class SalesController {
    @RequestMapping(method = RequestMethod.GET)
    public String list(){
        return "sales/list";
    }
}
