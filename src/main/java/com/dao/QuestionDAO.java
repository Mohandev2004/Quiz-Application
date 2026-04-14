package com.dao;

import com.model.Question;
import com.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuestionDAO {

    public boolean addQuestion(Question q) {
        String sql = "INSERT INTO questions (question, option1, option2, option3, option4, correct_answer) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, q.getQuestion());
            stmt.setString(2, q.getOption1());
            stmt.setString(3, q.getOption2());
            stmt.setString(4, q.getOption3());
            stmt.setString(5, q.getOption4());
            stmt.setString(6, q.getCorrectAnswer());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Question> getAllQuestions() {
        List<Question> list = new ArrayList<>();
        String sql = "SELECT * FROM questions";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
             
            while (rs.next()) {
                list.add(new Question(
                    rs.getInt("id"),
                    rs.getString("question"),
                    rs.getString("option1"),
                    rs.getString("option2"),
                    rs.getString("option3"),
                    rs.getString("option4"),
                    rs.getString("correct_answer")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Question getQuestionById(int id) {
        String sql = "SELECT * FROM questions WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Question(
                        rs.getInt("id"),
                        rs.getString("question"),
                        rs.getString("option1"),
                        rs.getString("option2"),
                        rs.getString("option3"),
                        rs.getString("option4"),
                        rs.getString("correct_answer")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateQuestion(Question q) {
        String sql = "UPDATE questions SET question=?, option1=?, option2=?, option3=?, option4=?, correct_answer=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setString(1, q.getQuestion());
            stmt.setString(2, q.getOption1());
            stmt.setString(3, q.getOption2());
            stmt.setString(4, q.getOption3());
            stmt.setString(5, q.getOption4());
            stmt.setString(6, q.getCorrectAnswer());
            stmt.setInt(7, q.getId());
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteQuestion(int id) {
        String sql = "DELETE FROM questions WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
             
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
