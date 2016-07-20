package com.kaishengit.mapper;

import com.kaishengit.pojo.Customer;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface CustomerMapper {

    List<Customer> findCustomerByParam(Map<String, Object> param);

    Long count();

    Long countByParam(Map<String, Object> param);

    List<Customer> findByType(@Param("userid") Integer userid,@Param("type") String type);

    Customer findById(Integer companyid);

    void save(Customer customer);

    List<Customer> findByCompanyId(Integer id);

    void update(Customer cust);

    void del(Integer id);

    List<Customer> findAll();

    Customer findByCustomerId(Integer id);

    long findNewCustomerCount(@Param("start") String start,@Param("end") String end);


}
