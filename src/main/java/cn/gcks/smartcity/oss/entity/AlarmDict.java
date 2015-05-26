package cn.gcks.smartcity.oss.entity;

import lombok.Data;

import javax.persistence.*;

/**
 * Created by pasenger on 2015/5/25.
 */

@Entity
@Table(name = "alarm_dict", schema = "alarm")
@Data
public class AlarmDict {
    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "cgid")
    private int cgId;

    @Column(name = "cgname")
    private String cgName;

    @Column(name = "dictid")
    private int dictId;

    @Column(name = "dictname")
    private String dictName;

    @Column(name = "dictdesc")
    private String dictDesc;
}
