package com.wbg.pet.controller;


import com.wbg.pet.dao.UserMapper;
import com.wbg.pet.entity.R;
import com.wbg.pet.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserMapper userMapper;
    /*
    添加操作
     */
    @ResponseBody
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public String create(Model model,HttpServletRequest request) {
       User user = new User();
       user.setPassword("123456");
       user.setUserstatus("正常");
       user.setAddress("-");
       user.setPhone("-");
       user.setAge(20);//设置默认值
       user.setAuthority(1);//注册默认普通员
       user.setUsername((String)request.getParameter("username"));
       user.setEmail((String)request.getParameter("email"));
       R r = new R();
            if (userMapper.insert(user) > 0)
                r.setCode(200);
            else
                r.setCode(400);
        return r.toJson();
    }

    @RequestMapping(value = "/index",method = RequestMethod.GET)
    public String index(Model model){
        model.addAttribute("users",userMapper.selectAll());
        return "user";
    }
    @RequestMapping(value = "/notice",method = RequestMethod.GET)
    public String notice(){
        System.out.println("进入首页公告，进行必要的数据加载...");
        //model.addAttribute("user",userMapper.selectAll());
        return "notice";
    }
    /**
     * 添加操作
     */
    @RequestMapping(value = "/adduser",method = RequestMethod.POST)
    public String createWithArray(User formBean, Model model) {

        userMapper.insert(formBean);
        model.addAttribute("msg","成功添加,请在查询用户中查看！");

        return "useradd";
    }
    /**
     * 验证登录
     * username password
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public String login(@RequestParam("username") String username , @RequestParam("password") String password, HttpServletRequest request,HttpServletResponse response){
       R r=new R();
        try {
            User current_user = userMapper.Login(username,password);
            if(current_user != null){
                //查看用户状态，如果冻结了则不能登陆
                if(!current_user.getUserstatus().equals("正常"))
                {
                    r.setMsg("您的账号已冻结，请联系管理员！");
                    r.setCode(401);
                    return r.toJson();
                }
                //session存放当前用户
                request.getSession().setAttribute("user",current_user);
//                //记住密码
//                Cookie remusername = new Cookie("customername ",username);
//                Cookie rempassword = new Cookie("customerpass ",password);
//                response.addCookie(remusername );
//                response.addCookie(rempassword );

                r.setMsg("登录成功");
                r.setCode(200);
            }else{
                r.setMsg("账号密码不一致");
            }
        }catch (Exception e){
            r.setMsg("账号密码异常！");
            return r.toJson();
        }
        return r.toJson();
    }

    /**
     * 退出登录
     * username password
     * @return
     */
    @RequestMapping(value = "/logout",method = RequestMethod.GET)
    public String outlogin(HttpServletRequest request){
        //request.getSession().setAttribute("user",null);
        //退出登录时，session失效
        request.getSession().invalidate();
        return "redirect:/index.html";
    }
    /**
     * 根据用户名查询操作
     * username
     * @return
     */
    @RequestMapping(method = RequestMethod.GET)
    public String getusername(String username , Model model){
        List<User> user=userMapper.selectByUserName(username);
        model.addAttribute("user",user);
        return "user";
    }
    /**
     * 根据用户名查询修改
     * username
     * @return
     */
    @RequestMapping(value = "/{username}",method = RequestMethod.PUT)
    public String putusername(@PathVariable("username") String username ,Model model){
        try {
            if(userMapper.updateByUserName(username)>0){
                model.addAttribute("msg","修改成功");
            }
            else {
                model.addAttribute("msg","修改失败");
            }
        }catch (Exception e){
            model.addAttribute("msg","修改失败,请重试");
            return "no";
        }

        return "no";
    }
    //根据主键查询操作
    @RequestMapping(value = "/query/{userId}", method = RequestMethod.GET)
    @ResponseBody
    public User getuserId( @PathVariable("userId") int userId) {
        return userMapper.selectByPrimaryKey(userId);
    }
    @ResponseBody
    @RequestMapping(value = "/updatepwd/{userId}",method = RequestMethod.POST)
    public String updateUser(@PathVariable("userId") int userId,HttpServletRequest request){
        User user = userMapper.selectByPrimaryKey(userId);
        user.setPassword(request.getParameter("pwdnew"));
        R r = new R();
        if(userMapper.updateByPrimaryKey(user)>0)
            r.setCode(200);
        else
            r.setCode(500);
        return r.toJson();
    }
    @ResponseBody
    @RequestMapping(value = "/save/{userId}",method = RequestMethod.POST)
    public String updatePwd(@PathVariable("userId") int userId,HttpServletRequest request){
        User user = userMapper.selectByPrimaryKey(userId);
        user.setUsername((String)request.getParameter("username"));
        user.setAge(Integer.parseInt(request.getParameter("age")));
        user.setEmail(request.getParameter("email"));
        user.setAddress(request.getParameter("address"));
        user.setPhone(request.getParameter("phone"));
        user.setUserstatus(request.getParameter("statusValue"));
        user.setAuthority(Integer.parseInt(request.getParameter("authorityValue")));
        R r = new R();
        if(userMapper.updateByPrimaryKey(user)>0)
            r.setCode(200);
        else
            r.setCode(500);
        return r.toJson();
    }
    /**
     * 根据id删除操作
     * userId
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/delete/{userId}",method = RequestMethod.GET)
    public String del(@PathVariable("userId") int userId){
        R r=new R();
        try {
            if(userMapper.deleteByUserId(userId)>0){
                r.setCode(200);
            }
        }catch (Exception e){
            return r.toJson();
        }
        return r.toJson();
    }
}
