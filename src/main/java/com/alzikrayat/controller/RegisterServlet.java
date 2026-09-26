package com.alzikrayat.controller;

import com.alzikrayat.dao.UserDao;
import com.alzikrayat.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDao userDao;
    // Accept names using Arabic, English, and other Unicode letters
    private static final Pattern NAME_PATTERN =
            Pattern.compile("^[\\p{L}]+$");

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String location = request.getParameter("location");
        String description = request.getParameter("description");
        String occupation = request.getParameter("occupation");

        // Remove unnecessary spaces from user input
        if (firstName != null) firstName = firstName.trim();
        if (lastName != null) lastName = lastName.trim();
        if (email != null) email = email.trim();
        if (location != null) location = location.trim();
        if (description != null) description = description.trim();
        if (occupation != null) occupation = occupation.trim();

        // Required field validation
        if (firstName == null || firstName.isEmpty()
                || lastName == null || lastName.isEmpty()
                || email == null || email.isEmpty()
                || password == null || password.isEmpty()) {

            response.sendRedirect("register.jsp?error=validation");
            return;
        }

        // First name validation
        if (firstName.length() > 50
                || !NAME_PATTERN.matcher(firstName).matches()) {

            response.sendRedirect("register.jsp?error=firstName");
            return;
        }

        // Last name validation
        if (lastName.length() > 50
                || !NAME_PATTERN.matcher(lastName).matches()) {

            response.sendRedirect("register.jsp?error=lastName");
            return;
        }

        // Email validation
        if (email.length() > 100
                || !EMAIL_PATTERN.matcher(email).matches()) {

            response.sendRedirect("register.jsp?error=email");
            return;
        }

        // Password validation
        if (password.length() < 8 || password.length() > 100) {

            response.sendRedirect("register.jsp?error=password");
            return;
        }

        // Optional field length validation
        if (location != null && location.length() > 100) {
            response.sendRedirect("register.jsp?error=location");
            return;
        }

        if (description != null && description.length() > 5000) {
            response.sendRedirect("register.jsp?error=description");
            return;
        }

        if (occupation != null && occupation.length() > 100) {
            response.sendRedirect("register.jsp?error=occupation");
            return;
        }

        // Create user after successful validation
        User user = new User();

        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(password);
        user.setLocation(location);
        user.setDescription(description);
        user.setOccupation(occupation);

        boolean isRegistered = userDao.registerUser(user);

        if (isRegistered) {
            response.sendRedirect("login.jsp");
        } else {
            response.sendRedirect("register.jsp?error=1");
        }
    }
}