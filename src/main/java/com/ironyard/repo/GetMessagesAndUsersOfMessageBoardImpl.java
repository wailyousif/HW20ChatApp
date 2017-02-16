package com.ironyard.repo;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.List;

/**
 * Created by wailm.yousif on 2/12/17.
 */
public class GetMessagesAndUsersOfMessageBoardImpl implements GetMessagesAndUsersOfMessageBoardCustom
{
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<Object[]> getMessagesAndUsers(Long messageBoardId)
    {
        //String queryStr = "SELECT m.*, u.* FROM Chat_Message m, Chat_User u, Chat_User_Chat_Messages um where m.id = um.chat_messages_id and u.id = um.chat_user_id and m.id in (select chat_messages_id from message_board_chat_messages where message_board_id = :messageBoardId) order by m.id desc";
        //String queryStr = "SELECT m.id, m.message_text, m.post_time, u.display_name FROM ChatMessage m, ChatUser u, ChatUserChatMessages um where m.id = um.chat_messages_id and u.id = um.chat_user_id and m.id in (select chat_messages_id from message_board_chat_messages where message_board_id = :messageBoardId) order by m.id desc";

        /*
        String queryStr = "SELECT m.id, m.message_text, to_char(m.post_time,'MM-DD-YYYY HH24:MI:SS'), u.display_name " +
                "FROM Chat_Message m, Chat_User u, Chat_User_Chat_Messages um where " +
                "m.id = um.chat_messages_id and u.id = um.chat_user_id and m.id in " +
                    "(select chat_messages_id from message_board_chat_messages where " +
                    "message_board_id = :messageBoardId) " +
                "order by m.id desc";
                */
        //Query query = entityManager.createQuery(queryStr);

        String queryStr = "SELECT m.id, m.message_text, " +
                "to_char(m.post_time,'MM-DD-YYYY HH24:MI:SS'), u.display_name, " +
                "u.small_photo_file, m.pic_file_name " +
                "FROM Chat_Message m, Chat_User u where " +
                "m.chat_user_id = u.id and m.id in " +
                "(select chat_messages_id from message_board_chat_messages where " +
                "message_board_id = :messageBoardId) --#pageable";
                //"order by m.id desc";

        Query query = entityManager.createNativeQuery(queryStr);

        query.setParameter("messageBoardId", messageBoardId);
        return query.getResultList();
    }
}
