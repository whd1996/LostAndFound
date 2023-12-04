package com.lin.lostandfound.websocket;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.lin.lostandfound.entities.domain.User;
import com.lin.lostandfound.entities.vo.MessageVo;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.*;

import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

/**
 * Socket处理器
 * 
 * @author lgllink
 * 
 * @Date 2017年3月1日 下午1:19:50
 */

@Component("handler")
public class ChatWebSocketHandler implements WebSocketHandler {

	public static final Map<Long, WebSocketSession> userSocketSessionMap;

	static {
		userSocketSessionMap = new HashMap<Long, WebSocketSession>();
	}
	
	/**
	 * 建立连接后
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session)
			throws Exception {
		User user = (User) session.getAttributes().get("userName");
		if (user != null) {
			System.out.println("建立连接后user: " + user);
			if (userSocketSessionMap.get(user.getId()) == null) {
				userSocketSessionMap.put(user.getId(), session);
			}

			// 建立连接后向其他用户发送一条上线消息
			this.broadcast(new TextMessage(new GsonBuilder()
					.setDateFormat("yyyy-MM-dd HH:mm:ss")
					.create()
					.toJson(new MessageVo(-2L, null, 0L, "<b style='color:red;'>"
							+ user.getUserName() + "</b>上线了", new Date(),
							userSocketSessionMap.size()))));
		}

		System.out.println("connect to the websocket success......当前在线数量:"
				+ userSocketSessionMap.size());
	}
	
	/**
	 * 关闭连接后
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session,
			CloseStatus closeStatus) throws Exception {
		User user = (User) session.getAttributes().get("userName");
		Iterator<Entry<Long, WebSocketSession>> it = userSocketSessionMap
				.entrySet().iterator();

		if (user != null) {
			// 移除Socket会话
			while (it.hasNext()) {
				Entry<Long, WebSocketSession> entry = it.next();
				if (((User) (entry.getValue().getAttributes().get("userName")))
						.getId().equals(user.getId())) {
					System.out.println("Socket会话已经移除: [用户ID: " + entry.getKey()
							+ " ]");
					userSocketSessionMap.remove(entry.getKey());
					// 关闭连接后向其他用户发送一条下线消息
					this.broadcast(new TextMessage(new GsonBuilder()
							.setDateFormat("yyyy-MM-dd HH:mm:ss")
							.create()
							.toJson(new MessageVo(-2L, null, 0L,
									"<b style='color:red;'>"
											+ user.getUserName() + "</b>下线离开了",
									new Date(), userSocketSessionMap.size()))));
					System.out.println("用户: " + user.getUserName() + "已退出！");
					System.out
							.println("剩余在线数量: " + userSocketSessionMap.size());
					break;
				}
			}
		}
	}


	/**
	 * 消息处理，在客户端通过Websocket API发送的消息会经过这里，然后进行相应的处理
	 */
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception{
		if(message.getPayload() == null || message.getPayloadLength() == 0)
			return;
		
		MessageVo msg=new Gson().fromJson(message.getPayload().toString(),MessageVo.class);
		msg.setDate(new Date());
		this.sendMessageToUser(msg.getTo(), new TextMessage(new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(msg)));
	}

	/**
	 * 消息传输错误处理
	 */
	@Override
	public void handleTransportError(WebSocketSession session,
			Throwable exception) throws Exception {

		User user = (User) session.getAttributes().get("userName");
		Iterator<Entry<Long, WebSocketSession>> it = userSocketSessionMap
				.entrySet().iterator();

		if (user != null) {
			// 移除Socket会话
			while (it.hasNext()) {
				Entry<Long, WebSocketSession> entry = it.next();
				if (((User) entry.getValue().getAttributes().get("userName"))
						.getId().equals(user.getId())) {
					System.out.println("消息传输出错 Socket会话已经移除: [用户ID: "
							+ entry.getKey() + " ]");
					userSocketSessionMap.remove(entry.getKey());
					// 消息传输出错后向其他用户发送一条下线消息
					this.broadcast(new TextMessage(new GsonBuilder()
							.setDateFormat("yyyy-MM-dd HH:mm:ss")
							.create()
							.toJson(new MessageVo(-2L, null, 0L,
									"<b style='color:red;'>"
											+ ((User) entry.getValue()
													.getAttributes()
													.get("userName"))
													.getUserName()
											+ "</b>下线离开了", new Date(),
									userSocketSessionMap.size()))));
					break;
				}
			}
		}

		if (session.isOpen()) {
			session.close();
		}
	}

	@Override
	public boolean supportsPartialMessages() {
		
		return false;
	}
	
	/**
	 * 给所有在线的其他用户发送消息（群聊）
	 * @param userName
	 * @param message
	 * @throws IOException
	 */
	public void broadcastExcludeSelf(final TextMessage message, final Long uid)
			throws IOException {
		Iterator<Entry<Long, WebSocketSession>> it = userSocketSessionMap
				.entrySet().iterator();

		// 多线程群发
		while (it.hasNext()) {
			final Entry<Long, WebSocketSession> entry = it.next();
			// 把自己剔除
			if (entry.getValue().isOpen() && (!entry.getKey().equals(uid))) {
				// entry.getValue().sendMessage(message);
				new Thread(new Runnable() {
					@Override
					public void run() {
						try {
							entry.getValue().sendMessage(message);
						} catch (IOException e) {
							e.printStackTrace();
						}
					}
				}).start();
			}
		}
	}
	
	/**
	 * 给所有在线用户发送消息（系统广播）
	 * 
	 * @param message
	 * @throws IOException
	 */
	public void broadcast(final TextMessage message) throws IOException {
		Iterator<Entry<Long, WebSocketSession>> it = userSocketSessionMap
				.entrySet().iterator();

		// 多线程广播
		while (it.hasNext()) {
			final Entry<Long, WebSocketSession> entry = it.next();
			if (entry.getValue().isOpen()) {
				// entry.getValue().sendMessage(message);
				new Thread(new Runnable() {
					public void run() {
						try {
							if (entry.getValue().isOpen()) {
								entry.getValue().sendMessage(message);
							}
						} catch (IOException e) {
							e.printStackTrace();
						}
					}

				}).start();
			}
		}
	}

	/**
	 * 给某个用户发送消息
	 * 
	 * @param userName
	 * @param message
	 * @throws IOException
	 */
	public void sendMessageToUser(Long uid, TextMessage message)
			throws IOException {
		WebSocketSession session = userSocketSessionMap.get(uid);
		if (session != null && session.isOpen()) {
			session.sendMessage(message);
		}
	}

}
