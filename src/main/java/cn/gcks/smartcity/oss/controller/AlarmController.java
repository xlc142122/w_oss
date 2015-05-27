package cn.gcks.smartcity.oss.controller;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.service.AlarmCarpService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Vector;

/**
 * Created by pasenger on 2015/5/25.
 */
@RestController
@Data
@Slf4j
public class AlarmController {
    @Autowired
    private AlarmCarpService alarmCarpService;

    @RequestMapping(value = "getAlarm", method = RequestMethod.GET)
    @ResponseBody
    public Vector<AlarmInfo> getAlarm(@RequestParam("number")int number){
        return alarmCarpService.getAlarm(number);
    }

    @RequestMapping(value = "getAlarmNum", method = RequestMethod.GET)
    public String getAlarmNum(){
        return alarmCarpService.getLevel1Num() + "-" + alarmCarpService.getLevel2Num() + "-" + alarmCarpService.getLevel3Num();
    }
}
