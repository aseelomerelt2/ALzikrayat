<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - Alzikrayat</title>

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

        .register-card {
            max-width: 550px;
            margin: 50px auto;
            background: #eee8f6;
            padding: 40px;
            border-radius: 25px;
            box-shadow: 0 8px 25px #ddd2eb;
        }

        h1, .subtitle, .account {
            text-align: center;
        }

        .subtitle {
            color: #81798c;
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: bold;
            margin: 13px 0 6px;
        }

        input, textarea {
            width: 100%;
            box-sizing: border-box;
            padding: 11px;
            border: 1px solid #ddd2eb;
            border-radius: 12px;
        }

        textarea {
            height: 80px;
            resize: vertical;
        }

        .password-box {
            position: relative;
        }

        .password-box input {
            padding-right: 45px;
        }

        .eye {
            position: absolute;
            right: 12px;
            top: 8px;
            border: 0;
            background: transparent;
            cursor: pointer;
            font-size: 18px;
        }

        .register-btn {
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

        .register-btn:hover {
            background: #fff1b8;
            color: #59446f;
        }

        .error {
            background: #fff1b8;
            color: #8a5a44;
            padding: 10px;
            border-radius: 10px;
            text-align: center;
        }

        .account a {
            color: #8064a2;
            font-weight: bold;
        }
    </style>

    <script>
        function togglePassword() {
            const password = document.getElementById("password");
            password.type = password.type === "password" ? "text" : "password";
        }
    </script>
</head>

<body>

<div class="navbar">
    <a href="<%=request.getContextPath()%>/home">✦ Alzikrayat</a>
    <a href="<%=request.getContextPath()%>/gallery">Gallery</a>
</div>

<div class="register-card">

    <h1>Create Account ✦</h1>
    <p class="subtitle">Create a space for your memories.</p>

    <%
        String error = request.getParameter("error");
        String message = null;

        if ("validation".equals(error)) message = "Please fill in all required fields.";
        else if ("firstName".equals(error)) message = "First name must contain letters only and be no more than 50 characters.";
        else if ("lastName".equals(error)) message = "Last name must contain letters only and be no more than 50 characters.";
        else if ("email".equals(error)) message = "Please enter a valid email address.";
        else if ("password".equals(error)) message = "Password must be between 8 and 100 characters.";
        else if ("location".equals(error)) message = "Location must be no more than 100 characters.";
        else if ("description".equals(error)) message = "Description is too long.";
        else if ("occupation".equals(error)) message = "Occupation must be no more than 100 characters.";
        else if ("1".equals(error)) message = "Registration failed. The email may already be registered.";
    %>

    <% if (message != null) { %>
        <p class="error"><%= message %></p>
    <% } %>

    <form action="<%=request.getContextPath()%>/register" method="post">

        <label for="firstName">First Name</label>
        <input type="text" id="firstName" name="firstName"
               maxlength="50" required>

        <label for="lastName">Last Name</label>
        <input type="text" id="lastName" name="lastName"
               maxlength="50" required>

        <label for="email">Email</label>
        <input type="email" id="email" name="email"
               maxlength="100" required>

        <label for="password">Password</label>
        <div class="password-box">
            <input type="password" id="password" name="password"
                   minlength="8" maxlength="100" required>
            <button class="eye" type="button"
                    onclick="togglePassword()">👁</button>
        </div>

        <label for="location">Location</label>
        <input type="text" id="location" name="location"
               maxlength="100">

        <label for="description">Description</label>
        <textarea id="description" name="description"
                  maxlength="5000"></textarea>

        <label for="occupation">Occupation</label>
        <input type="text" id="occupation" name="occupation"
               maxlength="100">

        <button class="register-btn" type="submit">Create Account</button>

    </form>

    <p class="account">
        Already have an account?
        <a href="<%=request.getContextPath()%>/login.jsp">Login</a>
    </p>

</div>

</body>
</html>