package com.kaishengit.controller;

import com.google.common.collect.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.dto.JSONResult;
import com.kaishengit.pojo.Role;
import com.kaishengit.pojo.User;
import com.kaishengit.service.UserService;
import com.kaishengit.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class AdminController {
    @Inject
    private UserService userService;

    /**
     * 显示用户列表页面
     * @return
     */
    @RequestMapping(value = "/user",method = RequestMethod.GET)
    public String userList(Model model){
        List<Role> roleList = userService.findAllRole();
        model.addAttribute("rolelist",roleList);
        return "admin/userlist";
    }

    /**
     * 获取页面数据（ajax）
     * @param request
     * @return
     */
    @RequestMapping(value = "/user/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTablesResult userLoad(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");
        keyword = Strings.toUTF8(keyword);
        Map<String,Object>param = Maps.newHashMap();
        param.put("draw",draw);
        param.put("start",start);
        param.put("length",length);
        param.put("keyword",keyword);
        List<User> userList = userService.findByParam(param);
        Long count = userService.countUser();
        Long filterCount = userService.countByParam();
        return new DataTablesResult(draw,userList,count,filterCount);
    }

    /**
     * 添加新用户
     * @param user
     * @return
     */
    @RequestMapping(value = "/users/new",method = RequestMethod.POST)
    @ResponseBody
    public String saveUser(User user){
        userService.saveUser(user);
        return "success";
    }

    /**
     * 验证用户名是否存在
     * @param username
     * @return
     */
    @RequestMapping(value ="/user/checkusername",method = RequestMethod.GET)
    @ResponseBody
    public String checkUserName(String username){
        User user = userService.findUserByUserName(username);
        if (user==null){
            return "true";
        }else {
            return "false";
        }
    }

    /**
     * 重置用户密码
     * @param id
     * @return
     */
    @RequestMapping(value = "users/resetpassword",method = RequestMethod.POST)
    @ResponseBody
    public String resetPassword(Integer id){
        userService.resetUserPassword(id);
        return "success";
    }

    /**
     *编辑用户
     * @param user
     * @return
     */
    @RequestMapping(value = "/users/edit",method = RequestMethod.POST)
    @ResponseBody
    public String editUser(User user){
        userService.editUser(user);
        return "success";
    }

    @RequestMapping(value ="/users/{id:\\d+}.json",method = RequestMethod.GET)
    @ResponseBody
    public JSONResult showUser(@PathVariable Integer id){
        User user = userService.findUserById(id);
        if (user==null){
            return new JSONResult("找不到"+id+"对应的用户");
        }else {
            return new JSONResult(user);
        }
    }
}
