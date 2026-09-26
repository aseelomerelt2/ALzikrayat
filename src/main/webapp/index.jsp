<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.alzikrayat.model.User" %>

<%
    User currentUser = (User) session.getAttribute("user");
    boolean loggedIn = currentUser != null;

    Object userCountObj = request.getAttribute("userCount");
    Object photoCountObj = request.getAttribute("photoCount");
    Object commentCountObj = request.getAttribute("commentCount");

    int userCount = userCountObj != null ? (Integer) userCountObj : 0;
    int photoCount = photoCountObj != null ? (Integer) photoCountObj : 0;
    int commentCount = commentCountObj != null ? (Integer) commentCountObj : 0;
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Alzikrayat — Share Your Moments</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&family=Playfair+Display:ital,wght@0,600;1,600&display=swap"
          rel="stylesheet">

    <!-- External stylesheet -->
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/css/style.css">

</head>

<body>

<!-- =========================
     NAVBAR
     ========================= -->

<nav class="navbar navbar-expand-lg">

    <div class="container-fluid p-0">

        <a class="brand"
           href="<%= request.getContextPath() %>/home">
            alzikrayat
            <span class="brand-star">✨</span>
        </a>

        <button class="navbar-toggler"
                type="button"
                data-bs-toggle="collapse"
                data-bs-target="#mainNav"
                aria-controls="mainNav"
                aria-expanded="false"
                aria-label="Toggle navigation">

            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="mainNav">

            <ul class="navbar-nav ms-auto align-items-lg-center">

                <li class="nav-item">
                    <a class="nav-link"
                       href="<%= request.getContextPath() %>/home">
                        Home
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link"
                       href="<%= request.getContextPath() %>/gallery">
                        Explore
                    </a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#about">
                        About
                    </a>
                </li>

                <% if (loggedIn) { %>

                    <li class="nav-item">
                        <a class="nav-link nav-btn-custom ms-lg-3"
                           href="<%= request.getContextPath() %>/create.jsp">
                            ＋ Share Memory
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/logout">
                            Logout
                        </a>
                    </li>

                <% } else { %>

                    <li class="nav-item">
                        <a class="nav-link"
                           href="<%= request.getContextPath() %>/login.jsp">
                            Login
                        </a>
                    </li>

                    <li class="nav-item">
                        <a class="nav-link nav-btn-custom ms-lg-3"
                           href="<%= request.getContextPath() %>/register.jsp">
                            Join Alzikrayat
                        </a>
                    </li>

                <% } %>

            </ul>

        </div>
    </div>

</nav>


<!-- =========================
     HERO
     ========================= -->

<section class="hero-section">

    <div class="hero-banner">

        <div class="hero-subtitle">
            ✦ Photo Sharing & Memories
        </div>

        <h1 class="hero-title">
            Alzikrayat
        </h1>

        <p class="hero-desc">
            مساحة بسيطة وجميلة لمشاركة الصور،
            توثيق اللحظات،
            واكتشاف الذكريات والقصص البصرية
            التي يشاركها الآخرون.
        </p>

        <div class="hero-buttons">

            <a href="<%= request.getContextPath() %>/gallery"
               class="hero-btn hero-btn-primary">
                Explore Gallery →
            </a>

            <% if (loggedIn) { %>

                <a href="<%= request.getContextPath() %>/create.jsp"
                   class="hero-btn hero-btn-secondary">
                    ＋ Share a Memory
                </a>

            <% } else { %>

                <a href="<%= request.getContextPath() %>/register.jsp"
                   class="hero-btn hero-btn-secondary">
                    Create Account
                </a>

            <% } %>

        </div>

        <span class="badge-yellow">
            ✨ Discover moments worth remembering
        </span>

    </div>

</section>


<!-- =========================
     REAL STATISTICS
     ========================= -->

<section class="stats-section">

    <div class="stats-container">

        <div class="stat-item">

            <div class="stat-number">
                <%= userCount %>
            </div>

            <div class="stat-label">
                Registered Users
            </div>

        </div>

        <div class="stat-item">

            <div class="stat-number">
                <%= photoCount %>
            </div>

            <div class="stat-label">
                Shared Photos
            </div>

        </div>

        <div class="stat-item">

            <div class="stat-number">
                <%= commentCount %>
            </div>

            <div class="stat-label">
                Comments
            </div>

        </div>

    </div>

