package com.dao;

import com.model.Result;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ResultDAO {

    public boolean saveResult(Result result) {
        String sql = "INSERT INTO results (username, score, total_questions) VALUES (?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, result.getUsername());
            stmt.setInt(2, result.getScore());
            stmt.setInt(3, result.getTotalQuestions());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Result> getResultsByUsername(String username) {
        List<Result> list = new ArrayList<>();
        String sql = "SELECT * FROM results WHERE username = ? ORDER BY timestamp DESC";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    list.add(new Result(
                        rs.getInt("id"),
                        rs.getString("username"),
                        rs.getInt("score"),
                        rs.getInt("total_questions"),
                        rs.getTimestamp("timestamp")
                    ));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
