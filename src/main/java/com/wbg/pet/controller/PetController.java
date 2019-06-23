package com.wbg.pet.controller;

import com.wbg.pet.dao.CategoryMapper;
import com.wbg.pet.dao.PetMapper;
import com.wbg.pet.dao.TagMapper;
import com.wbg.pet.entity.Pet;
import com.wbg.pet.entity.R;
import com.wbg.pet.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/pet")
public class PetController {
    @Autowired
    private PetMapper petMapper;
    @Autowired
    private TagMapper tagMapper;
    @Autowired
    private CategoryMapper categoryMapper;
    /**
     * 调转页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(Model model) {
        model.addAttribute("pet",petMapper.selectAll());//所有宠物信息

        model.addAttribute("category",categoryMapper.selectAll());//所有类别
        model.addAttribute("tag",tagMapper.selectAll());//所有标签
        return "pet";
    }
    /**
     * 调转页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/petadd",method = RequestMethod.GET)
    public String useradd(Model model) {
        model.addAttribute("tag",tagMapper.selectAll());
        model.addAttribute("category",categoryMapper.selectAll());
        return "petadd";
    }//添加操作\
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    public String petPost(Pet pet, @RequestPart("tp") MultipartFile multipartFile, Model model, HttpServletRequest request) {
        if(!multipartFile.isEmpty()){
            //取得相对路径
            String basePath = request.getServletContext().getRealPath("/images/pet_images");

            File files = new File(basePath);
            if(!files.exists()){
                files.mkdir();
            }
            try {
                String rekativePath = makeImagePath(multipartFile.getOriginalFilename());
                File file = new File(basePath+rekativePath);
                multipartFile.transferTo(file);
                pet.setPhotourls("images/pet_images"+rekativePath);
            } catch (IOException e) {
                model.addAttribute("err", "上传失败，请重试！");
                return "petadd";
            }
        }
        //对添加的宠物进行用户关联
        User user = (User)request.getSession().getAttribute("user");
        if(user != null)
            pet.setUserId(user.getId());
        else{
            model.addAttribute("msg", "当前用户处于离线状态，请重新登录后发布！");
            return "petadd";
        }
        if(pet.getTags() == 1)
            pet.setStatus("未认领");
        else if(pet.getTags() == 2)
            pet.setStatus("未领养");
        else if(pet.getTags() == 3)
            pet.setStatus("未寄养");

        if (petMapper.insert(pet) > 0) {
           model.addAttribute("msg", "添加成功,请在宠物查询中查看！");
        } else
            model.addAttribute("msg", "添加失败，请联系管理员！");
         return "petadd";
    }

    //修改操作
    @RequestMapping(method = RequestMethod.PUT)
    public String petPut(Pet pet, Model model, RedirectAttributes redirectAttributes) {
        if (petMapper.updateByPrimaryKey(pet) > 0) {
            redirectAttributes.addAttribute("msg", "添加成功");
            return "redirect:petadd";
        } else {
            redirectAttributes.addAttribute("msg", "添加失败");
            model.addAttribute("photourls", pet.getPhotourls());
            model.addAttribute("name", pet.getName());
            model.addAttribute("sateus", pet.getStatus());
            model.addAttribute("tags", pet.getTags());
            model.addAttribute("categoryId", pet.getCategoryId());
        }
        return "petadd";
    }

    //根据状态查询操作
    @RequestMapping(value = "/findByStatus/{status}", method = RequestMethod.GET)
    public String findByStatus(Model model, @PathVariable("status") String status) {
        List<Pet> list = petMapper.findByStatus(status);
        model.addAttribute("petAll", list);
        return "petindex";
    }



    //根据主键查询操作
    @RequestMapping(value = "/query/{petId}", method = RequestMethod.GET)
    @ResponseBody
    public Pet getpetId(Model model, @PathVariable("petId") int petId) {
        Pet p = petMapper.selectByPrimaryKey(petId);
        return p;
    }

    /**
     * 根据主键修改操作
     * petId Updated is pet
     */
    @RequestMapping(value = "/save/{petId}", method = RequestMethod.POST)
    @ResponseBody
    public String petId(Model model, @PathVariable("petId") int petId, HttpServletRequest request) {
        Pet pet = petMapper.selectByPrimaryKey(petId);
        R r = new R();
        pet.setCategoryId(Integer.parseInt(request.getParameter("categoryid")));
        pet.setName(request.getParameter("petname"));
        pet.setSex(Integer.parseInt(request.getParameter("sex")));
        pet.setAge(Integer.parseInt(request.getParameter("petage")));
        String petpicurl = request.getParameter("fileurl");

        pet.setPhotourls(petpicurl);
        pet.setTags(Integer.parseInt(request.getParameter("tagid")));
        if (petMapper.updateByPrimaryKey(pet) > 0) {
           r.setCode(200);
        } else {
            r.setCode(404);
        }
        return r.toJson();
    }
    /**
     * 根据主键修改操作
     * petId Updated is pet
     */
    @RequestMapping(value = "/updatuser/{petId}", method = RequestMethod.POST)
    @ResponseBody
    public String petId(@PathVariable("petId") int petId, HttpServletRequest request) {
        Pet pet = petMapper.selectByPrimaryKey(petId);
        R r = new R();
        pet.setStatus("待认领");
        pet.setAdoptId(Integer.parseInt(request.getParameter("adoptid")));
        if (petMapper.updateStatusById(pet) > 0) {
            r.setCode(200);
        } else {
            r.setCode(404);
        }
        return r.toJson();
    }
    /**
     * 根据主键修改操作
     * petId Updated is pet
     */
    @RequestMapping(value = "/adoptupdatuser/{petId}", method = RequestMethod.POST)
    @ResponseBody
    public String updateadoptId(@PathVariable("petId") int petId, HttpServletRequest request) {
        Pet pet = petMapper.selectByPrimaryKey(petId);
        R r = new R();
        pet.setStatus("待领养");
        pet.setAdoptId(Integer.parseInt(request.getParameter("adoptid")));
        if (petMapper.updateStatusById(pet) > 0) {
            r.setCode(200);
        } else {
            r.setCode(404);
        }
        return r.toJson();
    }
    /**
     * 根据主键修改操作
     * petId Updated is pet
     */
    @RequestMapping(value = "/fosterupdatuser/{petId}", method = RequestMethod.POST)
    @ResponseBody
    public String updatefosterId(@PathVariable("petId") int petId, HttpServletRequest request) {
        Pet pet = petMapper.selectByPrimaryKey(petId);
        R r = new R();
        pet.setStatus("待寄养");
        pet.setAdoptId(Integer.parseInt(request.getParameter("fosterid")));
        if (petMapper.updateStatusById(pet) > 0) {
            r.setCode(200);
        } else {
            r.setCode(404);
        }
        return r.toJson();
    }
    /**
     * 修改宠物状态
     * petId Updated is pet
     */
    @RequestMapping(value = "/updatestatus/{petId}", method = RequestMethod.POST)
    @ResponseBody
    public String updateStatus(@PathVariable("petId") int petId, HttpServletRequest request) {
        Pet pet = petMapper.selectByPrimaryKey(petId);
        R r = new R();
        int isok = Integer.parseInt(request.getParameter("okorno"));
        String status = request.getParameter("status");
        if(isok == 1){
            if(status.equals("待认领"))
                pet.setStatus("已认领");
            else if(status.equals("待领养"))
                pet.setStatus("已领养");
            else if(status.equals("待寄养"))
                pet.setStatus("已寄养");
        }
        else
        {
            if(status.equals("待认领"))
                pet.setStatus("未认领");
            else if(status.equals("待领养"))
                pet.setStatus("未领养");
            else if(status.equals("待寄养"))
                pet.setStatus("未寄养");
        }

        if (petMapper.updateStatusById(pet) > 0) {
            r.setCode(200);
        } else {
            r.setCode(404);
        }
        return r.toJson();
    }
    /**
     * 宠物删除，使用restful风格
     * petId
     */
    @RequestMapping(value = "/del/{petId}", method = RequestMethod.GET)
    @ResponseBody
    public String del( @PathVariable("petId") int petId) {
        R r=new R();
        if (petMapper.deleteByPrimaryKey(petId) > 0) {
            r.setCode(200);
        }
        return r.toJson();
    }

    public String makeImagePath(String fileName) {
        Date date = new Date();
        String[] filename = simpleFile(fileName);
        return String.format("%supload_%s_%s.%s",
                File.separator,
                filename[0],
                new SimpleDateFormat("hhmmss").format(date),
                filename[1]
        );

    }

    public String[] simpleFile(String file) {
        int sum = file.lastIndexOf(".");
        return new String[]{
                file.substring(0, sum),
                file.substring(sum + 1)
        };
    }
}
