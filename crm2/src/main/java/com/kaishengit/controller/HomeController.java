package com.kaishengit.controller;

import com.kaishengit.dto.FlashMessage;
import com.kaishengit.service.UserService;
import com.kaishengit.util.ServletUtil;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

@Controller
public class HomeController {
    @Inject
    private UserService userService;
    @RequestMapping(value = "/",method = RequestMethod.GET)
    public String index(){
        return "login";
    }

    @RequestMapping(value = "/",method = RequestMethod.POST)
    public String login(String username, String password, RedirectAttributes redirectAttributes, HttpServletRequest request){
        Subject subject = SecurityUtils.getSubject();
        if (subject.isAuthenticated()){
            subject.logout();
        }
        try {
            UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(username, DigestUtils.md5Hex(password));
            subject.login(usernamePasswordToken);
            userService.saveUserLogin(ServletUtil.getRemoteIp(request));
            return "redirect:/home";
        }catch (LockedAccountException e){
            redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_ERROR,"账号已被禁用"));
        }catch (AuthenticationException ex){
            redirectAttributes.addFlashAttribute("message",new FlashMessage(FlashMessage.STATE_ERROR,"用户名或密码错误"));
        }
        return "redirect:/";
    }

    @RequestMapping(value = "/home",method = RequestMethod.GET)
    public String home(){
        return "home";
    }

    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String logout(RedirectAttributes redirectAttributes){
        SecurityUtils.getSubject().logout();
        redirectAttributes.addFlashAttribute("message",new FlashMessage("你已安全退出"));
        return "redirect:/";

    }

}
