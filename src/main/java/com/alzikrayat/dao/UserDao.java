package com.alzikrayat.dao;

import com.alzikrayat.model.User;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class UserDao {

    public boolean registerUser(User user) {

        String sql = "INSERT INTO users " +
                "(first_name, last_name, email, password, location, description, occupation) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";

        String hashedPassword = BCrypt.hashpw(
                user.getPassword(),
                BCrypt.gensalt()
        );

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, hashedPassword);
            pstmt.setString(5, user.getLocation());
            pstmt.setString(6, user.getDescription());
            pstmt.setString(7, user.getOccupation());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User loginUser(String email, String password) {

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, email);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {

                String storedPassword = rs.getString("password");

                if (BCrypt.checkpw(password, storedPassword)) {

                    User user = new User();

                    user.setId(rs.getInt("id"));
                    user.setFirstName(rs.getString("first_name"));
                    user.setLastName(rs.getString("last_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(storedPassword);
                    user.setLocation(rs.getString("location"));
                    user.setDescription(rs.getString("description"));
                    user.setOccupation(rs.getString("occupation"));

                    return user;
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int getUserCount() {

        String sql = "SELECT COUNT(*) FROM users";

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