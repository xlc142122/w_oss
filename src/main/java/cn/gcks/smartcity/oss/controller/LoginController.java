package cn.gcks.smartcity.oss.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * Created by Pasenger on 15/5/23.
 */

@Controller
@RequestMapping("/login")
public class LoginController {

    @RequestMapping(value = "login.htm")
    public String login(@RequestParam(value = "username", required = true)String username,
                        @RequestParam(value = "password", required = true)String password,
                        Model model, HttpSession httpSession){

        System.out.println("user: " + username + ", password:" + password);

        model.addAttribute("username", username);

        httpSession.setAttribute("username", username);

        return "redirect:/dashboard/index.htm";

    }
}
