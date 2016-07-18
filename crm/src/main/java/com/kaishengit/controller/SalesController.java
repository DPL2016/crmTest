package com.kaishengit.controller;

import com.google.common.collect.Maps;
import com.kaishengit.dto.DataTablesResult;
import com.kaishengit.exception.ForbiddenException;
import com.kaishengit.exception.NotFoundException;
import com.kaishengit.mapper.SalesMapper;
import com.kaishengit.pojo.*;
import com.kaishengit.service.CustomerService;
import com.kaishengit.service.SalesService;
import com.kaishengit.service.TaskService;
import com.kaishengit.util.ShiroUtil;
import com.kaishengit.util.Strings;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sales")
public class SalesController {
    @Inject
    private CustomerService customerService;
    @Inject
    private SalesService salesService;

    @Inject
    private TaskService taskService;
    @Value("${imagePath}")
    private String savePath;
    /**
     * 显示机会页面
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model){
        model.addAttribute("customerList",customerService.findAllCustomer());
        return "sales/list";
    }

    /**
     * 加载机会列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/load",method = RequestMethod.GET)
    @ResponseBody
    public DataTablesResult<Sales> load(HttpServletRequest request){
        String draw = request.getParameter("draw");
        String start = request.getParameter("start");
        String length = request.getParameter("length");
        String name = request.getParameter("name");
        name = Strings.toUTF8(name);
        String progress = request.getParameter("progress");
        progress = Strings.toUTF8(progress);
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        Map<String,Object> params = Maps.newHashMap();
        params.put("start",start);
        params.put("length",length);
        params.put("name",name);
        params.put("progress",progress);
        params.put("startDate",startDate);
        params.put("endDate",endDate);
        List<Sales> salesList = salesService.findSalesByParam(params);
        Long count = salesService.count();
        Long filterCount = salesService.countByparam(params);
        return new DataTablesResult<>(draw,salesList,count,filterCount);
    }

    /**
     * 新增机会
     * @param sales
     * @return
     */
    @RequestMapping(value = "/new",method = RequestMethod.POST)
    @ResponseBody
    public String saveSales(Sales sales){
        salesService.saveSales(sales);
        return "success";
    }

    /**
     * 机会详细信息页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/{id:\\d+}",method = RequestMethod.GET)
    public String showSales(@PathVariable Integer id,Model model){
        Sales sales = salesService.findSalesById(id);
        if (sales==null){
            throw new NotFoundException();
        }
        if (!sales.getUsername().equals(ShiroUtil.getCurrentRealName())&&ShiroUtil.isManager()){
            throw new ForbiddenException();
        }
        model.addAttribute("sales",sales);
        List<SalesLog>salesLogList = salesService.findSalesBySalesId(id);
        model.addAttribute(salesLogList);
        List<SalesFile>salesFileList = salesService.findSalesFileBySalesId(id);
        model.addAttribute(salesFileList);
        List<Task> taskList = taskService.findTaskBySalesId(id);
        model.addAttribute("taskList",taskList);
        return "sales/view";
    }

    /**
     * 进度的添加
     * @param salesLog
     * @return
     */
    @RequestMapping(value = "/log/new",method = RequestMethod.POST)
    public String saveLog(SalesLog salesLog){
        salesService.saveLog(salesLog);
        return "redirect:/sales/"+salesLog.getSalesid();
    }

    /**
     * 修改机会进度
     * @param id
     * @param progress
     * @return
     */
    @RequestMapping(value = "/progress/edit",method = RequestMethod.POST)
    public String editProgress(Integer id,String progress){
        salesService.editSaleProgress(id,progress);
        return "redirect:/sales/"+id;
    }

    /**
     * 文件上传
     * @param file
     * @param salesid
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/file/upload",method = RequestMethod.POST)
    @ResponseBody
    public String uoload(MultipartFile file,Integer salesid) throws IOException {
        salesService.uploadFile(file.getInputStream(),file.getOriginalFilename(),file.getContentType(),file.getSize(),salesid);
        return "success";
    }

    /**
     * 文件下载
     * @param id
     * @return
     * @throws FileNotFoundException
     * @throws UnsupportedEncodingException
     */
    @RequestMapping(value = "/file/{id:\\d+}/download",method = RequestMethod.GET)
    public ResponseEntity<InputStreamResource> update(@PathVariable Integer id) throws FileNotFoundException, UnsupportedEncodingException {
        SalesFile salesFile = salesService.findSalesFileById(id);
        if (salesFile==null){
            throw new NotFoundException();
        }
        File file  = new File(savePath,salesFile.getFilename());
        if (!file.exists()){
            throw new NotFoundException();
        }
        FileInputStream inputStream  = new FileInputStream(file);
        String fileName = salesFile.getName();
        fileName = new String(fileName.getBytes("UTF-8"),"ISO8859-1");
        return ResponseEntity.ok().contentLength(salesFile.getSize())
                .contentType(MediaType.parseMediaType(salesFile.getContenttype()))
                .header("Content-Disposition","attachment;filename=\""+fileName+"\"")
                .body(new InputStreamResource(inputStream));
    }
    @RequestMapping(value = "/del/{id:\\d+}",method = RequestMethod.GET)
    public String delSales(@PathVariable Integer id){
        salesService.delSales(id);
        return "redirect:/sales";
    }
}
