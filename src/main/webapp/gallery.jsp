<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.alzikrayat.model.Photo" %>
<%@ page import="com.alzikrayat.util.HtmlUtil" %>

<%
    List<Photo> photos = (List<Photo>) request.getAttribute("photos");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Photo Gallery - Alzikrayat</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>
        :root {
            --bg: #f8f5fb;
            --purple-light: #eee8f6;
            --purple: #ddd2eb;
            --purple-dark: #8064a2;
            --text: #59446f;
            --yellow: #fff1b8;
            --yellow-text: #8a6d1d;
        }

        body {
            background: var(--bg);
            color: var(--text);
            font-family: Arial, sans-serif;
        }

        .container-gallery {
            max-width: 1200px;
            margin: auto;
            padding: 35px 20px;
        }

        .hero, .card {
            background: linear-gradient(135deg, #e6dcf1, #f1ebf7);
            border-radius: 22px;
            box-shadow: 0 6px 20px rgba(89,68,111,.10);
        }

        .hero {
            text-align: center;
            padding: 35px 20px;
            margin-bottom: 25px;
        }

        .hero h1, .card h3 {
            color: var(--text);
            font-weight: 700;
        }

        .hero p, .card p {
            color: #756587;
        }

        .styles {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 25px;
        }

        .styles button, .bottom a, .slider-buttons button {
            border: 0;
            border-radius: 12px;
            padding: 10px 17px;
            background: var(--purple);
            color: var(--text);
            font-weight: 600;
            text-decoration: none;
            transition: .2s;
        }

        .styles button:hover,
        .styles button.active,
        .bottom a:hover,
        .slider-buttons button:hover {
            background: var(--yellow);
            color: var(--yellow-text);
            transform: translateY(-2px);
        }

        .view {
            display: none;
        }

        .view.active {
            display: block;
        }

        .grid-3, .grid-4 {
            display: grid;
            gap: 20px;
        }

        .grid-3 {
            grid-template-columns: repeat(3, 1fr);
        }

        .grid-4 {
            grid-template-columns: repeat(4, 1fr);
        }

        .card {
            overflow: hidden;
            transition: .2s;
        }

        .card:hover {
            transform: translateY(-4px);
        }

        .card a {
            display: block;
            text-decoration: none;
        }

        .card img {
            display: block;
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .card-content {
            padding: 16px;
        }

        .card-content h3 {
            font-size: 1.1rem;
            margin-bottom: 7px;
        }

        .card-content p {
            margin-bottom: 6px;
        }

        .date {
            color: #8b7b99;
            font-size: .8rem;
        }

        .list {
            display: flex;
            flex-direction: column;
            gap: 18px;
        }

        .list .card {
            display: flex;
        }

        .list .card img {
            width: 220px;
            height: 170px;
        }

        .slider-card {
            display: none;
            overflow: hidden;
            border-radius: 22px;
            background: var(--purple-light);
            box-shadow: 0 6px 20px rgba(89,68,111,.10);
        }

        .slider-card.active {
            display: block;
        }

        .slider-card a {
            display: block;
        }

        .slider-card img {
            display: block;
            width: 100%;
            height: 480px;
            object-fit: cover;
        }

        .slider-content {
            padding: 18px;
            text-align: center;
        }

        .slider-buttons {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 15px;
        }

        .bottom {
            display: flex;
            justify-content: center;
            gap: 12px;
            margin-top: 30px;
        }

        .back {
            background: var(--purple-dark) !important;
            color: white !important;
        }

        .back:hover {
            background: var(--yellow) !important;
            color: var(--yellow-text) !important;
        }

        .empty {
            padding: 45px 20px;
            text-align: center;
        }

        @media (max-width: 900px) {
            .grid-3, .grid-4 {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 600px) {
            .grid-3, .grid-4 {
                grid-template-columns: 1fr;
            }

            .list .card {
                display: block;
            }

            .list .card img {
                width: 100%;
                height: 220px;
            }

            .slider-card img {
                height: 300px;
            }

            .styles button {
                width: 100%;
            }

            .bottom {
                flex-direction: column;
            }

            .bottom a {
                text-align: center;
            }
        }
    </style>
</head>

<body>

<div class="container-gallery">

    <div class="hero">
        <h1>✦ Photo Gallery</h1>
        <p>Explore beautiful memories shared on Alzikrayat.</p>
    </div>

    <% if (photos == null || photos.isEmpty()) { %>

        <div class="hero empty">
            <h3>No photos uploaded yet</h3>
            <p>Start creating memories by uploading your first photo.</p>
        </div>

    <% } else { %>

        <div class="styles">
            <button class="active" onclick="showView('three', this)">3 Columns</button>
            <button onclick="showView('four', this)">4 Columns</button>
            <button onclick="showView('list', this)">List Cards</button>
            <button onclick="showView('slider', this)">Full Slider</button>
        </div>

        <!-- 3 Columns -->
        <div id="three" class="view active">
            <div class="grid-3">
                <% for (Photo photo : photos) { %>
                    <div class="card">
                        <a href="<%= request.getContextPath() %>/photo/<%= photo.getId() %>">
                            <img src="<%= request.getContextPath() %>/image?file=<%= HtmlUtil.escape(photo.getFileName()) %>"
                                 alt="<%= HtmlUtil.escape(photo.getTitle()) %>">
                        </a>

                        <div class="card-content">
                            <h3><%= HtmlUtil.escape(photo.getTitle()) %></h3>
                            <p><%= HtmlUtil.escape(photo.getDescription()) %></p>
                            <div class="date">
                                <%= HtmlUtil.escape(String.valueOf(photo.getDateTime())) %>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- 4 Columns -->
        <div id="four" class="view">
            <div class="grid-4">
                <% for (Photo photo : photos) { %>
                    <div class="card">
                        <a href="<%= request.getContextPath() %>/photo/<%= photo.getId() %>">
                            <img src="<%= request.getContextPath() %>/image?file=<%= HtmlUtil.escape(photo.getFileName()) %>"
                                 alt="<%= HtmlUtil.escape(photo.getTitle()) %>">
                        </a>

                        <div class="card-content">
                            <h3><%= HtmlUtil.escape(photo.getTitle()) %></h3>
                            <p><%= HtmlUtil.escape(photo.getDescription()) %></p>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- List Cards -->
        <div id="list" class="view">
            <div class="list">
                <% for (Photo photo : photos) { %>
                    <div class="card">
                        <a href="<%= request.getContextPath() %>/photo/<%= photo.getId() %>">
                            <img src="<%= request.getContextPath() %>/image?file=<%= HtmlUtil.escape(photo.getFileName()) %>"
                                 alt="<%= HtmlUtil.escape(photo.getTitle()) %>">
                        </a>

                        <div class="card-content">
                            <h3><%= HtmlUtil.escape(photo.getTitle()) %></h3>
                            <p><%= HtmlUtil.escape(photo.getDescription()) %></p>
                            <div class="date">
                                <%= HtmlUtil.escape(String.valueOf(photo.getDateTime())) %>
                            </div>
                        </div>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Full Slider -->
        <div id="slider" class="view">
            <% for (int i = 0; i < photos.size(); i++) {
                Photo photo = photos.get(i);
            %>
                <div class="slider-card <%= i == 0 ? "active" : "" %>">

                    <a href="<%= request.getContextPath() %>/photo/<%= photo.getId() %>">
                        <img src="<%= request.getContextPath() %>/image?file=<%= HtmlUtil.escape(photo.getFileName()) %>"
                             alt="<%= HtmlUtil.escape(photo.getTitle()) %>">
                    </a>

                    <div class="slider-content">
                        <h3><%= HtmlUtil.escape(photo.getTitle()) %></h3>
                        <p><%= HtmlUtil.escape(photo.getDescription()) %></p>
                    </div>
                </div>
            <% } %>

            <div class="slider-buttons">
                <button onclick="slide(-1)">← Previous</button>
                <button onclick="slide(1)">Next →</button>
            </div>
        </div>

    <% } %>

    <div class="bottom">
        <a href="<%= request.getContextPath() %>/create.jsp">
            ＋ Upload New Photo
        </a>

        <a class="back" href="<%= request.getContextPath() %>/index.jsp">
            ← Back to Home
        </a>
    </div>

</div>

<script>
    function showView(id, button) {
        document.querySelectorAll('.view')
            .forEach(v => v.classList.remove('active'));

        document.getElementById(id).classList.add('active');

        document.querySelectorAll('.styles button')
            .forEach(b => b.classList.remove('active'));

        button.classList.add('active');
    }

    let current = 0;

    function slide(direction) {
        const slides = document.querySelectorAll('.slider-card');

        if (!slides.length) return;

        slides[current].classList.remove('active');

        current = (current + direction + slides.length) % slides.length;

        slides[current].classList.add('active');
    }
</script>

</body>
</html>