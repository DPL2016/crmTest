package com.kaishengit.mapper;

import com.kaishengit.pojo.Sales;

import java.util.List;
import java.util.Map;

public interface SalesMapper {
    List<Sales> findAll();

    Long count();
    Long countByparam(Map<String, Object> params);

    void save(Sales sales);

    List<Sales> findSalesByParam(Map<String, Object> params);
}
