package cn.gcks.smartcity.oss.repository;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.domain.Page;

import java.util.List;

/**
 * Created by pasenger on 2015/5/25.
 */
public interface AlarmInfoRepostory extends PagingAndSortingRepository<AlarmInfo, Long> {
    List<AlarmInfo> findByVendorAndLevel(int vendor, int level);

    List<AlarmInfo> findByVendorAndType(int vendor, int type);

    List<AlarmInfo> findByLevelAndStatus(int level, int status);

    Page<AlarmInfo> findByLevelAndStatusOrderByGenTimeDesc(int level, int status, Pageable pageable);

    Long countByLevelAndStatus(int level, int status);
}
