<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String error = request.getParameter("error");
    String message = null;

    if ("title".equals(error)) message = "Please enter a valid title. Maximum 200 characters.";
    else if ("description".equals(error)) message = "Description cannot exceed 5000 characters.";
    else if ("size".equals(error)) message = "Each image must not exceed 5 MB.";
    else if ("type".equals(error)) message = "Only JPG, JPEG, PNG and GIF images are allowed.";
    else if ("database".equals(error)) message = "The photo could not be saved. Please try again.";
    else if ("file".equals(error)) message = "Please select at least one photo.";
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Upload Photo - Alzikrayat</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/css/upload.css">
</head>

<body>

<nav class="navbar">
    <div class="container">
        <a class="navbar-brand" href="<%=request.getContextPath()%>/home">✦ Alzikrayat</a>
        <div>
            <a href="<%=request.getContextPath()%>/home">Home</a>
            <a class="ms-4" href="<%=request.getContextPath()%>/gallery">Gallery</a>
        </div>
    </div>
</nav>

<div class="container upload-page">

    <div class="upload-card">

        <h1>✦ Upload Photos</h1>
        <p class="subtitle">Add another memory to your collection.</p>

        <% if (message != null) { %>
            <div class="alert alert-danger"><%= message %></div>
        <% } %>

        <form action="<%=request.getContextPath()%>/upload"
              method="post"
              enctype="multipart/form-data"
              onsubmit="return validateUploadForm()">

            <label>Title</label>
            <input id="title" name="title" class="form-control"
                   maxlength="200" required>

            <label>Description</label>
            <textarea id="description" name="description"
                      class="form-control" maxlength="5000" rows="4"></textarea>

            <label>Choose Photos</label>
            <input id="photo" name="photo" type="file" class="form-control"
                   accept=".jpg,.jpeg,.png,.gif" multiple required>

            <small>You can select multiple images. Maximum 5 MB each.</small>

            <button class="upload-btn" type="submit">Upload Photos</button>

        </form>

        <a class="back-btn" href="<%=request.getContextPath()%>/gallery">
            ← Back to Gallery
        </a>

    </div>

</div>

<script>
function validateUploadForm(){
    const title=document.getElementById("title").value.trim(),
          description=document.getElementById("description").value.trim(),
          files=document.getElementById("photo").files,
          allowed=["jpg","jpeg","png","gif"];

    if(!title || title.length>200){alert("Please enter a valid title.");return false;}
    if(description.length>5000){alert("Description cannot exceed 5000 characters.");return false;}
    if(!files.length){alert("Please select at least one photo.");return false;}

    for(const file of files){
        if(file.size>5*1024*1024){alert("Each image must not exceed 5 MB.");return false;}
        if(!allowed.includes(file.name.split(".").pop().toLowerCase())){
            alert("Only JPG, JPEG, PNG and GIF images are allowed.");return false;
        }
    }
    return true;
}
</script>

</body>
</html>