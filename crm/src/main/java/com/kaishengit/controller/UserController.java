package com.kaishengit.controller;

import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.exception.NotFoundException;
import com.kaishengit.pojo.User;
import com.kaishengit.pojo.UserLog;
import com.kaishengit.service.UserService;
import com.kaishengit.util.ShiroUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    private Logger logger = LoggerFactory.getLogger(UserController.class);
    @Inject
    private UserService userService;

    /**
     * 修改密码
     */

    @RequestMapping(value = "/password",method = RequestMethod.GET)
    public String editPassword(){
        return "setting/password";
    }

    @RequestMapping(value = "/password",method = RequestMethod.POST)
    @ResponseBody
    public String editPassword(String password){
        userService.changePassword(password);
        return "success";
    }

    /**
     * 验证原始密码是否正确
     */
    @RequestMapping(value = "/validate/password",method = RequestMethod.GET)
    @ResponseBody
    public String validateOldPassword(@RequestHeader("X-Requested-With") String xRequestedWith,String oldpassword){
        if("XMLHttpRequest".equals(xRequestedWith)) {
            User user = ShiroUtil.getCurrentUser();
            if(user.getPassword().equals(DigestUtils.md5Hex(oldpassword))) {
                return "true";
            }
            return "false";
        }else {
            throw new NotFoundException();
        }
    }

    /**
     * 显示登录日志页面
     * @return
     */
    @RequestMapping(value = "/log",method = RequestMethod.GET)
    public String showUserLog(){
        return "setting/loglist";
    }

    @RequestMapping(value = "/log/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTablesResult userLogLoad(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        List<UserLog> userLogList = userService.findCurrentUserLog(start,length);
        Long count = userService.findCurrentUserLogCount();
        return new DataTablesResult<>(draw,userLogList,count,count);
    }
}
