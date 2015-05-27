package cn.gcks.smartcity.oss;

import cn.gcks.smartcity.oss.service.AlarmCountWebSocketService;
import cn.gcks.smartcity.oss.service.AlarmInfoWebSocketService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.context.web.SpringBootServletInitializer;
import org.springframework.context.annotation.Bean;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import java.util.HashSet;
import java.util.Set;

/**
 * Created by Pasenger on 15/5/23.
 */

@SpringBootApplication
@EnableScheduling
@EnableWebSocket
public class Application extends SpringBootServletInitializer implements WebSocketConfigurer{
    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(Application.class);
    }

    public static void main(String[] args) throws Exception {
        SpringApplication application = new SpringApplication(Application.class);

        Set<Object> sourceSet = new HashSet<Object>();
        sourceSet.add("classpath:applicationContext.xml");
        application.setSources(sourceSet);

        application.run(args);
    }

    @Override
    public void registerWebSocketHandlers(WebSocketHandlerRegistry webSocketHandlerRegistry) {
        webSocketHandlerRegistry.addHandler(alarmInfoWebSocketHandler(), "/alarmInfoSocket").withSockJS();
        webSocketHandlerRegistry.addHandler(alarmCountWebSocketHandler(), "/alarmCountSocket").withSockJS();
    }

    @Bean
    public WebSocketHandler alarmInfoWebSocketHandler(){
        return new AlarmInfoWebSocketService();
    }

    @Bean
    public WebSocketHandler alarmCountWebSocketHandler(){
        return new AlarmCountWebSocketService();
    }

}
