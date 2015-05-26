package cn.gcks.smartcity.oss.utils;

import lombok.Data;
import lombok.extern.slf4j.Slf4j;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.BlockingQueue;

/**
 * Created by pasenger on 2015/5/25.
 */

@Data
@Slf4j
public class SSHUtil {
    /**
     * log list
     */
    private static BlockingQueue<String> logQUeue = new ArrayBlockingQueue<String>(1000);


}
