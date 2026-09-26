package com.alzikrayat.controller;

import com.alzikrayat.dao.UserDao;
import com.alzikrayat.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Date;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDao userDao;

    @Override
    public void init() {
        userDao = new UserDao();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Server-side validation
        if (email == null || email.trim().isEmpty()
                || password == null || password.isEmpty()) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=1"
            );
            return;
        }

        email = email.trim();

        User user = userDao.loginUser(email, password);

        if (user != null) {

            // Create user session after successful login
            HttpSession session = request.getSession();
            session.setAttribute("user", user);

            // Store the last successful login time in a cookie
            Cookie lastLoginCookie = new Cookie(
                    "lastLogin",
                    String.valueOf(new Date().getTime())
            );

            // Cookie expires after 7 days
            lastLoginCookie.setMaxAge(7 * 24 * 60 * 60);
            lastLoginCookie.setPath("/");

            response.addCookie(lastLoginCookie);

            // Go through HomeServlet so homepage statistics are loaded
            response.sendRedirect(
                    request.getContextPath() + "/home"
            );

        } else {

            // Return to login page if credentials are incorrect
            response.sendRedirect(
                    request.getContextPath() + "/login.jsp?error=1"
            );
        }
    }
}