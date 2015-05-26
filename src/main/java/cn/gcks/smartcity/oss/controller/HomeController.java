package cn.gcks.smartcity.oss.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

/**
 * Created by Pasenger on 15/5/23.
 */

@Controller
public class HomeController {

    @RequestMapping("/index.htm")
    public String index(Model model, HttpSession httpSession){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        model.addAttribute("username", username);


        return "redirect:/dashboard/index.htm";
    }


    @RequestMapping("/")
    public String login(Model model){

        return "login/login";
    }
}
