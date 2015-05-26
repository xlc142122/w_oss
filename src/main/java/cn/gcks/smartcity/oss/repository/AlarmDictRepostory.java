package cn.gcks.smartcity.oss.repository;

import cn.gcks.smartcity.oss.entity.AlarmDict;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
public interface AlarmDictRepostory extends JpaRepository<AlarmDict, Long> {
    List<AlarmDict> findAll();

    List<AlarmDict> findByCgId(int cgId);
}
