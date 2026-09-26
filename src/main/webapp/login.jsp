<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Alzikrayat</title>

    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f8f5fb;
            color: #59446f;
        }

        .navbar {
            background: #eee8f6;
            padding: 18px 8%;
        }

        .navbar a {
            color: #59446f;
            text-decoration: none;
            font-weight: bold;
            margin-right: 25px;
        }

        .login-card {
            max-width: 430px;
            margin: 70px auto;
            background: #eee8f6;
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 8px 25px #ddd2eb;
        }

        h1 {
            text-align: center;
            margin-bottom: 8px;
        }

        .subtitle {
            text-align: center;
            color: #81798c;
            margin-bottom: 30px;
        }

        label {
            display: block;
            font-weight: bold;
            margin: 15px 0 7px;
        }

        input {
            width: 100%;
            box-sizing: border-box;
            padding: 12px;
            border: 1px solid #ddd2eb;
            border-radius: 12px;
        }

        button {
            width: 100%;
            margin-top: 25px;
            padding: 12px;
            border: 0;
            border-radius: 12px;
            background: #8064a2;
            color: white;
            font-weight: bold;
            cursor: pointer;
        }

        button:hover {
            background: #fff1b8;
            color: #59446f;
        }

        .message {
            background: #fff1b8;
            padding: 12px;
            border-radius: 10px;
            font-size: 14px;
        }

        .error {
            color: #a04444;
            text-align: center;
        }

        .account {
            text-align: center;
            margin-top: 20px;
        }

        .account a {
            color: #8064a2;
            font-weight: bold;
        }
    </style>
</head>

<body>

<div class="navbar">
    <a href="<%=request.getContextPath()%>/home">✦ Alzikrayat</a>
    <a href="<%=request.getContextPath()%>/gallery">Gallery</a>
</div>

<div class="login-card">

    <h1>Welcome Back ✦</h1>
    <p class="subtitle">Sign in to continue your memories.</p>

    <%
        String lastLogin = null;

        if (request.getCookies() != null) {
            for (Cookie cookie : request.getCookies()) {
                if ("lastLogin".equals(cookie.getName())) {
                    lastLogin = cookie.getValue();
                    break;
                }
            }
        }
    %>

    <% if (lastLogin != null) { %>
        <p class="message">
            Last login from this computer was
            <%= new java.util.Date(Long.parseLong(lastLogin)) %>
        </p>
    <% } %>

    <% if (request.getParameter("error") != null) { %>
        <p class="error">Invalid email or password.</p>
    <% } %>

    <form action="<%=request.getContextPath()%>/login" method="post">

        <label for="email">Email</label>
        <input type="email" id="email" name="email" required>

        <label for="password">Password</label>
        <input type="password" id="password" name="password" required>

        <button type="submit">Login</button>

    </form>

    <p class="account">
        Don't have an account?
        <a href="<%=request.getContextPath()%>/register.jsp">Create Account</a>
    </p>

</div>

</body>
</html>