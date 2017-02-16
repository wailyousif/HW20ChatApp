package com.ironyard.repo;

import com.ironyard.data.ChatMessage;
import org.springframework.data.repository.CrudRepository;

import java.util.List;

/**
 * Created by wailm.yousif on 2/12/17.
 */
public interface GetMessagesAndUsersOfMessageBoard extends
        CrudRepository<ChatMessage, Long>, GetMessagesAndUsersOfMessageBoardCustom
{
    //Page<Object[]> getMessagesAndUsers(Long messageBoardId, org.springframework.data.domain.Pageable pageable);
    List<Object[]> getMessagesAndUsers(Long messageBoardId);
}
