package cn.gcks.smartcity.oss.service;

import cn.gcks.smartcity.oss.repository.AlarmCounterDefRepostory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by pasenger on 2015/5/25.
 */

@Service
public class AlarmCounterDefService {

    @Autowired
    private AlarmCounterDefRepostory alarmCounterDefRepostory;
}
