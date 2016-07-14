package com.kaishengit.service;

import com.google.common.collect.Maps;
import com.kaishengit.mapper.CustomerMapper;
import com.kaishengit.pojo.Customer;
import com.kaishengit.util.ShiroUtil;
import com.kaishengit.util.Strings;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class CustomerService {
    @Inject
    private CustomerMapper customerMapper;

    public List<Customer> findCustomerByParam(Map<String, Object> param) {
        if (ShiroUtil.isEmployee()){
            param.put("userid",ShiroUtil.getCurrentUserID());
        }
        return customerMapper.findCustomerByParam(param);
    }

    public Long count() {
        if (ShiroUtil.isEmployee()){
            Map<String,Object>param = Maps.newHashMap();
            param.put("userid",ShiroUtil.getCurrentUserID());
            return customerMapper.countByParam(param);
        }
        return customerMapper.count();
    }

    public Long countByParam(Map<String, Object> param) {
        if (ShiroUtil.isEmployee()){
            param.put("userid",ShiroUtil.getCurrentUserID());
        }
        return customerMapper.countByParam(param);
    }

    public List<Customer> findAllCompany() {
        return customerMapper.findByType(Customer.CUSTOMER_TYPE_COMPANY);
    }

    public void saveCustomer(Customer customer) {
        if (customer.getCompanyid()!=null){
            Customer company = customerMapper.findById(customer.getCompanyid());
            customer.setCompanyname(company.getName());
        }
        customer.setUserid(ShiroUtil.getCurrentUserID());
        customer.setPinyin(Strings.toPinyin(customer.getName()));
        customerMapper.save(customer);
    }
}
