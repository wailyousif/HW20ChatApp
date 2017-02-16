package com.ironyard.controller;

import com.ironyard.data.ChatMessage;
import com.ironyard.data.ChatUser;
import com.ironyard.data.MessageBoard;
import com.ironyard.repo.ChatMessageRepo;
import com.ironyard.repo.ChatUserRepo;
import com.ironyard.repo.GetMessagesAndUsersOfMessageBoard;
import com.ironyard.repo.MessageBoardRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Date;

/**
 * Created by wailm.yousif on 2/12/17.
 */

@Controller
@RequestMapping(path = "/secure/chatmsgs")
public class ChatMessagesController
{
    @Autowired
    private ChatMessageRepo chatMessageRepo;

    @Autowired
    private GetMessagesAndUsersOfMessageBoard getMessagesAndUsersOfMessageBoard;

    @Autowired
    private MessageBoardRepo messageBoardRepo;

    @Autowired
    private ChatUserRepo chatUserRepo;

    @Value("${upload.location}")
    private String uploadLocation;


    @RequestMapping(path = "/show", method = RequestMethod.GET)
    @Transactional
    public String show(Model dataModel, Long msgBoardId, String msgBoardName,
                       @RequestParam(value = "page", required = false) Integer page,
                       @RequestParam(value = "pageSize", required = false) Integer pageSize,
                       @RequestParam(value = "sortBy", required = false) Integer sortBy
                       )
    {

        if (page == null) {
            System.out.println("page = null");
            page = 0;
        }
        if (pageSize == null) {
            System.out.println("pageSize = null");
            pageSize = 2;
        }
        if (sortBy == null) {
            System.out.println("sortBy = null");
            sortBy = 1;
        }

        System.out.println(page + "-" + pageSize + "-" + sortBy);

        Sort sort;
        Sort.Order order1 = new Sort.Order(Sort.Direction.DESC, "postTime");
        Sort.Order order2 = new Sort.Order(Sort.Direction.ASC, "chatUser.username");
        if (sortBy == 1)
        {
            sort = new Sort(order1, order2);    //sort by time desc, user asc
        }
        else
        {
            sort = new Sort(order2, order1);    //sort by user asc, time desc
        }


        PageRequest pr = new PageRequest(page, pageSize, sort);

        MessageBoard messageBoard = messageBoardRepo.findOne(msgBoardId);
        Page<ChatMessage> listOfChatMsgs = chatMessageRepo.findByMessageBoard(messageBoard, pr);

        dataModel.addAttribute("listOfChatMsgs", listOfChatMsgs);
        dataModel.addAttribute("msgBoardId", msgBoardId);
        dataModel.addAttribute("msgBoardName", msgBoardName);
        dataModel.addAttribute("pageSizeVal", pageSize);
        dataModel.addAttribute("sortByVal", sortBy);
        dataModel.addAttribute("pageSizeOpts", getPageSizeOptions(pageSize));
        dataModel.addAttribute("sortByOpts", getSortByOptions(sortBy));

        return "/secure/chatmessages";
    }


    private String getPageSizeOptions(Integer pageSize)
    {
        String options = "";
        for (int i=2; i < 7; i+=2)
        {
            options = options + "<option value=\"" + String.valueOf(i) + "\" ";
            if (i == pageSize)
                options = options + "selected";
            options = options + ">" + String.valueOf(i) + "</option>";
        }
        return options;
    }


    private String getSortByOptions(Integer sortBy)
    {
        String[] optsValues = {"Time (Desc)", "Users (Asc)"};
        String options = "";
        for (int i=1; i < 3; i++)
        {
            options = options + "<option value=\"" + String.valueOf(i) + "\" ";
            if (i == sortBy)
                options = options + "selected";
            options = options + ">" + optsValues[i-1] + "</option>";
        }
        return options;
    }


    @RequestMapping(path = "/addwpic", method = RequestMethod.POST)
    public String addWithPic(HttpServletRequest request, Long msgBoardId, String msgText,
                      @RequestParam("msgPic") MultipartFile msgPic) throws IOException
    {
        System.out.println("Adding message with pic...");

        String msgPicFileName = String.valueOf(System.currentTimeMillis()) +
                "_" + msgPic.getOriginalFilename();
        saveMessage(request, msgBoardId, msgText, msgPicFileName);
        Files.copy(msgPic.getInputStream(), Paths.get(uploadLocation + msgPicFileName));

        return "redirect:/secure/chatmsgs/show?msgBoardId=" + msgBoardId;
    }


    @RequestMapping(path = "/addwopic", method = RequestMethod.POST)
    public String addWithoutPic(HttpServletRequest request, Long msgBoardId, String msgText) throws IOException
    {
        System.out.println("Adding message w/o pic...");
        saveMessage(request, msgBoardId, msgText, "");
        return "redirect:/secure/chatmsgs/show?msgBoardId=" + msgBoardId;
    }


    private int saveMessage(HttpServletRequest request, Long msgBoardId, String msgText,
                            String msgPicFileName)
    {
        ChatUser currentChatUser = (ChatUser)request.getSession().getAttribute("chatUser");
        ChatMessage chatMessage = new ChatMessage(msgText, (new Date()), currentChatUser, msgPicFileName);
        MessageBoard messageBoard = messageBoardRepo.findOne(msgBoardId);
        (messageBoard.getChatMessages()).add(chatMessage);
        chatMessage.setMessageBoard(messageBoard);
        messageBoardRepo.save(messageBoard);

        return 0;   //assuming it always works
    }
}
