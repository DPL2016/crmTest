package com.kaishengit.controller;

import com.kaishengit.exception.NotFoundException;
import com.kaishengit.pojo.Document;
import com.kaishengit.service.DocumentService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/doc")
public class DocumentController {
    @Inject
    private DocumentService documentService;
    @Value("${imagePath}")
    private String savePath;

    /**
     * 去文件列表页面
     * @param model
     * @param fid
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String list(Model model, @RequestParam(required = false,defaultValue ="0") Integer fid){
        List<Document> documentList = documentService.findDocumentByFid(fid);
        model.addAttribute("documentList",documentList);
        model.addAttribute("fid",fid);
        return "document/list";
    }

    /**
     * 新建文件夹
     * @param name
     * @param fid
     * @return
     */
    @RequestMapping(value = "/dir/new",method = RequestMethod.POST)
    public String saveDir(String name,Integer fid){
        documentService.saveDir(name,fid);
        return "redirect:/doc?fid="+fid;
    }

    @RequestMapping(value = "/file/upload",method = RequestMethod.POST)
    @ResponseBody
    public String saveFile(MultipartFile file,Integer fid) throws IOException {
        if (file.isEmpty()){
            throw new NotFoundException();
        }else {
            documentService.saveFile(file.getInputStream(),file.getOriginalFilename(),file.getContentType(),file.getSize(),fid);
        }
        return "success";
    }

}
