package com.ironyard.repo;

import java.util.List;

/**
 * Created by wailm.yousif on 2/12/17.
 */
public interface GetMessagesAndUsersOfMessageBoardCustom {
    public List<Object[]> getMessagesAndUsers(Long messageBoardId);
}

