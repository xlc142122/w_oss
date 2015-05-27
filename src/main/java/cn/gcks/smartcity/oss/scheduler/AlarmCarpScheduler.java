package cn.gcks.smartcity.oss.scheduler;

import cn.gcks.smartcity.oss.service.AlarmCarpService;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * 告警采集守护线程
 * Created by Pasenger on 15/5/26.
 */

@Component
@Data
@Slf4j
public class AlarmCarpScheduler {
    @Autowired
    private AlarmCarpService alarmCarpService;

    @Scheduled(initialDelay = 30000, fixedDelay = 120000)
    public void startAlarmCarp(){
        if(!alarmCarpService.isRunning() && alarmCarpService.getAlarmRuleList() != null && alarmCarpService.getAlarmRuleList().size() > 0){
            log.error("告警采集已经停止，重启启动...");
            alarmCarpService.carpAlarm();
        }
    }
}
