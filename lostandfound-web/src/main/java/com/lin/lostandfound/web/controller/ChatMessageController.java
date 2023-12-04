package com.lin.lostandfound.web.controller;

import com.google.gson.GsonBuilder;
import com.lin.lostandfound.common.annotation.SystemControllerLog;
import com.lin.lostandfound.entities.domain.User;
import com.lin.lostandfound.entities.vo.MessageVo;
import com.lin.lostandfound.websocket.ChatWebSocketHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.socket.TextMessage;

import java.io.IOException;
import java.util.Date;

@Controller
@RequestMapping(value = "/message")
public class ChatMessageController {

	@Autowired
	private ChatWebSocketHandler handler;
	
	// 跳转到交谈聊天页面（ajax）
	@SystemControllerLog(description = "进入聊天室")
	@RequestMapping(value ={"/chat.do"}, method = RequestMethod.POST)
	public String chat() {
		System.out.println("chat...");
		
		return "chat/show-message";
	}

	// 跳转到交谈聊天页面
	@RequestMapping(value = "/talk", method = RequestMethod.GET)
	public String talk() {
		System.out.println("talk...");
		
		return "chat/talk";
	}

	// 跳转到发布广播页面
	@RequestMapping(value = "/broadcast.html", method = RequestMethod.GET)
	public String broadcast() {
		
		return "chat/broadcast";
	}
	
	// 群聊
	@ResponseBody
	@RequestMapping(value = {"/groupchat.html"}, method = RequestMethod.POST)
	public void groupChat(String text,User user) throws IOException {
		MessageVo msg = new MessageVo();
		msg.setDate(new Date());
		msg.setFrom(user.getId());
		msg.setFromName(user.getUserName());
		msg.setTo(0L);
		msg.setText(text);
		handler.broadcastExcludeSelf(new TextMessage(new GsonBuilder()
		.setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(msg)), user.getId());
	}

	// 发布系统广播（群发）
	@ResponseBody
	@RequestMapping(value = {"/broadcast.html"}, method = RequestMethod.POST)
	public void broadcast(String text,User user) throws IOException {
		MessageVo msg = new MessageVo();
		msg.setDate(new Date());
		msg.setFrom(-1L);
		msg.setFromName("系统广播");
		msg.setTo(0L);
		msg.setText(text);
		handler.broadcast(new TextMessage(new GsonBuilder()
				.setDateFormat("yyyy-MM-dd HH:mm:ss").create().toJson(msg)));
	}
	
	
	/*
	 * I know it is very old and common problem. I have tried: 
	 * jackson jars in
	 * RequestMapping annotation : producers as JSONin 
	 * RequestMapping annotation : Header as JSON 
	 * combination of 2 and 3
	 * $.post instead of $.ajax (i know it doesn't make difference) 
	 * My bean object(ValidationResponse) has proper setters and getters 
	 * URL doesn't have .htm adding accept JSON header like
	 * accept: { json: 'application/json', xml: 'application/xml' },
	 */

}
