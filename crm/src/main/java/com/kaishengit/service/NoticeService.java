package com.kaishengit.service;

import com.kaishengit.mapper.NoticeMapper;
import com.kaishengit.pojo.Notice;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Value;

import javax.inject.Inject;
import javax.inject.Named;
import java.io.*;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@Named
public class NoticeService {

    @Inject
    private NoticeMapper noticeMapper;
    @Value("${imagePath}")
    private String imageSavePath;

    public void saveNotice(Notice notice) {
        notice.setUserid(ShiroUtil.getCurrentUserID());
        notice.setRealname(ShiroUtil.getCurrentRealName());
        noticeMapper.save(notice);
    }

    public List<Notice> findByParam(Map<String, Object> param) {
        return noticeMapper.findByParam(param);
    }
    public Long countNotice(){
        return noticeMapper.count();
    }
    public Long countByParam(){
        return noticeMapper.countByParam();
    }

    public Notice findById(Integer id) {
        return noticeMapper.findById(id);
    }


    public String saveImage(InputStream inputStream, String fileName) throws IOException {
        String exName = fileName.substring(fileName.lastIndexOf("."));
        String newFileName = UUID.randomUUID().toString();
        FileOutputStream outputStream = new FileOutputStream(new File(imageSavePath,newFileName));
        IOUtils.copy(inputStream,outputStream);
        outputStream.flush();
        outputStream.close();
        outputStream.close();
        return "/preview/"+newFileName;
    }
}
