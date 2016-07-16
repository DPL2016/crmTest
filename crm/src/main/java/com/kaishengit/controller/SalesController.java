package com.kaishengit.controller;

import com.google.common.collect.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.mapper.SalesMapper;
import com.kaishengit.pojo.Customer;
import com.kaishengit.pojo.Sales;
import com.kaishengit.service.CustomerService;
import com.kaishengit.service.SalesService;
import com.kaishengit.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales")
public class SalesController {
    @Inject
    private CustomerService customerService;
    @Inject
    private SalesService salesService;

    /**
     * 显示机会页面
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(){
        return "sales/list";
    }

    /**
     * 发送客户列表
     * @return
     */
    @RequestMapping(value = "/customer.json",method = RequestMethod.GET)
    @ResponseBody
    public List<Customer> showAllCustomer(){
        return customerService.findAllCustomer();
    }

    /**
     * 加载机会列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTablesResult<Sales> load(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String name = request.getParameter("name");
        name = Strings.toUTF8(name);
        String progress = request.getParameter("progress");
        progress = Strings.toUTF8(progress);
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("name",name);
        params.put("progress",progress);
        params.put("startDate",startDate);
        params.put("endDate",endDate);
        List<Sales> salesList = salesService.findAllSales();
        Long count = salesService.count();
        Long filterCount = salesService.countByparam(params);
        return new DataTablesResult<>(draw,salesList,count,filterCount);
    }

    /**
     * 新增机会
     * @param sales
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String saveSales(Sales sales){
        salesService.saveSales(sales);
        return "success";
    }
}
