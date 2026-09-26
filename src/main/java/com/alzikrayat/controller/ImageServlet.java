package com.alzikrayat.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.OutputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

@WebServlet("/image")
public class ImageServlet extends HttpServlet {

    private static final String UPLOAD_DIRECTORY =
            "C:\\apache-tomcat-11.0.26-windows-x64\\apache-tomcat-11.0.26\\alzikrayat-uploads";

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String fileName = request.getParameter("file");

        if (fileName == null || fileName.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        fileName = fileName.trim();

        // Prevent path traversal
        if (fileName.contains("..")
                || fileName.contains("/")
                || fileName.contains("\\")) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }

        Path filePath = Paths.get(UPLOAD_DIRECTORY, fileName);

        if (!Files.exists(filePath) || !Files.isRegularFile(filePath)) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }

        String contentType = getServletContext()
                .getMimeType(filePath.getFileName().toString());

        if (contentType == null) {
            contentType = "application/octet-stream";
        }

        response.setContentType(contentType);
        response.setContentLengthLong(Files.size(filePath));

        try (OutputStream outputStream = response.getOutputStream()) {
            Files.copy(filePath, outputStream);
        }
    }
}