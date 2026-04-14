package com.model;

import java.sql.Timestamp;

public class Result {
    private int id;
    private String username;
    private int score;
    private int totalQuestions;
    private Timestamp timestamp;

    public Result() {}

    public Result(int id, String username, int score, int totalQuestions, Timestamp timestamp) {
        this.id = id;
        this.username = username;
        this.score = score;
        this.totalQuestions = totalQuestions;
        this.timestamp = timestamp;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public int getScore() { return score; }
    public void setScore(int score) { this.score = score; }

    public int getTotalQuestions() { return totalQuestions; }
    public void setTotalQuestions(int totalQuestions) { this.totalQuestions = totalQuestions; }

    public Timestamp getTimestamp() { return timestamp; }
    public void setTimestamp(Timestamp timestamp) { this.timestamp = timestamp; }
}
