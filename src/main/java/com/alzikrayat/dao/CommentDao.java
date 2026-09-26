package com.alzikrayat.dao;

import com.alzikrayat.model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentDao {

    public boolean addComment(Comment comment) {

        String sql = "INSERT INTO comments (photo_id, user_id, comment) " +
                "VALUES (?, ?, ?)";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, comment.getPhotoId());
            pstmt.setInt(2, comment.getUserId());
            pstmt.setString(3, comment.getComment());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Comment> getCommentsByPhotoId(int photoId) {

        List<Comment> comments = new ArrayList<>();

        String sql =
                "SELECT c.id, c.photo_id, c.user_id, c.comment, c.date_time, " +
                        "u.first_name, u.last_name " +
                        "FROM comments c " +
                        "JOIN users u ON c.user_id = u.id " +
                        "WHERE c.photo_id = ? " +
                        "ORDER BY c.date_time ASC";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, photoId);

            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {

                Comment comment = new Comment();

                comment.setId(rs.getInt("id"));
                comment.setPhotoId(rs.getInt("photo_id"));
                comment.setUserId(rs.getInt("user_id"));
                comment.setComment(rs.getString("comment"));
                comment.setDateTime(rs.getTimestamp("date_time"));

                String firstName = rs.getString("first_name");
                String lastName = rs.getString("last_name");

                comment.setUserName(firstName + " " + lastName);

                comments.add(comment);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return comments;
    }

    // Get total number of comments
    public int getCommentCount() {

        String sql = "SELECT COUNT(*) FROM comments";

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