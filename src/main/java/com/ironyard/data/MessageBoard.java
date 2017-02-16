package com.ironyard.data;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * Created by wailm.yousif on 2/9/17.
 */

@Entity
public class MessageBoard
{
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "msg_board_sequence")
    @SequenceGenerator(name="msg_board_sequence", sequenceName = "msg_board_sequence", allocationSize = 50, initialValue = 50)
    private long id;

    private String name;
    private Date creationDate;


    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    private List<ChatMessage> chatMessages;


    /*
    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    private List<ChatUser> chatUsers;
    */

    public MessageBoard() { }

    public MessageBoard(String name, Date creationDate) {
        this.name = name;
        this.creationDate = creationDate;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getCreationDate() {
        return creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public List<ChatMessage> getChatMessages() {
        return chatMessages;
    }

    public void setChatMessages(List<ChatMessage> chatMessages) {
        this.chatMessages = chatMessages;
    }
}
