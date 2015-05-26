package cn.gcks.smartcity.oss.service;

import java.util.ArrayList;
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
        List<String> vector = new ArrayList<>();
        int maxNum = 3;

        vector.add("a");
        vector.add("b");
        vector.add("c");
        vector.add("d");

        vector.remove(0);



       for(int i = 0; i < maxNum; i++){
           System.out.println(vector.get(i));
       }

    }
}
