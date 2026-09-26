package com.alzikrayat.controller;

import com.alzikrayat.dao.CommentDao;
import com.alzikrayat.model.Comment;
import com.alzikrayat.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/comment")
public class CommentServlet extends HttpServlet {

    private CommentDao commentDao;

    @Override
    public void init() {
        commentDao = new CommentDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // User must be logged in
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String photoIdParameter = request.getParameter("photoId");
        String commentText = request.getParameter("comment");

        // Validate input
        if (photoIdParameter == null || commentText == null
                || commentText.trim().isEmpty()) {

            response.sendRedirect("gallery");
            return;
        }

        try {

            int photoId = Integer.parseInt(photoIdParameter);

            // Server-side validation
            if (photoId <= 0) {
                response.sendRedirect("gallery");
                return;
            }

            commentText = commentText.trim();

            // Maximum comment length
            if (commentText.length() > 1000) {
                response.sendRedirect(
                        request.getContextPath()
                                + "/photo/"
                                + photoId
                                + "?error=comment"
                );
                return;
            }

            Comment comment = new Comment();

            comment.setPhotoId(photoId);
            comment.setUserId(user.getId());
            comment.setComment(commentText);

            boolean isSaved = commentDao.addComment(comment);

            if (isSaved) {

                // Use the required manual route: /photo/{id}
                response.sendRedirect(
                        request.getContextPath()
                                + "/photo/"
                                + photoId
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                                + "/photo/"
                                + photoId
                                + "?error=1"
                );
            }

        } catch (NumberFormatException e) {

            response.sendRedirect("gallery");
        }
    }
}