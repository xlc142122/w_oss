package cn.gcks.smartcity.oss.service;

import cn.gcks.smartcity.oss.entity.AlarmInfo;
import lombok.Data;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.serializer.Jackson2JsonRedisSerializer;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.HashMap;
import java.util.Map;

/**
 * Created by Pasenger on 15/5/27.
 */

@Slf4j
@Data
public class AlarmInfoWebSocketService extends TextWebSocketHandler {

    @Autowired
    private AlarmCarpService alarmCarpService;

    /**
     * session对应的alarm index
     */
    private Map<String, Integer> alarmSessionIdxMap = new HashMap<String, Integer>();

    private Jackson2JsonRedisSerializer<AlarmInfo> jackson2JsonRedisSerializer = new Jackson2JsonRedisSerializer<AlarmInfo>(AlarmInfo.class);


    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        log.debug("Alarm Info Opened new session in instance, sessionId: " + session.getId());

        int index = alarmCarpService.getNewAlarmIndex() - 50;
        alarmSessionIdxMap.put(session.getId(), index > 0 ? index : 0);
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage message)
            throws Exception {

        log.info("handleTextMessage");
        while (true){
            int alarmIndex = alarmSessionIdxMap.get(session.getId());

            if(alarmIndex < 500 && alarmIndex >= alarmCarpService.getNewAlarmMap().size()){
                Thread.sleep(1000);

                continue;
            }

            AlarmInfo alarmInfo = alarmCarpService.getNewAlarm(alarmIndex);


            if(alarmInfo != null){
                String msgContent = new String(jackson2JsonRedisSerializer.serialize(alarmInfo));
                //log.info("send to {}, msg: {}", session.getId(), msgContent);
                session.sendMessage(new TextMessage(msgContent));

                alarmIndex++;
                if(alarmIndex > alarmCarpService.getNewAlarmMap().size()){
                    alarmIndex = 0;
                }

                alarmSessionIdxMap.put(session.getId(), alarmIndex);
            }else{
                //log.info("no new alarm!");
                Thread.sleep(1000);
            }


        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception)
            throws Exception {
        session.close(CloseStatus.SERVER_ERROR);

        alarmSessionIdxMap.remove(session.getId());
    }
}
