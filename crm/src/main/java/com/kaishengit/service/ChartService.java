package com.kaishengit.service;

import com.kaishengit.mapper.CustomerMapper;
import com.kaishengit.mapper.SalesMapper;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class ChartService {

    @Inject
    private CustomerMapper customerMapper;
    @Inject
    private SalesMapper salesMapper;

    public long findNewCustomerCount(String start, String end) {
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return customerMapper.findNewCustomerCount(start,end);
    }

    public long findSaleCount(String start, String end) {
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return salesMapper.findSaleCount(start,end,"交易完成");
    }

    public float findSaleMoney(String start, String end) {
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return  salesMapper.findSaleMoney(start,end,"交易完成");
    }

    public List<Map<String,Object>> loadPieData(String start, String end) {
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return salesMapper.countProgress(start,end);
    }

    public List<Map<String,Object>> loadBarData(String start, String end) {
        DateTime now = DateTime.now();
        if (StringUtils.isEmpty(start)){
            start = now.dayOfMonth().withMinimumValue().toString("yyyy-MM-dd");
        }
        if (StringUtils.isEmpty(end)){
            end = now.toString("yyyy-MM-dd");
        }
        return salesMapper.totalUserMoney(start,end);
    }
}
