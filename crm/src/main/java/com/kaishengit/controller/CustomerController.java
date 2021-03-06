package com.kaishengit.controller;

import com.google.common.collect.Maps;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.exception.ForbiddenException;
import com.kaishengit.exception.NotFoundException;
import com.kaishengit.pojo.Customer;
import com.kaishengit.pojo.Sales;
import com.kaishengit.pojo.Task;
import com.kaishengit.pojo.User;
import com.kaishengit.service.CustomerService;
import com.kaishengit.service.SalesService;
import com.kaishengit.service.TaskService;
import com.kaishengit.service.UserService;
import com.kaishengit.util.ShiroUtil;
import com.kaishengit.util.Strings;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Inject
    private CustomerService customerService;

    @Inject
    private SalesService salesService;

    @Inject
    private UserService userService;
    @Inject
    private TaskService taskService;
    /**
     * 显示客户页面
     */
    @RequestMapping(method = RequestMethod.GET)
    public String showCustomer(Model model){
        model.addAttribute("companyList",customerService.findAllCompany());
        return "customer/list";
    }

    /**
     * 通过ajax向页面传值
     * @param request
     * @return
     */
    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTablesResult<Customer> loadCustomer(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String keyword = request.getParameter("search[value]");
        keyword = Strings.toUTF8(keyword);
        Map<String,Object>param = Maps.newHashMap();
        param.put("start",start);
        param.put("length",length);
        param.put("keyword",keyword);
        List<Customer> customerList = customerService.findCustomerByParam(param);
        Long count = customerService.count();
        Long filterCount = customerService.countByParam(param);
        return new DataTablesResult<>(draw,customerList,count,filterCount);
    }

    /**
     * 新增客户
     * @param customer
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String save(Customer customer){
        customerService.saveCustomer(customer);
        return "success";
    }

    /**
     * 根据id删除用户
     * @param id
     * @return
     */
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    @ResponseBody
    public String del(@PathVariable Integer id){
        customerService.delCustom(id);
        return "success";
    }

    /**
     * 把公司列表传到jsp页面
     * @return
     */
    @RequestMapping(value = "/company.json",method = RequestMethod.GET)
    @ResponseBody
    public List<Customer> showAllCompanyJason(){
        return customerService.findAllCompany();
    }

    /**
     * 把客户信息传到jsp页面
     * @param id
     * @return
     */
    @RequestMapping(value = "/edit/{id:\\d+}.json",method = RequestMethod.GET)
    @ResponseBody
    public Map<String,Object> editCustomer(@PathVariable Integer id){
        Customer customer = customerService.findCustomerById(id);
        Map<String,Object> result = Maps.newHashMap();
        if (customer==null){
            result.put("state","error");
            result.put("message","找不到对应的用户");
        }else {
            List<Customer> companyList = customerService.findAllCompany();
            result.put("state","success");
            result.put("customer",customer);
            result.put("companyList",companyList);
        }
        return result;
    }

    /**
     * 编辑客户
     * @param customer
     * @return
     */
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    @ResponseBody
    public String edit(Customer customer){
        customerService.editCustomer(customer);
        return "success";
    }

    /**
     * 显示客户信息页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String viewCustomer(@PathVariable Integer id,Model model){
        Customer customer = customerService.findCustomerById(id);
        if (customer==null){
            throw new NotFoundException();
        }
        if (customer.getUserid()!=null&&!customer.getUserid().equals(ShiroUtil.getCurrentUserID())&&!ShiroUtil.isManager()){
            throw new ForbiddenException();
        }
        model.addAttribute("customer",customer);
        if (customer.getType().equals(Customer.CUSTOMER_TYPE_COMPANY)){
            List<Customer> customerList = customerService.findCustomerByCompanyId(id);
            model.addAttribute("customerList",customerList);
        }
        List<User>userList  = userService.findAllUser();
        model.addAttribute("userList",userList);
        List<Sales> salesList = salesService.findSalesByCustId(ShiroUtil.getCurrentUserID(),id);
        model.addAttribute("salesList",salesList);
        List<Task> taskList = taskService.findTaskByCustid(ShiroUtil.getCurrentUserID(),id);
        model.addAttribute("taskList",taskList);
        return "customer/view";
    }

    /**
     * 公开客户
     */
    @RequestMapping(value = "/open/{id:\\d+}",method = RequestMethod.GET)
    public String openCustomer(@PathVariable Integer id){
        Customer customer = customerService.findCustomerById(id);
        if (customer==null){
            throw new NotFoundException();
        }
        if (customer.getUserid()!=null&&!customer.getUserid().equals(ShiroUtil.getCurrentUserID())&&!ShiroUtil.isManager()){
            throw new ForbiddenException();
        }
        customerService.openCustomer(customer);
        return "redirect:/customer/"+id;
    }

    /**
     * 转移客户
     */
    @RequestMapping(value = "/move",method = RequestMethod.POST)
    public String moveCust(Integer id,Integer userid){
        Customer customer = customerService.findCustomerById(id);
        if (customer==null){
            throw  new NotFoundException();
        }
        if (customer.getUserid()!=null&&!customer.getUserid().equals(ShiroUtil.getCurrentUserID())&&!ShiroUtil.isManager()){
            throw new ForbiddenException();
        }
        customerService.moveCust(customer,userid);
        return "redirect:/customer";
    }

    /**
     * 将用户信息生成二维码
     */
    @RequestMapping(value = "/qrcode/{id:\\d+}.png",method = RequestMethod.GET)
    public void makeQrcode(@PathVariable Integer id, HttpServletResponse response) throws WriterException, IOException {
        String mecard = customerService.makeMeCard(id);
        Map<EncodeHintType,String>hints = Maps.newHashMap();
        hints.put(EncodeHintType.CHARACTER_SET,"UTF-8");
        BitMatrix bitMatrix = new MultiFormatWriter().encode(mecard, BarcodeFormat.QR_CODE,200,200,hints);
        OutputStream outputStream = response.getOutputStream();
        MatrixToImageWriter.writeToStream(bitMatrix,"png",outputStream);
        outputStream.flush();
        outputStream.close();
    }

    @RequestMapping(value = "/task/new",method = RequestMethod.POST)
    @ResponseBody
    public String newTask(Task task,String hour,String min){
        taskService.saveTask(task,hour,min);
        return "redirect:/customer/"+task.getCustid();
    }


}
