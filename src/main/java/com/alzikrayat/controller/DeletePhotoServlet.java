package com.alzikrayat.controller;

import com.alzikrayat.dao.PhotoDao;
import com.alzikrayat.model.Photo;
import com.alzikrayat.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/delete-photo")
public class DeletePhotoServlet extends HttpServlet {

    private PhotoDao photoDao;

    private static final String UPLOAD_DIRECTORY =
            "C:\\apache-tomcat-11.0.26-windows-x64\\apache-tomcat-11.0.26\\alzikrayat-uploads";

    @Override
    public void init() {
        photoDao = new PhotoDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        String photoIdParameter = request.getParameter("photoId");

        if (photoIdParameter == null || photoIdParameter.trim().isEmpty()) {
            response.sendRedirect("gallery");
            return;
        }

        try {
            int photoId = Integer.parseInt(photoIdParameter);

            Photo photo = photoDao.getPhotoById(photoId);

            if (photo == null) {
                response.sendRedirect("gallery");
                return;
            }

            if (photo.getUserId() != user.getId()) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN);
                return;
            }

            boolean isDeleted = photoDao.deletePhoto(photoId, user.getId());

            if (isDeleted) {

                Path imagePath = Paths.get(
                        UPLOAD_DIRECTORY,
                        photo.getFileName()
                );

                Files.deleteIfExists(imagePath);

                response.sendRedirect("gallery");

            } else {
                response.sendRedirect("photo?id=" + photoId + "&error=delete");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("gallery");
        }
    }
}