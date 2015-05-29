package cn.gcks.smartcity.oss.controller;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.service.AlarmCarpService;
import cn.gcks.smartcity.oss.service.AlarmInfoService;
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

    @Autowired
    private AlarmInfoService alarmInfoService;

    @RequestMapping("index.htm")
    public String index(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "dashboard/index";
    }

    @RequestMapping("eqpalarm.htm")
    public String acAlarm(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        long level1NumActive = alarmInfoService.countByLevelAndStatus(1, 1);
        long level1NumInActive = alarmInfoService.countByLevelAndStatus(1, 0);
        long level2NumActive = alarmInfoService.countByLevelAndStatus(2, 0);
        long level2NumInActive = alarmInfoService.countByLevelAndStatus(2, 1);
        long level3NumActive = alarmInfoService.countByLevelAndStatus(3, 0);
        long level3NumInActive = alarmInfoService.countByLevelAndStatus(3, 1);

        model.addAttribute("level1NumActive", level1NumActive);
        model.addAttribute("level1NumInActive", level1NumInActive);
        model.addAttribute("level2NumActive", level2NumActive);
        model.addAttribute("level2NumInActive", level2NumInActive);
        model.addAttribute("level3NumActive", level3NumActive);
        model.addAttribute("level3NumInActive", level3NumInActive);


        return "dashboard/eqpalarm";
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
