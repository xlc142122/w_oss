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
@RequestMapping("/stat/")
public class StatController {

    @RequestMapping("/index.htm")
    public String index(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }
        model.addAttribute("username", username);
        model.addAttribute("portalUserCount", 3500);
        model.addAttribute("wechatUserCount", 398);
        model.addAttribute("appUserCount", 79);

        String oustime = "'1时','2时','3时','4时','5时','6时','7时'";
        String ousportal = "10,15,20,35,40,300,270";
        String ouswechat = "0,1,3,0,4,10,100";
        String ousapp = "0,10,40,30,100,80,120";

        model.addAttribute("oustime", oustime);
        model.addAttribute("ousportal", ousportal);
        model.addAttribute("ouswechat", ouswechat);
        model.addAttribute("ousapp", ousapp);


        return "stat/index";
    }
}
