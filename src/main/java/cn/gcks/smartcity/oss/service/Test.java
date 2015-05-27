package cn.gcks.smartcity.oss.service;

import ch.ethz.ssh2.Connection;
import ch.ethz.ssh2.Session;
import ch.ethz.ssh2.StreamGobbler;
import cn.gcks.smartcity.oss.entity.AlarmInfo;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Vector;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

/**
 * Created by pasenger on 2015/5/25.
 */
public class Test {
    public static void main(String[] args) {

        Date date = new Date();
        Vector<AlarmInfo> alarmQueue = new Vector<AlarmInfo>();
        AlarmInfo alarmInfo = new AlarmInfo();
        alarmInfo.setEqIp("10.1.1.1");
        alarmInfo.setEqName("a");
        alarmInfo.setGenTime(date);

        AlarmInfo alarmInfo1 = new AlarmInfo();
        alarmInfo1.setEqIp("10.1.1.2");
        alarmInfo1.setEqName("b");
        alarmInfo1.setGenTime(date);

        alarmQueue.add(alarmInfo);
        alarmQueue.add(alarmInfo1);

        System.out.println(alarmQueue.size());


        AlarmInfo alarmInfo3 = new AlarmInfo();
        alarmInfo3.setEqIp("10.1.1.1");
        alarmInfo3.setEqName("a");
        alarmInfo3.setGenTime(date);

        alarmQueue.remove(alarmInfo3);
        System.out.println(alarmQueue.size());


    }

    /**
     * 采集告警
     */
    public static void carpAlarm() {
        Connection connection = new Connection("172.18.54.111", 22);
        try {
            connection.connect();

            if (connection.authenticateWithPassword("root", "admin@123")) {
                System.out.println("SSHd登录{}成功，开始采集日志...");

                Session session = connection.openSession();
                session.execCommand("tail -f /log/huawei-network.log", "UTF-8");

                InputStream stdout = new StreamGobbler(session.getStdout());

                if(stdout == null){
                    System.out.println("output is null");
                }
                BufferedReader br = new BufferedReader(new InputStreamReader(stdout));

                while (true) {
                    String line = br.readLine();
                    System.out.println("log: " + line);

                }

            } else {
                System.out.println("服务器用户名，用户名或密码错误：ip:{}, port:{}, username:{}, password:{}");
            }
        } catch (Exception e) {
            System.out.println("连接服务器失败! ip:{}, port:{}");
        }
    }
}
