package com.ironyard.data;

import javax.persistence.*;
import java.util.Date;

/**
 * Created by wailm.yousif on 2/9/17.
 */

@Entity
public class ChatMessage
{
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "chat_msg_sequence")
    @SequenceGenerator(name="chat_msg_sequence", sequenceName = "chat_msg_sequence", allocationSize = 50, initialValue = 50)
    private long id;

    @Column(length = 512)
    private String messageText;

    private Date postTime;

    @ManyToOne
    private ChatUser chatUser;

    @ManyToOne
    private MessageBoard messageBoard;

    private String picFileName;

    public ChatMessage() { }

    public ChatMessage(String messageText, Date postTime) {
        this.messageText = messageText;
        this.postTime = postTime;
    }

    public ChatMessage(String messageText, Date postTime, ChatUser chatUser) {
        this.messageText = messageText;
        this.postTime = postTime;
        this.chatUser = chatUser;
    }

    public ChatMessage(String messageText, Date postTime, ChatUser chatUser, String picFileName) {
        this.messageText = messageText;
        this.postTime = postTime;
        this.chatUser = chatUser;
        this.picFileName = picFileName;
    }

    @Override
    public boolean equals(Object o)
    {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        ChatMessage chatMessage = (ChatMessage) o;
        return id == chatMessage.id;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getMessageText() {
        return messageText;
    }

    public void setMessageText(String messageText) {
        this.messageText = messageText;
    }

    public Date getPostTime() {
        return postTime;
    }

    public void setPostTime(Date postTime) {
        this.postTime = postTime;
    }

    public ChatUser getChatUser() {
        return chatUser;
    }

    public void setChatUser(ChatUser chatUser) {
        this.chatUser = chatUser;
    }

    public String getPicFileName() {
        return picFileName;
    }

    public void setPicFileName(String picFileName) {
        this.picFileName = picFileName;
    }

    public MessageBoard getMessageBoard() {
        return messageBoard;
    }

    public void setMessageBoard(MessageBoard messageBoard) {
        this.messageBoard = messageBoard;
    }
}
