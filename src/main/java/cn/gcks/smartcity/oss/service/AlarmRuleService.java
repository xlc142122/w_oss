package cn.gcks.smartcity.oss.service;

import cn.gcks.smartcity.oss.entity.AlarmRule;
import cn.gcks.smartcity.oss.repository.AlarmRuleRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
@Service
public class AlarmRuleService {
    @Autowired
    private AlarmRuleRepository alarmRuleRepository;

    public List<AlarmRule> findAll(){
        return alarmRuleRepository.findAll();
    }
}
