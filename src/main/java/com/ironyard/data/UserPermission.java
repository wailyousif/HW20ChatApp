package com.ironyard.data;

import javax.persistence.*;

/**
 * Created by wailm.yousif on 2/10/17.
 */

@Entity
public class UserPermission
{
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "user_permission_sequence")
    @SequenceGenerator(name="user_permission_sequence", sequenceName = "user_permission_sequence", allocationSize = 50, initialValue = 50)
    private long id;

    private boolean createUserPermission;
    private boolean createMsgBoardPermission;
    private boolean postMsgPermission;

    public UserPermission() { }

    public UserPermission(boolean createUserPermission, boolean createMsgBoardPermission, boolean postMsgPermission) {
        this.createUserPermission = createUserPermission;
        this.createMsgBoardPermission = createMsgBoardPermission;
        this.postMsgPermission = postMsgPermission;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public boolean isCreateUserPermission() {
        return createUserPermission;
    }

    public void setCreateUserPermission(boolean createUserPermission) {
        this.createUserPermission = createUserPermission;
    }

    public boolean isCreateMsgBoardPermission() {
        return createMsgBoardPermission;
    }

    public void setCreateMsgBoardPermission(boolean createMsgBoardPermission) {
        this.createMsgBoardPermission = createMsgBoardPermission;
    }

    public boolean isPostMsgPermission() {
        return postMsgPermission;
    }

    public void setPostMsgPermission(boolean postMsgPermission) {
        this.postMsgPermission = postMsgPermission;
    }
}
