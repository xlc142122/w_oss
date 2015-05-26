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
@RequestMapping("/mwl/")
public class WhiteListController {

    @RequestMapping("/list.htm")
    public String list(HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "mtc/mwl";
    }

    @RequestMapping("/find.htm")
    public String find(@RequestParam(value = "mac")String mac,
                               @RequestParam(value = "merchant")String merchant,
                               HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "mtc/mwl";
    }

    @RequestMapping("/add.htm")
    public String add(@RequestParam(value = "mac")String mac,
                               @RequestParam(value = "merchant")String merchant,
                               @RequestParam(value = "market")String market,
                               @RequestParam(value = "ssid")String ssid,
                               HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "mtc/mwl";
    }

    @RequestMapping("/delete.htm")
    public String delWhiteList(@RequestParam(value = "mac")String mac, HttpSession httpSession, Model model){
        String username = (String) httpSession.getAttribute("username");

        if(StringUtils.isBlank(username)){
            return "redirect:/";
        }

        return "mtc/mwl";
    }

}
