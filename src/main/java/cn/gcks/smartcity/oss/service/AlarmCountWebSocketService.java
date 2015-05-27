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
    private AlarmCarpService alarmCarpService;

    @Override
    public void afterConnectionEstablished(WebSocketSession session) {
        log.debug("Alarm Count Opened new session in instance, sessionId: " + session.getId());
    }

    @Override
    public void handleTextMessage(WebSocketSession session, TextMessage textMessage)
            throws Exception {

        log.info("handleTextMessage");
        while (true){
            String msgContent = alarmCarpService.getLevel1Num() + "-" + alarmCarpService.getLevel2Num() + "-" + alarmCarpService.getLevel3Num();

            String lastMsg = sessionMsgMap.get(session.getId());
            if(msgContent.equals(lastMsg)){
                Thread.sleep(1000);

                continue;
            }

            sessionMsgMap.put(session.getId(), msgContent);

            log.info("send to {}, msg: {}", session.getId(), msgContent);

            session.sendMessage(new TextMessage(msgContent));
        }
    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception)
            throws Exception {
        session.close(CloseStatus.SERVER_ERROR);
        sessionMsgMap.remove(session.getId());
    }
}
