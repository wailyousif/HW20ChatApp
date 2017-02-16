package com.ironyard.controller;

import com.ironyard.data.MessageBoard;
import com.ironyard.repo.MessageBoardRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;

/**
 * Created by wailm.yousif on 2/10/17.
 */

@Controller
@RequestMapping(path = "/secure/msgboards")
public class MessageBoardsController
{
    @Autowired
    MessageBoardRepo messageBoardRepo;

    @RequestMapping(path = "/show", method = RequestMethod.GET)
    public String show(Model dataModel)
    {
        System.out.println("show msg boards");
        Iterable<MessageBoard> messageBoards = messageBoardRepo.getAllMessageBoardsInDescOrder();
        dataModel.addAttribute("listOfMsgBoards", messageBoards);

        return "/secure/messageboards";
    }


    @RequestMapping(path = "/add", method = RequestMethod.POST)
    public String add(HttpServletRequest request, String msgBoardName)
    {
        System.out.println("add msg boards");
        System.out.println("msgBoardName=" + msgBoardName + "#");

        MessageBoard messageBoard = new MessageBoard(msgBoardName, new Date());
        messageBoardRepo.save(messageBoard);

        return "redirect:/secure/msgboards/show";
    }
}
