package com.kaishengit.service;

import com.google.common.collect.Maps;
import com.kaishengit.mapper.CustomerMapper;
import com.kaishengit.mapper.SalesMapper;
import com.kaishengit.pojo.Customer;
import com.kaishengit.pojo.Sales;
import com.kaishengit.util.ShiroUtil;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class SalesService {
    @Inject
    private SalesMapper salesMapper;
    @Inject
    private CustomerMapper customerMapper;

    public List<Sales> findAllSales() {
        return salesMapper.findAll();
    }

    public Long count() {
        Map<String, Object> params = Maps.newHashMap();
        if (ShiroUtil.isEmployee()){
            params.put("userid",ShiroUtil.getCurrentUserID());
        }
        return salesMapper.countByparam(params);
    }
    public Long countByparam(Map<String, Object> params) {
        if (ShiroUtil.isEmployee()){
            params.put("userid",ShiroUtil.getCurrentUserID());
        }
        return salesMapper.countByparam(params);
    }

    public void saveSales(Sales sales) {
        Customer customer = customerMapper.findByCustomerId(sales.getCustid());
        sales.setCustname(customer.getName());
        sales.setLasttime(DateTime.now().toString("yyyy-MM-dd HH:mm"));
        sales.setUserid(ShiroUtil.getCurrentUserID());
        sales.setUsername(ShiroUtil.getCurrentRealName());
        salesMapper.save(sales);
    }

    public List<Sales> findSalesByParam(Map<String, Object> params) {
        if (ShiroUtil.isEmployee()){
            params.put("userid",ShiroUtil.getCurrentUserID());
        }
        return salesMapper.findSalesByParam(params);
    }

    public Sales findSalesById(Integer id) {

        return salesMapper.findSalesById(id);
    }
}
