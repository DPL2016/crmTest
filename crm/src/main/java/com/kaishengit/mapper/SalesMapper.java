package com.kaishengit.mapper;

import com.kaishengit.pojo.Sales;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SalesMapper {
    List<Sales> findAll();


    Long countByparam(Map<String, Object> params);

    void save(Sales sales);

    List<Sales> findSalesByParam(Map<String, Object> params);

    Sales findSalesById(Integer id);

    List<Sales> findSalesByCustId(@Param("userId") Integer userid,@Param("custId") Integer custid);

    void update(Sales sales);

    void del(Integer id);

    long findSaleCount(@Param("start") String start, @Param("end") String end,@Param("state") String state);

    float findSaleMoney(@Param("start") String start, @Param("end") String end,@Param("state") String state);

    List<Map<String,Object>> countProgress(@Param("start") String start, @Param("end") String end);

    List<Map<String,Object>> totalUserMoney(@Param("start") String start, @Param("end") String end);
}
