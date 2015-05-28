package cn.gcks.smartcity.oss.entity;

import lombok.Data;

import javax.persistence.*;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by pasenger on 2015/5/25.
 */

@Entity
@Table(name = "alarm_info", schema = "alarm")
@Data
public class AlarmInfo {
    @Id
    @GeneratedValue
    private Long id;

    @Column(name = "vendor")
    private int vendor;

    @Column(name = "level")
    private int level;

    @Column(name = "type")
    private int type;

    @Column(name = "eqname")
    private String eqName;

    @Column(name = "eqip")
    private String eqIp;

    @Column(name = "gentime")
    private Date genTime;

    @Column(name = "status")
    private int status;

    @Column(name = "recovertime")
    private Date recoverTime;

    @Column(name = "repeatcount")
    private int repeatCount;

    @Column(name = "abdesc")
    private String abDesc;

    @Column(name = "content")
    private String content;

    @Column(name = "f01")
    private String f01;

    @Column(name = "f02")
    private String f02;

    @Column(name = "f03")
    private String f03;

    @Column(name = "f04")
    private String f04;

    @Column(name = "f05")
    private String f05;

    @Column(name = "f06")
    private String f06;

    @Column(name = "f07")
    private String f07;

    @Column(name = "f08")
    private String f08;

    @Column(name = "f09")
    private String f09;

    @Column(name = "f10")
    private String f10;

    @Transient
    private String genTimeStr;

    public String getGenTimeStr(){
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return sdf.format(genTime);
    }

}
