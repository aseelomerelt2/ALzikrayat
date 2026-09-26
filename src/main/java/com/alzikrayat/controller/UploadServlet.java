package com.alzikrayat.controller;

import com.alzikrayat.dao.PhotoDao;
import com.alzikrayat.model.Photo;
import com.alzikrayat.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

@WebServlet("/upload")
@MultipartConfig(
        maxFileSize = 5 * 1024 * 1024,
        maxRequestSize = 30 * 1024 * 1024
)
public class UploadServlet extends HttpServlet {

    private PhotoDao photoDao;

    // External folder for uploaded images
    private static final String UPLOAD_DIRECTORY =
            "C:\\apache-tomcat-11.0.26-windows-x64\\apache-tomcat-11.0.26\\alzikrayat-uploads";

    private static final long MAX_FILE_SIZE = 5 * 1024 * 1024;

    @Override
    public void init() {
        photoDao = new PhotoDao();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // User must be logged in
        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");

        // Read and clean text fields
        String title = request.getParameter("title");
        String description = request.getParameter("description");

        if (title == null) {
            response.sendRedirect("create.jsp?error=title");
            return;
        }

        title = title.trim();

        if (description == null) {
            description = "";
        } else {
            description = description.trim();
        }

        // Server-side title validation
        if (title.isEmpty() || title.length() > 200) {
            response.sendRedirect("create.jsp?error=title");
            return;
        }

        // Server-side description validation
        if (description.length() > 5000) {
            response.sendRedirect("create.jsp?error=description");
            return;
        }

        // Create upload directory if it does not exist
        Path uploadPath = Paths.get(UPLOAD_DIRECTORY);
        Files.createDirectories(uploadPath);

        boolean atLeastOneUploaded = false;

        try {

            /*
             * Get all uploaded files.
             * This allows the user to upload multiple photos.
             */
            for (Part photoPart : request.getParts()) {

                if (!"photo".equals(photoPart.getName())) {
                    continue;
                }

                // Ignore empty file fields
                if (photoPart.getSize() == 0) {
                    continue;
                }

                // Server-side file size validation
                if (photoPart.getSize() > MAX_FILE_SIZE) {
                    response.sendRedirect("create.jsp?error=size");
                    return;
                }

                String originalFileName = photoPart.getSubmittedFileName();

                if (originalFileName == null || originalFileName.trim().isEmpty()) {
                    continue;
                }

                /*
                 * Extract only the file name.
                 * This prevents path traversal through the original filename.
                 */
                String fileName = Paths.get(originalFileName)
                        .getFileName()
                        .toString();

                String extension = "";

                int dotIndex = fileName.lastIndexOf(".");

                if (dotIndex >= 0) {
                    extension = fileName.substring(dotIndex).toLowerCase();
                }

                // Allowed image extensions
                if (!extension.equals(".jpg")
                        && !extension.equals(".jpeg")
                        && !extension.equals(".png")
                        && !extension.equals(".gif")) {

                    response.sendRedirect("create.jsp?error=type");
                    return;
                }

                /*
                 * Check the uploaded content type as an additional
                 * server-side validation layer.
                 */
                String contentType = photoPart.getContentType();

                if (contentType == null || !contentType.startsWith("image/")) {
                    response.sendRedirect("create.jsp?error=type");
                    return;
                }

                // Generate a unique filename
                String uniqueFileName =
                        UUID.randomUUID() + extension;

                Path filePath = uploadPath.resolve(uniqueFileName);

                // Save physical image file
                photoPart.write(filePath.toString());

                // Prepare database record
                Photo photo = new Photo();

                photo.setUserId(user.getId());
                photo.setFileName(uniqueFileName);
                photo.setTitle(title);
                photo.setDescription(description);

                // Save metadata to database
                boolean isSaved = photoDao.addPhoto(photo);

                if (!isSaved) {

                    // Remove physical file if DB insertion fails
                    Files.deleteIfExists(filePath);

                    response.sendRedirect("create.jsp?error=database");
                    return;
                }

                atLeastOneUploaded = true;
            }

        } catch (IllegalStateException e) {

            // Handles request/file size problems
            response.sendRedirect("create.jsp?error=size");
            return;
        }

        // At least one valid photo must be uploaded
        if (!atLeastOneUploaded) {
            response.sendRedirect("create.jsp?error=file");
            return;
        }

        // Upload completed successfully
        response.sendRedirect("gallery");
    }
}