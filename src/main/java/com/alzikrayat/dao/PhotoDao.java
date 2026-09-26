package com.alzikrayat.dao;

import com.alzikrayat.model.Photo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PhotoDao {

    public boolean addPhoto(Photo photo) {

        String sql = "INSERT INTO photos (user_id, file_name, title, description) " +
                "VALUES (?, ?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, photo.getUserId());
            pstmt.setString(2, photo.getFileName());
            pstmt.setString(3, photo.getTitle());
            pstmt.setString(4, photo.getDescription());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Photo> getPhotosByUserId(int userId) {

        List<Photo> photos = new ArrayList<>();

        String sql = "SELECT * FROM photos WHERE user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Photo photo = new Photo();

                photo.setId(rs.getInt("id"));
                photo.setUserId(rs.getInt("user_id"));
                photo.setFileName(rs.getString("file_name"));
                photo.setTitle(rs.getString("title"));
                photo.setDescription(rs.getString("description"));
                photo.setDateTime(rs.getTimestamp("date_time"));

                photos.add(photo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return photos;
    }

    public List<Photo> getAllPhotos() {

        List<Photo> photos = new ArrayList<>();

        String sql = "SELECT * FROM photos ORDER BY date_time DESC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Photo photo = new Photo();

                photo.setId(rs.getInt("id"));
                photo.setUserId(rs.getInt("user_id"));
                photo.setFileName(rs.getString("file_name"));
                photo.setTitle(rs.getString("title"));
                photo.setDescription(rs.getString("description"));
                photo.setDateTime(rs.getTimestamp("date_time"));

                photos.add(photo);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return photos;
    }

    // Get one photo by its ID
    public Photo getPhotoById(int photoId) {

        String sql = "SELECT * FROM photos WHERE id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, photoId);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                Photo photo = new Photo();

                photo.setId(rs.getInt("id"));
                photo.setUserId(rs.getInt("user_id"));
                photo.setFileName(rs.getString("file_name"));
                photo.setTitle(rs.getString("title"));
                photo.setDescription(rs.getString("description"));
                photo.setDateTime(rs.getTimestamp("date_time"));

                return photo;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean deletePhoto(int photoId, int userId) {

        String sql = "DELETE FROM photos WHERE id = ? AND user_id = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, photoId);
            pstmt.setInt(2, userId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get total number of photos
    public int getPhotoCount() {

        String sql = "SELECT COUNT(*) FROM photos";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }
}
