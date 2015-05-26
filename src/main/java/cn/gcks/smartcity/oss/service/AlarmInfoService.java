package cn.gcks.smartcity.oss.service;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.repository.AlarmInfoRepostory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by pasenger on 2015/5/25.
 */

@Service
public class AlarmInfoService {
    @Autowired
    private AlarmInfoRepostory alarmInfoRepostory;

    public void save(AlarmInfo alarmInfo){
        alarmInfoRepostory.save(alarmInfo);
    }
}
