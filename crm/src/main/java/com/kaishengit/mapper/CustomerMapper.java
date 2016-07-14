package com.kaishengit.mapper;

import com.kaishengit.pojo.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerMapper {

    List<Customer> findCustomerByParam(Map<String, Object> param);

    Long count();

    Long countByParam(Map<String, Object> param);

    List<Customer> findByType(String type);

    Customer findById(Integer companyid);

    void save(Customer customer);
}
