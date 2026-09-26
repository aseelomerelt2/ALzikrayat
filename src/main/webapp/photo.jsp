<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.alzikrayat.model.*,java.util.List,com.alzikrayat.util.HtmlUtil" %>

<%
    Photo photo = (Photo) request.getAttribute("photo");
    List<Comment> comments = (List<Comment>) request.getAttribute("comments");
    User user = (User) session.getAttribute("user");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Photo Details - Alzikrayat</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/big-photo.css">
</head>

<body>

<nav class="navbar">
    <div class="container">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home">Alzikrayat</a>

        <div>
            <a href="<%=request.getContextPath()%>/home">Home</a>
            <a class="ms-3" href="<%=request.getContextPath()%>/gallery">Gallery</a>
            <a class="ms-3" href="<%=request.getContextPath()%>/create.jsp">Upload</a>

            <span class="dropdown ms-3">
                <a data-bs-toggle="dropdown">✦</a>
                <span class="dropdown-menu">
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/home">Home</a>
                    <a class="dropdown-item" href="<%=request.getContextPath()%>/logout">Logout</a>
                </span>
            </span>
        </div>
    </div>
</nav>

<div class="container py-5">

<% if (photo != null) { %>

    <div class="photo-card">
        <img src="<%=request.getContextPath()%>/image?file=<%=HtmlUtil.escape(photo.getFileName())%>"
             alt="<%=HtmlUtil.escape(photo.getTitle())%>">

        <h1><%=HtmlUtil.escape(photo.getTitle())%></h1>
        <p><%=HtmlUtil.escape(photo.getDescription())%></p>
        <small>Shared on: <%=photo.getDateTime()%></small>

        <% if (user != null && user.getId() == photo.getUserId()) { %>
            <form action="<%=request.getContextPath()%>/delete-photo" method="post"
                  onsubmit="return confirm('Delete this photo?')">
                <input type="hidden" name="photoId" value="<%=photo.getId()%>">
                <button class="btn btn-outline-danger mt-3">Delete Photo</button>
            </form>
        <% } %>
    </div>

    <div class="comments">
        <h2>Comments</h2>

        <% if (comments != null) {
            for (Comment comment : comments) { %>

            <div class="comment">
                <strong><%=HtmlUtil.escape(comment.getUserName())%></strong>
                <small><%=comment.getDateTime()%></small>
                <p><%=HtmlUtil.escape(comment.getComment())%></p>
            </div>

        <% }} %>

        <% if (user != null) { %>
            <form action="<%=request.getContextPath()%>/comment" method="post">
                <input type="hidden" name="photoId" value="<%=photo.getId()%>">

                <textarea name="comment" class="form-control my-3"
                          maxlength="1000" required
                          placeholder="Leave a little note..."></textarea>

                <button class="btn add-btn">Add Comment</button>
            </form>
        <% } %>
    </div>

<% } else { %>

    <h2>Photo not found.</h2>

<% } %>

</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>