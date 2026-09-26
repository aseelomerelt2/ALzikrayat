package com.alzikrayat.controller;

import com.alzikrayat.dao.PhotoDao;
import com.alzikrayat.model.Photo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/gallery")
public class GalleryServlet extends HttpServlet {

    private PhotoDao photoDao;

    @Override
    public void init() {
        photoDao = new PhotoDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Photo> photos = photoDao.getAllPhotos();

        request.setAttribute("photos", photos);

        request.getRequestDispatcher("gallery.jsp")
                .forward(request, response);
    }
}