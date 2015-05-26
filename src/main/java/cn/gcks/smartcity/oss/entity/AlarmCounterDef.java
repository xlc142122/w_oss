package cn.gcks.smartcity.oss.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * Created by pasenger on 2015/5/25.
 */

@Entity
@Table(name = "alarm_counter_def", schema = "alarm")
@Data
public class AlarmCounterDef {
    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "enname")
    private String enName;

    @Column(name = "cnname")
    private String cnName;

    @Column(name = "type")
    private int type;

    @Column(name = "tablename")
    private String tableName;

    @Column(name = "fieldname")
    private String fieldName;

    @Column(name = "counterdesc")
    private String counterDesc;
}
