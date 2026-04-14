# Java Quiz Application (AJAX + Bootstrap Refactor)

A complete, responsive web application built with Java, Servlets, JSP, JDBC, and Bootstrap 5 for a final-year project standard.

## Technology Stack
- **Backend:** Java (JDK 8+), Granular Servlets, JSP
- **Architecture:** Standard MVC (Model-View-Controller)
- **Database:** MySQL (using PreparedStatements to defeat SQL Injection)
- **GUI Framework:** Bootstrap 5 (CSS/JS fetched via CDN)
- **Build Tool:** Maven
- **Server:** Apache Tomcat 9

## Advanced Features Implemented
- **Granular Dispatching**: Separated Servlets (Login, Register, Logout, Quiz, Result, Admin) rather than massive monolithic dispatchers.
- **Dynamic AJAX Quiz**: The quiz form uses asynchronous Javascript fetching to read the question payloads via REST JSON. The page absolutely does not reload during the quiz, mitigating state-loss on refresh errors. It also employs an `onbeforeunload` listener to warn the user if they try to change the URL midway.
- **Active Timer**: Javascript countdown initializes proportional to the total number of questions fetched. Triggers server-side auto-submit upon failure.
- **Modern UI**: Completely styled using Bootstrap 5 classes including cards, grids, spinners, and badges.

---

## Setup Instructions

### 1. Database Setup
1. Launch MySQL logic environment (Workbench/CLI).
2. Open `src/main/resources/quiz_db.sql` and run all scripts. 
   - Generates the schema precisely to the specifications requested:
     `users (id, username, password)`
     `questions (id, question, option1, option2, option3, option4, correct_answer)`
     `results (id, username, score, total_questions, timestamp)`
3. Ensure the DB connection in `src/main/java/com/util/DBConnection.java` corresponds to your local configuration (root/password).

### 2. Deployment in Eclipse (Apache Tomcat)
1. In Eclipse Enterprise Java Edition, select **File > Import > Maven > Existing Maven Projects**. 
2. Point it to this root folder.
3. Make sure you have the Apache Tomcat 9 Server configured in your `Servers` view pane.
4. Right-click the `quiz-application` project > **Run As > Run on Server**.
5. Once Tomcat boots, navigate to `http://localhost:8080/quiz-application/` to view the initial login portal.
6. The `admin` panel can be accessed by specifically logging into the standard payload using credentials:
   **Username: admin**
   **Password: admin123**
