package com.kaishengit.mapper;

import com.kaishengit.pojo.SalesFile;

import java.util.List;

public interface SalesFileMapper {
    List<SalesFile> findSalesFileBySalesId(Integer salesid);

    void save(SalesFile salesFile);

    SalesFile findSalesFileById(Integer id);
}
