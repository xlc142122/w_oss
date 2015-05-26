package cn.gcks.smartcity.oss.repository;

import cn.gcks.smartcity.oss.entity.AlarmCounterDef;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
public interface AlarmCounterDefRepostory extends JpaRepository<AlarmCounterDef, Long>{
    List<AlarmCounterDef> findAll();

    List<AlarmCounterDef> findByTableName(String tableName);

    List<AlarmCounterDef> findByType(int type);
}
