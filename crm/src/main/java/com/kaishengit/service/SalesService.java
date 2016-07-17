package com.kaishengit.service;

import com.google.common.collect.Maps;
import com.kaishengit.mapper.CustomerMapper;
import com.kaishengit.mapper.SalesFileMapper;
import com.kaishengit.mapper.SalesLogMapper;
import com.kaishengit.mapper.SalesMapper;
import com.kaishengit.pojo.Customer;
import com.kaishengit.pojo.Sales;
import com.kaishengit.pojo.SalesFile;
import com.kaishengit.pojo.SalesLog;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.io.IOUtils;
import org.joda.time.DateTime;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.transaction.annotation.Transactional;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Named
public class SalesService {
    @Inject
    private SalesMapper salesMapper;
    @Inject
    private CustomerMapper customerMapper;
    @Inject
    private SalesLogMapper salesLogMapper;
    @Inject
    private SalesFileMapper salesFileMapper;

    @Value("${imagePath}")
    private String savePath;

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

    @Transactional
    public void saveSales(Sales sales) {
        Customer customer = customerMapper.findByCustomerId(sales.getCustid());
        sales.setCustname(customer.getName());
        sales.setLasttime(DateTime.now().toString("yyyy-MM-dd HH:mm"));
        sales.setUserid(ShiroUtil.getCurrentUserID());
        sales.setUsername(ShiroUtil.getCurrentRealName());
        salesMapper.save(sales);
        SalesLog salesLog = new SalesLog();
        salesLog.setType(SalesLog.LOG_TYPE_AUTO);
        salesLog.setContext(ShiroUtil.getCurrentRealName()+ " 创建了该销售机会");
        salesLog.setSalesid(sales.getId());
        salesLogMapper.save(salesLog);
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

    public List<Sales> findSalesByCustId(Integer custid) {
        return salesMapper.findSalesByCustId(custid);
    }

    public List<SalesLog> findSalesBySalesId(Integer salesid) {
        return salesLogMapper.findBySalesId(salesid);
    }

    public void saveLog(SalesLog salesLog) {
        salesLog.setType(SalesLog.LOG_TYPE_INPUT);
        salesLogMapper.save(salesLog);
        Sales sales = salesMapper.findSalesById(salesLog.getSalesid());
        sales.setLasttime(DateTime.now().toString("yyyy-MM-dd"));
        salesMapper.update(sales);
    }

    @Transactional
    public void editSaleProgress(Integer id, String progress) {
       Sales sales = salesMapper.findSalesById(id);
        sales.setProgress(progress);
        sales.setLasttime(DateTime.now().toString("yyyy-MM-dd"));
        if ("完成交易".equals(progress)){
            sales.setSuccesstime(DateTime.now().toString("yyyy-MM-dd"));
        }
        salesMapper.update(sales);
        SalesLog salesLog = new SalesLog();
        salesLog.setType(SalesLog.LOG_TYPE_AUTO);
        salesLog.setContext(ShiroUtil.getCurrentRealName()+"更改进度为："+progress);
        salesLog.setSalesid(sales.getId());
        salesLogMapper.save(salesLog);
    }

    public List<SalesFile> findSalesFileBySalesId(Integer salesid) {
        return salesFileMapper.findSalesFileBySalesId(salesid);
    }

    @Transactional
    public void uploadFile(InputStream inputStream, String originalFilename, String contentType, long size, Integer salesid) {
        String newName = UUID.randomUUID().toString();
        if (originalFilename.lastIndexOf(".")!=-1){
            newName += originalFilename.substring(originalFilename.lastIndexOf("."));
        }
        try {
            FileOutputStream outputStream = new FileOutputStream(new File(savePath,newName));
            IOUtils.copy(inputStream,outputStream);
            outputStream.flush();
            outputStream.close();
            inputStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        SalesFile salesFile = new SalesFile();
        salesFile.setSalesid(salesid);
        salesFile.setContenttype(contentType);
        salesFile.setFilename(newName);
        salesFile.setName(originalFilename);
        salesFile.setSize(size);
        salesFileMapper.save(salesFile);
    }

    public SalesFile findSalesFileById(Integer id) {
        return salesFileMapper.findSalesFileById(id);
    }
}
