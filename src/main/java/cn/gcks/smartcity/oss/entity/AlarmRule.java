package cn.gcks.smartcity.oss.entity;

import lombok.Data;
import org.springframework.boot.orm.jpa.EntityScan;

import javax.persistence.*;

/**
 * Created by pasenger on 2015/5/25.
 */

@Entity
@Table(name = "alarm_rule", schema = "alarm")
@Data
public class AlarmRule {

    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "vendor")
    private int vendor;

    @Column(name = "level")
    private int level;

    @Column(name = "type")
    private int type;

    @Column(name = "hasrecover")
    private int hasRecover;

    @Column(name = "regex")
    private String regex;

    @Column(name = "content")
    private String content;

    @Column(name = "desc")
    private String desc;
}
