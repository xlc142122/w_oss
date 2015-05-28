package cn.gcks.smartcity.oss.service;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
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
public class AlarmCountWebSocketService extends TextWebSocketHandler {
    //最后一次发送的消息
    private Map<String, String> sessionMsgMap = new HashMap<String, String>();

    @Autowired
    private AlarmInfoService alarmInfoService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        log.debug("Alarm Count Opened new session in instance, sessionId: " + session.getId());
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage textMessage)
            throws Exception {

        while (true){
            String msgContent = alarmInfoService.getAlarmCount();

            String lastMsg = sessionMsgMap.get(session.getId());
            if(msgContent.equals(lastMsg)){
                Thread.sleep(1000);

                continue;
            }

            sessionMsgMap.put(session.getId(), msgContent);

            //log.info("send to {}, msg: {}", session.getId(), msgContent);

            if(session.isOpen()) {
                session.sendMessage(new TextMessage(msgContent));
            }else{
                sessionMsgMap.remove(session.getId());
            }
        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception)
            throws Exception {

        //log.info("session close: {}", session.getId());

        session.close(CloseStatus.SERVER_ERROR);
        sessionMsgMap.remove(session.getId());
    }
}
