package com.lin.lostandfound.websocket;

import com.lin.lostandfound.common.constants.Constants;
import com.lin.lostandfound.entities.domain.User;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.http.server.ServletServerHttpRequest;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import javax.servlet.http.HttpSession;
import java.util.Map;

/**
 * Socket建立连接（握手）和断开（挥手）
 * 
 * @author lgllink
 * 
 * @Date 2017年3月1日 下午2:23:09
 */

public class ChatHandshakeInterceptor implements HandshakeInterceptor {

	@Override
	public boolean beforeHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Map<String, Object> attributes) throws Exception {

		if (request instanceof ServletServerHttpRequest) {
			ServletServerHttpRequest servletRequest = (ServletServerHttpRequest) request;
			HttpSession session = servletRequest.getServletRequest()
					.getSession(false);
			if (session != null) {
				// 标记用户
				User user = (User) session.getAttribute(Constants.USER);
				if (user != null) {
					System.out.println("Websocket:用户[" + user.getUserName()
							+ "]已经建立连接");
					attributes.put("userName", user);
				} else
					return false;
			}
		}

		return true;
	}
	
	@Override
	public void afterHandshake(ServerHttpRequest request,
			ServerHttpResponse response, WebSocketHandler wsHandler,
			Exception exception) {
			
	}
}
