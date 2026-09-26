package com.alzikrayat.controller;

import com.alzikrayat.dao.CommentDao;
import com.alzikrayat.dao.PhotoDao;
import com.alzikrayat.model.Comment;
import com.alzikrayat.model.Photo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/photo-details")public class PhotoDetailsServlet extends HttpServlet {

    private PhotoDao photoDao;
    private CommentDao commentDao;

    @Override
    public void init() {
        photoDao = new PhotoDao();
        commentDao = new CommentDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParameter = (String) request.getAttribute("photoId");
        if (idParameter == null) {
            response.sendRedirect("gallery");
            return;
        }

        try {
            int photoId = Integer.parseInt(idParameter);

            Photo photo = photoDao.getPhotoById(photoId);

            if (photo == null) {
                response.sendRedirect("gallery");
                return;
            }

            // Get comments for this photo
            List<Comment> comments = commentDao.getCommentsByPhotoId(photoId);

            request.setAttribute("photo", photo);
            request.setAttribute("comments", comments);

            request.getRequestDispatcher("photo.jsp")
                    .forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("gallery");
        }
    }
}