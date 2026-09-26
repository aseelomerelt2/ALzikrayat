package com.alzikrayat.controller;

import com.alzikrayat.dao.CommentDao;
import com.alzikrayat.dao.PhotoDao;
import com.alzikrayat.dao.UserDao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    private UserDao userDao;
    private PhotoDao photoDao;
    private CommentDao commentDao;

    @Override
    public void init() {

        userDao = new UserDao();
        photoDao = new PhotoDao();
        commentDao = new CommentDao();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        int userCount = userDao.getUserCount();
        int photoCount = photoDao.getPhotoCount();
        int commentCount = commentDao.getCommentCount();

        request.setAttribute("userCount", userCount);
        request.setAttribute("photoCount", photoCount);
        request.setAttribute("commentCount", commentCount);

        request.getRequestDispatcher("/index.jsp")
                .forward(request, response);
    }
}