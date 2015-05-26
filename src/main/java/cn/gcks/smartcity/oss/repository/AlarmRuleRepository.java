package cn.gcks.smartcity.oss.repository;

import cn.gcks.smartcity.oss.entity.AlarmRule;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
public interface AlarmRuleRepository extends JpaRepository<AlarmRule, Long> {
    List<AlarmRule> findAll();

    List<AlarmRule> findByVendor(int vendor);

}
