package com.alzikrayat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

@WebServlet("/photo/*")
public class RouterServlet extends HttpServlet {

    private static final Pattern PHOTO_ROUTE =
            Pattern.compile("^/(\\d+)$");

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        Matcher matcher = PHOTO_ROUTE.matcher(path);

        if (matcher.matches()) {

            String photoId = matcher.group(1);

            request.setAttribute("photoId", photoId);

            request.getRequestDispatcher("/photo-details")
                    .forward(request, response);

            return;
        }

        response.sendError(HttpServletResponse.SC_NOT_FOUND);
    }
}