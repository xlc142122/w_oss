package cn.gcks.smartcity.oss.controller;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpSession;

/**
 * Created by Pasenger on 15/5/23.
 */

@Controller
@RequestMapping("/onlineuser/")
public class OnlineUserController {

    @RequestMapping("/find.htm")
    public String find(@RequestParam(value = "mac", required = false)String mac,
                       @RequestParam(value = "userid", required = false)String userId,
                       HttpSession httpSession, Model model){

        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }



        return "onlineuser/index";
    }
}
