package com.kaishengit.controller;

import com.google.common.collect.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.pojo.Notice;
import com.kaishengit.service.NoticeService;
import com.kaishengit.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/notice")
public class NoticeController {
    @Inject
    private NoticeService noticeService;

    /**
     * 去通知列表页
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(){
        return "notice/list";
    }

    /**
     * 去新增页
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.GET)
    public String newNotice(){
        return "notice/new";
    }

    /**
     * 发公告
     * @param notice
     * @param redirectAttributes
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    public String newNotice(Notice notice, RedirectAttributes redirectAttributes){
        noticeService.saveNotice(notice);
        redirectAttributes.addFlashAttribute("message","发表成功");
        return "redirect:/notice";
    }

    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTablesResult<Notice> loadNotice(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");
        keyword = Strings.toUTF8(keyword);
        Map<String,Object>param = Maps.newHashMap();
        param.put("draw",draw);
        param.put("length",length);
        param.put("start",start);
        param.put("keyword",keyword);
        List<Notice> noticeList = noticeService.findByParam(param);
        Long count = noticeService.countNotice();
        Long fitherCount = noticeService.countByParam();
        return new DataTablesResult<>(draw,noticeList,count,fitherCount);
    }
}
