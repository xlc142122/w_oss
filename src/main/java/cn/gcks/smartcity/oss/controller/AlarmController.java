package cn.gcks.smartcity.oss.controller;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.service.AlarmInfoService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
@RestController
@RequestMapping("/alarm")
@Data
@Slf4j
public class AlarmController {
    @Autowired
    private AlarmInfoService alarmInfoService;


    @RequestMapping(value = "findByLevelAndStatus")
    @ResponseBody
    public List<AlarmInfo> getAlarmList(@RequestParam("level")int level,
                                        @RequestParam("status")int status,
                                        @RequestParam("page")int pageNum){
        return alarmInfoService.findByLevelAndStatus(level, status, pageNum);
    }

    @RequestMapping(value = "clear")
    public String clearAlarm(@RequestParam("id")Long id, HttpSession httpSession){
        String username = (String) httpSession.getAttribute("username");

        AlarmInfo alarmInfo = alarmInfoService.findOne(id);
        if(alarmInfo != null){

            log.info("clear alarm: username:{}, alarmID:{}", username, id);
            alarmInfo.setStatus(1);
            alarmInfoService.save(alarmInfo);
        }

        return "0";
    }
}
