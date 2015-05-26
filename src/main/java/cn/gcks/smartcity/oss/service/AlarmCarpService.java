package cn.gcks.smartcity.oss.service;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;
import cn.gcks.smartcity.oss.entity.AlarmInfo;
import cn.gcks.smartcity.oss.entity.AlarmRule;
import lombok.Data;
import lombok.Synchronized;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.InitializingBean;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by pasenger on 2015/5/25.
 */
@Slf4j
@Data
@Service
public class AlarmCarpService implements InitializingBean {

    @Autowired
    private AlarmRuleService alarmRuleService;

    private List<AlarmRule> alarmRuleList;

    /**
     * log list
     */
    private static Vector<AlarmInfo> alarmQUeue = new Vector<AlarmInfo>();

    @Autowired
    private AlarmInfoService alarmInfoService;


    @Value("${carp.maxInMem}")
    private int maxInMem = 1000;

    @Value("${carp.serverIp}")
    private String serverIp;

    @Value("${carp.serverPort}")
    private int serverPort;

    @Value("${carp.username}")
    private String username;

    @Value("${carp.password}")
    private String password;

    @Value("${carp.command}")
    private String command;

    /**
     * 获取告警
     * @param number 获取数量
     * @return
     */
    public Vector<AlarmInfo> getAlarm(int number){
        Vector<AlarmInfo> vector = new Vector<AlarmInfo>();
        for(int i = alarmQUeue.size() - 1; i>=0; i--){
            vector.add(this.alarmQUeue.get(i));

            if(vector.size() == number){
                break;
            }
        }

        return vector;
    }

    /**
     * 采集告警
     */
    public void carpAlarm() {
        Connection connection = new Connection(serverIp, serverPort);
        try {
            connection.connect();

            if (connection.authenticateWithPassword(username, password)) {
                Session session = connection.openSession();
                session.execCommand(command, "UTF-8");

                InputStream stdout = new StreamGobbler(session.getStdout());
                BufferedReader br = new BufferedReader(new InputStreamReader(stdout));

                while (Thread.interrupted()) {
                    String line = br.readLine();
                    System.out.println(line);
                    if (line != null) {
                        System.out.println(line);

                        if(alarmQUeue.size() == maxInMem){
                            alarmQUeue.remove(0);
                        }

                        alarmQUeue.add(parserLog(line));
                    }
                }

            } else {
                log.error("服务器用户名，用户名或密码错误：ip:{}, port:{}, username:{}, password:{}", serverIp, serverPort, username, password);
            }
        } catch (Exception e) {
            log.error("连接服务器失败! ip:{}, port:{}", serverIp, serverPort);
        }
    }

