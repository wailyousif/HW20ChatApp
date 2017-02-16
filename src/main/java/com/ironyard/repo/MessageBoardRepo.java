package com.ironyard.repo;

import com.ironyard.data.MessageBoard;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * Created by wailm.yousif on 2/9/17.
 */
public interface MessageBoardRepo extends CrudRepository<MessageBoard, Long> {

    @Query(value = "SELECT m.* FROM Message_Board m order by id desc", nativeQuery = true)
    public Iterable<MessageBoard> getAllMessageBoardsInDescOrder();

}
