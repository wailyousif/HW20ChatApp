package com.ironyard.repo;

import com.ironyard.data.ChatUser;
import org.springframework.data.repository.CrudRepository;

/**
 * Created by wailm.yousif on 2/9/17.
 */
public interface ChatUserRepo extends CrudRepository<ChatUser, Long> {
    public ChatUser findByUsernameAndPassword(String username, String password);
}
