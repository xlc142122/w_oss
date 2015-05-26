package cn.gcks.smartcity.oss.repository;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
public interface AlarmInfoRepostory extends JpaRepository<AlarmInfo, Long> {
    List<AlarmInfo> findByVendorAndLevel(int vendor, int level);

    List<AlarmInfo> findByVendorAndType(int vendor, int type);
}
