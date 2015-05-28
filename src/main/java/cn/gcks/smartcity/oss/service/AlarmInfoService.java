package cn.gcks.smartcity.oss.service;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.repository.AlarmInfoRepostory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */

@Service
public class AlarmInfoService {
    @Autowired
    private AlarmInfoRepostory alarmInfoRepostory;

    @Autowired
    private AlarmCarpService alarmCarpService;

    public void save(AlarmInfo alarmInfo){
        alarmInfoRepostory.save(alarmInfo);
    }

    public List<AlarmInfo> findByLevelAndStatus(int level, int status){
        return alarmInfoRepostory.findByLevelAndStatus(level, status);
    }

    public List<AlarmInfo> findByLevelAndStatus(int level, int status, int pageNum){
        if(pageNum < 0){
            return null;
        }

        Pageable pageable = new PageRequest(pageNum, 10);

        return alarmInfoRepostory.findByLevelAndStatusOrderByGenTimeDesc(level, status, pageable).getContent();
    }

    public AlarmInfo findOne(Long id){
        return alarmInfoRepostory.findOne(id);
    }

    public Long countByLevelAndStatus(int level, int status){
        return alarmInfoRepostory.countByLevelAndStatus(level, status);
    }

    public String getAlarmCount(){
        long level1NumActive = countByLevelAndStatus(1, 0);
        long level1NumInActive = countByLevelAndStatus(1, 1);
        long level2NumActive = countByLevelAndStatus(2, 0);
        long level2NumInActive = countByLevelAndStatus(2, 1);
        long level3NumActive = countByLevelAndStatus(3, 0);
        long level3NumInActive = countByLevelAndStatus(3, 1);

        return level1NumActive + "-" + level1NumInActive + "-" +
                level2NumActive + "-" + level2NumInActive + "-" +
                level3NumActive + "-" + level3NumInActive;

    }
}
