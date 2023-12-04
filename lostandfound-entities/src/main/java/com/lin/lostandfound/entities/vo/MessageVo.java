package com.lin.lostandfound.entities.vo;

import java.util.Date;

/**
 * 消息类
 * @author lgllink
 * @Date 2017年3月11日 下午7:32:39
 */
public class MessageVo {

	//发送者
	public Long from;
	//发送者名称
	public String fromName;
	//接收者
	public Long to;
	//发送的文本
	public String text;
	//发送日期
	public Date date;
	
	public int onlineSize;
	
	public MessageVo() {

	}
	
	public MessageVo(Long from, String fromName, Long to, String text, Date date, int onlineSize) {
		super();
		this.from = from;
		this.fromName = fromName;
		this.to = to;
		this.text = text;
		this.date = date;
		this.onlineSize = onlineSize;
	}

	public Long getFrom() {
		return from;
	}

	public void setFrom(Long from) {
		this.from = from;
	}

	public Long getTo() {
		return to;
	}

	public void setTo(Long to) {
		this.to = to;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getFromName() {
		return fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	public int getOnlineSize() {
		return onlineSize;
	}

	public void setOnlineSize(int onlineSize) {
		this.onlineSize = onlineSize;
	}

	@Override
	public String toString() {
		return "Message [from=" + from + ", fromName=" + fromName + ", to="
				+ to + ", text=" + text + ", date=" + date + ", onlineSize="
				+ onlineSize + "]";
	}
}