</section>


<!-- =========================
     FEATURED MOMENTS
     ========================= -->

<section class="portfolio-section">

    <div class="section-header">

        <h2 class="section-title">
            Featured Moments
        </h2>

        <a href="<%= request.getContextPath() %>/gallery"
           class="section-link">
            View Full Gallery →
        </a>

    </div>

    <div class="portfolio-grid">


        <!-- FIRST PHOTO -->

        <div class="portfolio-card">

            <div class="card-img-wrapper">

                <img src="<%= request.getContextPath() %>/images/flowers.jpg"
                     alt="Flowers representing beauty in ordinary moments">

            </div>

            <span class="card-tag">
                Everyday Beauty
            </span>

            <h3 class="card-heading">
                Beauty in the Ordinary
            </h3>

            <p class="card-text">
                Small details can turn an ordinary moment
                into something worth remembering.
            </p>

        </div>


        <!-- SECOND PHOTO -->

        <div class="portfolio-card">

            <div class="card-img-wrapper">

                <img src="<%= request.getContextPath() %>/images/museum.jpg"
                     alt="Person viewing artwork in a gallery">

            </div>

            <span class="card-tag">
                Art & Creativity
            </span>

            <h3 class="card-heading">
                Moments of Inspiration
            </h3>

            <p class="card-text">
                Art, creativity and the moments
                that make us stop and look.
            </p>

        </div>


        <!-- THIRD PHOTO -->

        <div class="portfolio-card">

            <div class="card-img-wrapper">

                <img src="<%= request.getContextPath() %>/images/reading.jpg"
                     alt="Woman enjoying a quiet moment reading a book">

            </div>

            <span class="card-tag">
                Quiet Moments
            </span>

            <h3 class="card-heading">
                A Moment to Read
            </h3>

            <p class="card-text">
                A quiet place, a good book
                and a moment to simply enjoy.
            </p>

        </div>

    </div>

</section>


<!-- =========================
     ABOUT US
     ========================= -->

<section class="about-section" id="about">

    <div class="about-box">

        <h2>
            About Alzikrayat
        </h2>

      <p>
          Memories are the moments we never want time to carry away;
          they are the fragrance of the past and the warmth of the present.
          <br><br>
          Here is your space to preserve the moments and stories that deserve to be seen.
          I hope this place becomes an extension of the sunshine in your beautiful days,
           and a celebration of your small, everyday victories.
          <br><br>
          With lots of love. ♡
      </p>

    </div>

</section>


<!-- =========================
     CALL TO ACTION
     ========================= -->

<div class="cta-box">

    <h2>
        Let's share your story.
    </h2>

    <p class="mb-4">
        ابدأ الآن برفع صورك،
        اكتشاف صور الآخرين،
        وصناعة معرض خاص من اللحظات
        التي تعني لك شيئًا.
    </p>

    <div>

        <a href="<%= request.getContextPath() %>/gallery"
           class="btn-custom btn-lilac">
            Explore Gallery
        </a>

        <% if (loggedIn) { %>

            <a href="<%= request.getContextPath() %>/create.jsp"
               class="btn-custom btn-purple">
                Upload New Memory
            </a>

        <% } else { %>

            <a href="<%= request.getContextPath() %>/register.jsp"
               class="btn-custom btn-purple">
                Create Free Account
            </a>

        <% } %>

    </div>

</div>


<!-- =========================
     FOOTER
     ========================= -->

<footer>

    <div class="footer-brand">
        alzikrayat.
    </div>

    <div>
        A place for photos, stories and memories.
    </div>

    <div class="mt-3">

        <a href="<%= request.getContextPath() %>/home"
           class="footer-link">
            Home
        </a>

        <span class="mx-2">•</span>

        <a href="<%= request.getContextPath() %>/gallery"
           class="footer-link">
            Explore
        </a>

        <span class="mx-2">•</span>

        <a href="#about"
           class="footer-link">
            About
        </a>

        <% if (!loggedIn) { %>

            <span class="mx-2">•</span>

            <a href="<%= request.getContextPath() %>/login.jsp"
               class="footer-link">
                Login
            </a>

        <% } %>

    </div>

    <div class="mt-3">
        © 2026 Alzikrayat. All rights reserved.
    </div>

</footer>


<!-- Bootstrap JS -->

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js">
</script>

</body>
</html>
</html>