package com.ironyard.repo;

import com.ironyard.data.ChatMessage;
import com.ironyard.data.MessageBoard;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.repository.PagingAndSortingRepository;

/**
 * Created by wailm.yousif on 2/9/17.
 */
public interface ChatMessageRepo extends PagingAndSortingRepository<ChatMessage, Long> {
    public Page<ChatMessage> findByMessageBoard(MessageBoard messageBoard, Pageable pageable);
}
