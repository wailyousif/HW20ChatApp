package com.ironyard.data;

import java.util.Date;

/**
 * Created by wailm.yousif on 2/12/17.
 */
public class MessagesView
{
    private long id;
    private String messageText;
    private Date postTime;
    private String displayName;

    public MessagesView() { }

    public MessagesView(long id, String messageText, Date postTime, String displayName) {
        this.id = id;
        this.messageText = messageText;
        this.postTime = postTime;
        this.displayName = displayName;
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

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }
}
