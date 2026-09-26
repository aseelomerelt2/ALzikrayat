# Alzikrayat

## Project Description

Alzikrayat is a photo sharing web application that I created to give users a simple place to save and share their memories.

The user can register and login, upload photos, view photos in the gallery, open a photo to see its details, add comments, and delete their own photos.

## Technologies Used

- Java
- Jakarta Servlets
- JSP
- JDBC
- MySQL
- HTML
- CSS
- JavaScript
- Bootstrap
- Apache Tomcat
- MAVEN
- BCrypt

## How to Run the Project

1. Download or clone the project.

2. Make sure Java, MySQL, and Apache Tomcat are installed.

3. Run the `database.sql` file in MySQL. It will create the `alzikrayat_db` database and its tables.

4. Open `DatabaseConnection.java` and change th MySQL username and  password if needed.

5. Check the upload folder path in `UploadServlet.java`, `ImageServlet.java`, and `DeletePhotoServlet.java` and change it to a folder that exists on your computer.

6. Build the project using Maven with:

   `mvn> clean > package`

   The project can also be built using Maven from IntelliJ IDEA.

7. Copy the  generated `ALzikrayat-1.0-SNAPSHOT.war` file to the Apache Tomcat `webapps` folder.

8. Start Apache Tomcat.

9. Open the project from:

   `http://localhost:8080/ALzikrayat-1.0-SNAPSHOT/home`

## Student Information

Student Name: Aseel Omer _ IT7

Project Name: Alzikrayat - Photo Sharing Web Application