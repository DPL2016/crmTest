package com.kaishengit.service;

import com.kaishengit.mapper.NoticeMapper;
import com.kaishengit.pojo.Notice;
import com.kaishengit.util.ShiroUtil;

import javax.inject.Inject;
import javax.inject.Named;
import java.util.List;
import java.util.Map;

@Named
public class NoticeService {

    @Inject
    private NoticeMapper noticeMapper;

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
}
