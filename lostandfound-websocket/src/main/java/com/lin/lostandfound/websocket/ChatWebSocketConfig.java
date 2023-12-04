package com.lin.lostandfound.websocket;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


/**
 * WebScoket配置处理器
 * 
 * @author lgllink
 * 
 * @Date 2017年3月1日 下午1:15:09
 */

@Component
@EnableWebSocket
public class ChatWebSocketConfig implements WebMvcConfigurer, WebSocketConfigurer {
	
	// 设置sockjs连接服务器后未通信的断开时间为5分钟
	//private final long heartbeatTime = 5; 
	
	@Autowired
	@Qualifier("handler")
	private ChatWebSocketHandler handler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		registry.addHandler(handler, "/ws").addInterceptors(new ChatHandshakeInterceptor());

		registry.addHandler(handler, "/ws/sockjs").addInterceptors(new ChatHandshakeInterceptor()).withSockJS();
	}
	
	@Bean
	public WebSocketHandler chatWebSocketHandler() {
		
		return new ChatWebSocketHandler();
	}
}
