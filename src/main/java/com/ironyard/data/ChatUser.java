package com.ironyard.data;

import javax.persistence.*;

/**
 * Created by wailm.yousif on 2/9/17.
 */

@Entity
public class ChatUser
{
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "chat_user_sequence")
    @SequenceGenerator(name="chat_user_sequence", sequenceName = "chat_user_sequence", allocationSize = 50, initialValue = 50)
    private long id;

    @Column(unique = true)
    private String username;

    private String password;
    private String displayName;

    @OneToOne(cascade = CascadeType.ALL)
    private UserPermission userPermission;

    private String photoFile;
    private String smallPhotoFile;


/*
    @OneToMany(cascade = {CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    private List<ChatMessage> chatMessages;
    */
    /*
    @OneToMany(cascade = {CascadeType.PERSIST, CascadeType.MERGE, CascadeType.REFRESH}, fetch = FetchType.LAZY)
    private List<ChatMessage> chatMessages;
    */

    public ChatUser() { }

    public ChatUser(String username, String password, String displayName) {
        this.username = username;
        this.password = password;
        this.displayName = displayName;
    }

    public ChatUser(String username, String password, String displayName, UserPermission userPermission) {
        this.username = username;
        this.password = password;
        this.displayName = displayName;
        this.userPermission = userPermission;
    }

    public String getSmallPhotoFile() {
        return smallPhotoFile;
    }

    public void setSmallPhotoFile(String smallPhotoFile) {
        this.smallPhotoFile = smallPhotoFile;
    }

    public String getPhotoFile() {
        return photoFile;
    }

    public void setPhotoFile(String photoFile) {
        this.photoFile = photoFile;
    }

    public UserPermission getUserPermission() {
        return userPermission;
    }

    public void setUserPermission(UserPermission userPermission) {
        this.userPermission = userPermission;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getDisplayName() {
        return displayName;
    }

    public void setDisplayName(String displayName) {
        this.displayName = displayName;
    }

}
