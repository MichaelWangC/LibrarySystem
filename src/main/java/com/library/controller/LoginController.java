package com.library.controller;

import com.library.bean.Admin;
import com.library.bean.ReaderCard;
import com.library.bean.ReaderInfo;
import com.library.service.LoginService;
import com.library.service.ReaderCardService;
import com.library.service.ReaderInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;

@Controller
public class LoginController {

    private LoginService loginService;
    @Autowired
    public void setLoginService(LoginService loginService) {
        this.loginService = loginService;
    }

    @Autowired
    private ReaderInfoService readerInfoService;

    @Autowired
    private ReaderCardService readerCardService;

    @RequestMapping(value = {"/", "/login.html"})
    public String toLogin(HttpServletRequest request) {
        request.getSession().invalidate();
        return "index";
    }

    @RequestMapping("/logout.html")
    public String logout(HttpServletRequest request) {
        request.getSession().invalidate();
        return "redirect:/login.html";
    }


    //负责处理loginCheck.html请求
    //请求参数会根据参数名称默认契约自动绑定到相应方法的入参中
    @RequestMapping(value = "/api/loginCheck", method = RequestMethod.POST)
    public @ResponseBody
    Object loginCheck(HttpServletRequest request) {
        String id = request.getParameter("id");
        String passwd = request.getParameter("passwd");
        boolean isReader = loginService.hasMatchReader(id, passwd);
        boolean isAdmin = loginService.hasMatchAdmin(id, passwd);
        HashMap<String, String> res = new HashMap<>();
        if (isAdmin) {
            Admin admin = new Admin();
            admin.setAdminId(id);
            admin.setPassword(passwd);
            String username = loginService.getAdminUsername(id);
            admin.setUsername(username);
            request.getSession().setAttribute("admin", admin);
            res.put("stateCode", "1");
            res.put("msg", "管理员登陆成功！");
        } else if (isReader) {
            ReaderCard readerCard = loginService.findReaderCardByEmployeeId(id);
            request.getSession().setAttribute("readercard", readerCard);
            res.put("stateCode", "2");
            res.put("msg", "读者登陆成功！");
        } else {
            res.put("stateCode", "0");
            res.put("msg", "账号或密码错误！");
        }
        return res;
    }

    @RequestMapping("/admin_main.html")
    public ModelAndView toAdminMain(HttpServletResponse response) {
        return new ModelAndView("admin_main");
    }

    @RequestMapping("/reader_main.html")
    public ModelAndView toReaderMain(HttpServletResponse response) {
        return new ModelAndView("reader_main");
    }

    @RequestMapping("/admin_repasswd.html")
    public ModelAndView reAdminPasswd() {
        return new ModelAndView("admin_repasswd");
    }

    @RequestMapping("/register.html")
    public ModelAndView register() {
        return new ModelAndView("register");
    }

    @RequestMapping("register_add_do.html")
    public String registerAddDo(String name, String employeeId, String deptName, String phone, String password, RedirectAttributes redirectAttributes) {
        ReaderInfo readerInfo = new ReaderInfo();
        readerInfo.setName(name);
        readerInfo.setDeptName(deptName);
        readerInfo.setPhone(phone);
        readerInfo.setEmployeeId(employeeId);
        long readerId = readerInfoService.addReaderInfo(readerInfo);
        readerInfo.setReaderId(readerId);
        if (readerId > 0 && readerCardService.addReaderCard(readerInfo, password)) {
            redirectAttributes.addFlashAttribute("succ", "信息注册成功！");
        } else {
            redirectAttributes.addFlashAttribute("fail", "信息注册失败！");
        }
        return "redirect:/login.html";
    }

    @RequestMapping("/admin_repasswd_do")
    public String reAdminPasswdDo(HttpServletRequest request, String oldPasswd, String newPasswd, String reNewPasswd, RedirectAttributes redirectAttributes) {
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        String id = admin.getAdminId();
        String password = loginService.getAdminPassword(id);
        if (password.equals(oldPasswd)) {
            if (loginService.adminRePassword(id, newPasswd)) {
                redirectAttributes.addFlashAttribute("succ", "密码修改成功！");
                return "redirect:/admin_repasswd.html";
            } else {
                redirectAttributes.addFlashAttribute("error", "密码修改失败！");
                return "redirect:/admin_repasswd.html";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "旧密码错误！");
            return "redirect:/admin_repasswd.html";
        }
    }

    @RequestMapping("/reader_repasswd.html")
    public ModelAndView reReaderPasswd() {
        return new ModelAndView("reader_repasswd");
    }

    @RequestMapping("/reader_repasswd_do")
    public String reReaderPasswdDo(HttpServletRequest request, String oldPasswd, String newPasswd, String reNewPasswd, RedirectAttributes redirectAttributes) {
        ReaderCard reader = (ReaderCard) request.getSession().getAttribute("readercard");
        long id = reader.getReaderId();
        String password = loginService.getReaderPassword(id);
        if (password.equals(oldPasswd)) {
            if (loginService.readerRePassword(id, newPasswd)) {
                redirectAttributes.addFlashAttribute("succ", "密码修改成功！");
                return "redirect:/reader_repasswd.html";
            } else {
                redirectAttributes.addFlashAttribute("error", "密码修改失败！");
                return "redirect:/reader_repasswd.html";
            }
        } else {
            redirectAttributes.addFlashAttribute("error", "旧密码错误！");
            return "redirect:/reader_repasswd.html";
        }
    }

    //配置404页面
    @RequestMapping("*")
    public String notFind() {
        return "404";
    }

}