    @Synchronized
    private void addAlarm(AlarmInfo alarmInfo){
        alarmQUeue.add(alarmInfo);
    }
    /**
     * 解析日志内容
     * @param content
     * @return
     */
    private AlarmInfo parserLog(String content) {
        if (alarmRuleList == null || alarmRuleList.size() == 0) {
            return null;
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        AlarmInfo alarmInfo = null;
        for (AlarmRule alarmRule : alarmRuleList) {
            Pattern pattern = Pattern.compile(alarmRule.getRegex());
            Matcher matcher = pattern.matcher(content);

            if (matcher.find()) {
                String[] fieldArray = alarmRule.getContent().split("\\|");
                alarmInfo = new AlarmInfo();
                alarmInfo.setVendor(1);
                alarmInfo.setType(alarmRule.getType());
                alarmInfo.setLevel(alarmRule.getLevel());

                switch (alarmRule.getType()) {
                    case 1: //端口起停告警
                        //eqip|gentime|eqname|-|f01|f02
                        alarmInfo.setEqIp(matcher.group(1));
                        try {
                            alarmInfo.setGenTime(sdf.parse(matcher.group(2)));
                        } catch (ParseException e) {
                            log.error("gentime error: {}", content);
                            alarmInfo.setGenTime(new Date());
                        }
                        alarmInfo.setEqName(matcher.group(3));
                        alarmInfo.setF01(matcher.group(5)); //端口
                        alarmInfo.setF02(matcher.group(6)); //状态

                        alarmInfo.setAbDesc("端口起停告警：端口：" + alarmInfo.getF01() + "， 状态：" + alarmInfo.getF02());

                        break;
                    case 2: //系统重启
                        //"gentime|eqip|eqname|-|f01";
                        SimpleDateFormat sdf2 = new SimpleDateFormat("MMM  dd HH:mm:ss", Locale.ENGLISH);
                        Date date = null;
                        try {
                            date = sdf2.parse(matcher.group(1));
                        } catch (ParseException e) {
                            e.printStackTrace();
                        }

                        Calendar calendar = Calendar.getInstance();
                        int year = calendar.get(Calendar.YEAR);
                        calendar.setTime(date);
                        calendar.set(Calendar.YEAR, year);

                        alarmInfo.setGenTime(calendar.getTime());

                        alarmInfo.setEqIp(matcher.group(2));
                        alarmInfo.setEqName(matcher.group(3));
                        alarmInfo.setF01(matcher.group(5)); //System restarted

                        alarmInfo.setAbDesc("System restarted");

                        break;
                    case 3: //光功率低
                        //eqip|gentime|eqname|-|f01|f02
                        alarmInfo.setEqIp(matcher.group(1));

                        SimpleDateFormat sdf3 = new SimpleDateFormat("MMM  dd yyyy HH:mm:ss", Locale.ENGLISH);
                        Date date3 = null;
                        try {
                            date3 = sdf3.parse(matcher.group(2));
                        } catch (ParseException e) {
                            log.info("gentime error:{}", content);
                        }

                        alarmInfo.setGenTime(date3);

                        alarmInfo.setEqName(matcher.group(3));
                        alarmInfo.setF01(matcher.group(5)); //端口
                        alarmInfo.setF02(matcher.group(6)); //Rx功率

                        alarmInfo.setAbDesc("光功率低：端口" + alarmInfo.getF01() + ", Rx power = " + alarmInfo.getF02());

                        break;
                    case 4: //CPU利用率高
                        //eqip|gentime|eqname|-|f01|f02
                        alarmInfo.setEqIp(matcher.group(1));

                        SimpleDateFormat sdf4 = new SimpleDateFormat("MMM  dd yyyy HH:mm:ss", Locale.ENGLISH);
                        Date date4 = null;
                        try {
                            date4 = sdf4.parse(matcher.group(2));
                        } catch (ParseException e) {
                            log.info("gentime error:{}", content);
                        }

                        alarmInfo.setGenTime(date4);

                        alarmInfo.setEqName(matcher.group(5));
                        alarmInfo.setF01(matcher.group(5)); //设备
                        alarmInfo.setF02(matcher.group(6)); //CPU使用率

                        alarmInfo.setAbDesc("CPU利用率高: 设备：" + alarmInfo.getF01() + ", CPU利用率：" + alarmInfo.getF02() + "%");

                        break;
                    case 5: //冷启动
                        //eqip|gentime|eqname|-|f01|f02|f03
                        alarmInfo.setEqIp(matcher.group(1));

                        SimpleDateFormat sdf5 = new SimpleDateFormat("MMM  dd yyyy HH:mm:ss", Locale.ENGLISH);
                        Date date5 = null;
                        try {
                            date5 = sdf5.parse(matcher.group(2));
                        } catch (ParseException e) {
                            log.info("gentime error:{}", content);
                        }

                        alarmInfo.setGenTime(date5);

                        alarmInfo.setEqName(matcher.group(3));
                        alarmInfo.setF01(matcher.group(5)); //AP ID
                        alarmInfo.setF02(matcher.group(6)); //AP MAC
                        alarmInfo.setF03(matcher.group(7)); //恢复信息

                        alarmInfo.setAbDesc("冷启动告警：APID:" + alarmInfo.getF01() + ", AP MAC:" + alarmInfo.getF02() + ", INFO:" + alarmInfo.getF03());

                        break;
                    case 6: //无线端口
                        //eqip|gentime|eqname|-|f01|f02|f03
                        alarmInfo.setEqIp(matcher.group(1));

                        SimpleDateFormat sdf6 = new SimpleDateFormat("MMM  dd yyyy HH:mm:ss", Locale.ENGLISH);
                        Date date6 = null;
                        try {
                            date6 = sdf6.parse(matcher.group(2));
                        } catch (ParseException e) {
                            log.info("gentime error:{}", content);
                        }

                        alarmInfo.setGenTime(date6);

                        alarmInfo.setEqName(matcher.group(3));
                        alarmInfo.setF01(matcher.group(6)); //AP ID
                        alarmInfo.setF02(matcher.group(7)); //AP MAC
                        alarmInfo.setF03(matcher.group(8)); //CauseStr

                        alarmInfo.setAbDesc("无线端口告警：APID:" + alarmInfo.getF01() + ", AP MAC:" + alarmInfo.getF02() +",原因：" + alarmInfo.getF03());

                        break;

                }

                break;
            }
        }

        if(alarmInfo != null){
            alarmInfoService.save(alarmInfo);
        }

        return alarmInfo;
    }

    @Override
    public void afterPropertiesSet() throws Exception {
        alarmRuleList = alarmRuleService.findAll();

        if (alarmRuleList == null || alarmRuleList.size() == 0) {
            log.error("alarm_rule为空， 不解析AC日志");
        }else{
            this.carpAlarm();
        }

        for(int i =0; i<100; i++){
            AlarmInfo alarmInfo = new AlarmInfo();
            alarmInfo.setId((long) i);
            alarmInfo.setVendor(1);
            alarmInfo.setLevel(i%3 == 0 ? 1 : i%3);
            alarmInfo.setEqIp("10.32.8." + i);
            alarmInfo.setEqName("eq-" + i);
            alarmInfo.setAbDesc("down");
            alarmInfo.setGenTime(new Date());

            alarmQUeue.add(alarmInfo);
        }
    }

    public static void main(String[] args) {

        int type = 1;

        String content = null;
        String regex = null;
        String field = null;
        String[] fieldArr = null;
        Pattern pattern = null;
        Matcher matcher = null;
        switch (type) {
            case 1:
                //端口起停
                content = "May 5 22:30:19 172.18.19.19 2015-5-5 14:30:17 DL-DS1-F2A-L-01 %%01IFPDT/4/IF_STATE(l)[326]:Interface GigabitEthernet0/0/8 has turned into DOWN state.";
                regex = "\\s(\\d+\\.\\d+\\.\\d+\\.\\d+)\\s(\\d{4}-\\d+-\\d+\\s\\d+:\\d+:\\d+)\\s([A-Z0-9\\-]+)\\s%%(01IFPDT/4/IF_STATE\\(l\\)).*(GigabitEthernet.*)\\shas.*(UP|DOWN)\\sstate.*";
                field = "eqip|gentime|eqname|-|f01|f02";
                fieldArr = field.split("\\|");
                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(content);
                if (matcher.find()) {
                    for (int i = 0; i < fieldArr.length; i++) {
                        System.out.println(fieldArr[i] + " = " + matcher.group(i + 1));
                    }
                }
                break;
            case 2:
                //系统重启
                content = "May  5 22:27:58 172.18.19.19 2015 DL-DS1-F2A-L-01 %% 01 IC/6/SYS_RESTART(l):System restarted --Huawei Versatile Routing Platform Software.Copyright (c) 2000-2002 by VRP Team Beijing Institute Huawei Tech, Inc.";
                regex = "([a-zA-Z]+\\s+\\d+\\s\\d+:\\d+:\\d+)\\s+(\\d+\\.\\d+\\.\\d+\\.\\d+)\\s+\\d{4}\\s([a-zA-Z0-9\\-]+)\\s%%.*(SYS_RESTART\\(l\\)).*(System restarted).*";
                field = "gentime|eqip|eqname|-|f01";
                fieldArr = field.split("\\|");
                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(content);

                SimpleDateFormat sdf = new SimpleDateFormat("MMM  dd HH:mm:ss", Locale.ENGLISH);
                if (matcher.find()) {
                    for (int i = 0; i < fieldArr.length; i++) {
                        System.out.println(fieldArr[i] + " = " + matcher.group(i + 1));
                    }

                    Date date = null;
                    try {
                        date = sdf.parse(matcher.group(1));
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                    System.out.println(date);

                    Calendar calendar = Calendar.getInstance();
                    int year = calendar.get(Calendar.YEAR);
                    calendar.setTime(date);
                    calendar.set(Calendar.YEAR, year);

                    sdf.applyPattern("yyyy-MM-dd HH:mm:ss");
                    System.out.println(sdf.format(calendar.getTime()));
                }
                break;
            case 3:
                //光功率低
                content = "May  5 22:31:17 172.18.0.129 May  5 2015 14:31:17 DL-CORE-LHL-D-01 SRM/3/OPTPWRABNORMAL:OID 1.3.6.1.4.1.2011.5.25.129.2.17.1 Optical module power is abnormal. (EntityPhysicalIndex=67305870, BaseTrapSeverity=5, BaseTrapProbableCause=67697, BaseTrapEventType=9, EntPhysicalContainedIn=0, EntPhysicalName=GigabitEthernet0/0/6, RelativeResource=Interface GigabitEthernet0/0/6 optical module Rx Power, " +
                        "ReasonDescription=Rx power is too low. The detail information is as follows: The current Rx power is -23.85dBM; " +
                        "Set lower threshold is -21.00dBM; Default lower threshold is -21.00dBM)";
                // The current Rx power is -23.85dBM
                regex = "\\s(\\d+\\.\\d+\\.\\d+\\.\\d+)\\s([a-zA-Z]+\\s+\\d+\\s\\d{4}\\s\\d+:\\d+:\\d+)\\s([a-zA-Z0-9\\-]+)\\s(SRM/\\d+/OPTPWRABNORMAL).*(GigabitEthernet\\d+/\\d+/\\d+).*The current Rx power is\\s+([-0-9]+\\.[0-9]*).*";
                field = "eqip|gentime|eqname|-|f01|f02";
                fieldArr = field.split("\\|");
                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(content);

                SimpleDateFormat sdf3 = new SimpleDateFormat("MMM  dd yyyy HH:mm:ss", Locale.ENGLISH);
                if (matcher.find()) {
                    for (int i = 0; i < fieldArr.length; i++) {
                        System.out.println(fieldArr[i] + " = " + matcher.group(i + 1));
                    }

                    Date date = null;
                    try {
                        date = sdf3.parse(matcher.group(2));
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }
                    System.out.println(date);

                    Calendar calendar = Calendar.getInstance();
                    int year = calendar.get(Calendar.YEAR);
                    calendar.setTime(date);
                    calendar.set(Calendar.YEAR, year);

                    sdf3.applyPattern("yyyy-MM-dd HH:mm:ss");
                    System.out.println(sdf3.format(calendar.getTime()));
                }
                break;

            case 4:
                content = "May  5 11:02:10 172.18.0.33 May  5 2015 11:02:10+08:00 ACU2 ENTITYTRAP/2/CPUUSAGERISING:OID 1.3.6.1.4.1.2011.5.25.219.2.14.1 " +
                        "CPU utilization exceeded the pre-alarm threshold.(Index=9, HwEntityPhysicalIndex=9, PhysicalName=\"SRU Board 0\", " +
                        "EntityThresholdType=0, EntityThresholdWarning=80, EntityThresholdCurrent=83, EntityTrapFaultID=144896)";

                //ENTITYTRAP/4/CPUUSAGERISING
                //ENTITYTRAP/4/ENTITYCPURESUME
                regex = ".*\\s(\\d+\\.\\d+\\.\\d+\\.\\d+)\\s([a-zA-Z]{3}\\s+\\d+\\s+\\d{4}\\s\\d{2}:\\d{2}:\\d{2}).*\\s(ENTITYTRAP/\\d+/(CPUUSAGERISING|ENTITYCPURESUME)).*.*PhysicalName=\"(.*)\",\\s+EntityThresholdType.* EntityThresholdCurrent=(.*),\\s+EntityTrapFaultID=.*";
                field = "eqip|gentime|-|-|f01|f02";

                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(content);

                if(matcher.find()){
                    for(int i = 0; i< 6; i++){
                        System.out.println(matcher.group(i + 1));
                    }
                }
                break;
            case 5://冷启动
                content = "May  5 22:31:51 172.18.0.33 May  5 2015 22:31:51+08:00 DL-CORE-LHL-W-01 WLAN/4/AP COLD BOOT:OID 1.3.6.1.4.1.2011.6.139.2.1.1.42 The AP cold boot. (AP TYPE=AP5030DN, AP Id=1445, AP Sys Name=ap-1445, AP MAC=[e0.97.96.bc.58.40 (hex)], AP Sys Time=2015-05-05 22:31:51, AP Alarm name=ApColdBootNotify)";
                content = "May  5 22:31:51 172.18.0.33 May  5 2015 22:31:51+08:00 DL-CORE-LHL-W-01 WLAN/4/AP COLD BOOT RESTORE:OID 1.3.6.1.4.1.2011.6.139.2.1.1.43 The AP cold boot restore. (AP TYPE=AP5030DN, AP Id=1445, AP Sys Name=ap-1445, AP MAC=[e0.97.96.bc.58.40 (hex)], AP Sys Time=2015-05-05 22:31:51, AP Alarm name=ApColdBootRestoreNotify)";

                regex = "\\s(\\d+\\.\\d+\\.\\d+\\.\\d+)\\s([a-zA-Z]+\\s+\\d+\\s\\d{4}\\s\\d+:\\d+:\\d+)\\+08:00\\s([a-zA-Z0-9\\-]+)\\s(WLAN/\\d+/AP COLD BOOT).*AP Id=(\\d{4}).*\\s+AP MAC=\\[(.*)\\(hex.*\\].*AP Alarm name=(.*)\\)";
                field = "eqip|gentime|eqname|-|f01|f02|f03";

                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(content);

                if(matcher.find()){
                    for(int i = 0; i< 7; i++){
                        System.out.println(matcher.group(i + 1));
                    }
                }
                break;

            case 6:
                content = "May  8 07:07:44 172.18.0.41 May  8 2015 07:07:44+08:00 DL-JZY-B1M-W-01 WLAN/4/AP_WIRELESS_PORT_DOWN_RESTORE:OID " +
                        "1.3.6.1.4.1.2011.6.139.3.24.1.13 AP radio is down notify.(APID=1, APID=1, RadioID=1, APMAC=[e0.97.96.c1.8a.80 (hex)], " +
                        "CauseId=0, CauseStr=Link down by command)";

//                WLAN/4/AP_WIRELESS_PORT_DOWN
//                WLAN/4/AP_WIRELESS_PORT_DOWN_RESTORE
                regex = "\\s(\\d+\\.\\d+\\.\\d+\\.\\d+)\\s([a-zA-Z\\-]+\\s+\\d+\\s\\d{4}\\s\\d+:\\d+:\\d+)\\+08:00\\s([a-zA-Z0-9\\-]+)\\s(WLAN/\\d+/(AP_WIRELESS_PORT_DOWN_RESTORE|AP_WIRELESS_PORT_DOWN)).*APID=(\\d+),.*APMAC=\\[(.*)\\(hex\\)\\].*CauseStr=(.*)\\).*";

                field = "eqip|gentime|eqname|-|-|f01|f02|f03";

                pattern = Pattern.compile(regex);
                matcher = pattern.matcher(content);

                if(matcher.find()){
                    for(int i = 0; i< 8; i++){
                        System.out.println(matcher.group(i + 1));
                    }
                }
                break;
        }


    }
}
