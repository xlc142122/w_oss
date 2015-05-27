package cn.gcks.smartcity.oss.controller;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.service.AlarmCarpService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Vector;

/**
 * Created by Pasenger on 15/5/23.
 */

@Controller
@RequestMapping("/dashboard")
public class DashboardController {
    @Autowired
    private AlarmCarpService alarmCarpService;

    @RequestMapping("index.htm")
    public String index(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "dashboard/index";
    }

    @RequestMapping("ac.htm")
    public String acAlarm(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        model.addAttribute("level1Num", alarmCarpService.getLevel1Num());
        model.addAttribute("level2Num", alarmCarpService.getLevel2Num());
        model.addAttribute("level3Num", alarmCarpService.getLevel3Num());

        return "dashboard/ac";
    }

    @RequestMapping("server.htm")
    public String serverAlarm(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "dashboard/server";
    }

    @RequestMapping("sms.htm")
    public String smsAlarm(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "dashboard/sms";
    }


}
