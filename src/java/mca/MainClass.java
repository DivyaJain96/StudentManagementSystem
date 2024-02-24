/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package mca;

import com.mysql.jdbc.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * @author Divya Kumar Jain
 */
public class MainClass {

    private Connection conn;

    public MainClass() throws ClassNotFoundException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/mca_stud_man";
            String username = "root";
            String password = "";
            conn = (Connection) DriverManager.getConnection(url, username, password);
            // You can uncomment the following line for testing the connection
            //System.out.println("Connection successful");
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    //add_details_student_verification
    public int add_details_user_verification(String email, String vericode) throws SQLException {
        String query = "INSERT INTO user_verification (user_email, veri_code) VALUES (?, ?)";
        PreparedStatement st = conn.prepareStatement(query);
        st.setString(1, email);
        st.setString(2, vericode);
        int rowsInserted = st.executeUpdate();
        return rowsInserted;
    }
    
    // Check Verify COde
    public Map<String, Object> checkUserVerifyCode(String user_email, String veri_code) throws SQLException {
        String query = "SELECT * FROM user_verification WHERE user_email = ? AND veri_code = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, user_email);
        stmt.setString(2, veri_code);
        ResultSet rs = stmt.executeQuery();
        Map<String, Object> res = new HashMap<>();
        if (rs.next()) {
            res.put("user_email", rs.getString("user_email"));
            res.put("veri_code", rs.getString("veri_code"));
            // Add more columns as needed
        } else {
            System.err.println("null values");
        }
        return res;
    }

//delete student verification
    public boolean delete_user_verification(String student_email) throws SQLException {
        String query = "DELETE FROM user_verification WHERE user_email = ?";
        PreparedStatement st = conn.prepareStatement(query);
        st.setString(1, student_email);
        int rowsAffected = st.executeUpdate();
        return rowsAffected > 0;
    }

    //get users by branch not used
    public int get_student_by_branch(String branch, String year) {
        String query = "SELECT * FROM pre_student_register WHERE branch = ? AND registered_year = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, branch);
            stmt.setString(2, year);
            ResultSet rs = stmt.executeQuery();
            int count = 0;
            while (rs.next()) {
                count++;
            }
            return count;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return 0;
        }
    }

    //count users by email
    public int get_student_by_email_count(String email) throws SQLException {
        String query = "SELECT * FROM pre_student_register WHERE email = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        int count = 0;
        while (rs.next()) {
            count++;
        }
        return count;
    }

    //get user by email
    public Map<String, Object> get_student_by_email(String email) throws SQLException {
        String query = "SELECT * FROM pre_student_register WHERE email = ?";
        PreparedStatement statement = conn.prepareStatement(query);
        statement.setString(1, email);
        ResultSet resultSet = statement.executeQuery();
        if (resultSet.next()) {
            Map<String, Object> student = new HashMap<>();
            student.put("student_id", resultSet.getString("student_id"));
            student.put("first_name", resultSet.getString("first_name"));
            student.put("middle_name", resultSet.getString("middle_name"));
            student.put("last_name", resultSet.getString("last_name"));
            student.put("password", resultSet.getString("password"));
            // Add other columns as needed
            return student;
        } else {
            return null; // Return null if no results are found
        }
    }

    //get user by userid
//    public Map<String, Object> get_student_by_userid(String student_id) {
    public HashMap<String, Object> get_student_by_userid(String student_id) {
        HashMap<String, Object> student = new HashMap<>();
//        Map<String, Object> student = new HashMap<>();
        String qry = "SELECT * FROM pre_student_register WHERE student_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(qry)) {
            stmt.setString(1, student_id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                student.put("student_id", rs.getString("student_id"));
                student.put("first_name", rs.getString("first_name"));
                student.put("last_name", rs.getString("last_name"));
                student.put("middle_name", rs.getString("middle_name"));
                student.put("password", rs.getString("password"));
                student.put("gender", rs.getString("gender"));
                student.put("branch", rs.getString("branch"));
                student.put("dob", rs.getString("dob"));
                student.put("email", rs.getString("email"));
                student.put("address", rs.getString("address"));
                student.put("contact_no", rs.getString("contact_no"));
                student.put("city", rs.getString("city"));
                student.put("state", rs.getString("state"));
                student.put("current_semester", rs.getString("current_semester"));
                // Add other fields as needed
            } else {
                System.out.println("not id fetch");
            }
//            if (rs.next()) {
//                student.put("student_id", rs.getString("student_id"));
//                // Add other fields as needed
//            } else {
//                System.out.println("Student with ID " + student_id + " not found.");
//            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return student;
    }

    //insert student_info
    public boolean insertStudentInfo(String student_id) throws SQLException {
        String query = "INSERT INTO student_info (student_id) VALUES (?)";
        PreparedStatement statement = conn.prepareStatement(query);
        statement.setString(1, student_id);
        int res = statement.executeUpdate();
        return res > 0;
    }

    /*public boolean register_student(String userid, String firstname, String middlename, String lastname, String gender, String dob,
     String branch, String contactno, String emai, String city, String state, String address, String pass, String year) throws SQLException {
     String sql = "INSERT INTO pre_student_register (student_id, first_name, middle_name, last_name, gender,dob, branch, contact_no,email,city, state, address, password, registered_year,current_semester) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
     PreparedStatement stmt = conn.prepareStatement(sql);
     stmt.setString(1, userid);
     stmt.setString(2, firstname);
     stmt.setString(3, middlename);
     stmt.setString(4, lastname);
     stmt.setString(5, gender);
     stmt.setString(6, dob);
     stmt.setString(7, branch);
     stmt.setString(8, contactno);
     stmt.setString(9, emai);
     stmt.setString(10, city);
     stmt.setString(11, state);
     stmt.setString(12, address);
     stmt.setString(13, pass);
     stmt.setInt(14, Integer.parseInt(year));
     stmt.setInt(15, 1);
     int rowsInserted = stmt.executeUpdate();
     return rowsInserted > 0;
     }*/
    public String register_student(String userid, String firstname, String middlename, String lastname, String gender, String dob,
            String branch, String contactno, String emai, String city, String state, String address, String pass, String year) throws SQLException {
        String sql = "INSERT INTO pre_student_register (student_id, first_name, middle_name, last_name, gender, dob, branch, "
                + "contact_no, email, city, state, address, password, registered_year, current_semester) VALUES "
                + "(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        // Encrypt the password
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, userid);
        stmt.setString(2, firstname);
        stmt.setString(3, middlename);
        stmt.setString(4, lastname);
        stmt.setString(5, gender);
        stmt.setString(6, dob);
        stmt.setString(7, branch);
        stmt.setString(8, contactno);
        stmt.setString(9, emai);
        stmt.setString(10, city);
        stmt.setString(11, state);
        stmt.setString(12, address);
        stmt.setString(13, pass);
        stmt.setInt(14, Integer.parseInt(year));
        stmt.setInt(15, 1);
        int rowsInserted = stmt.executeUpdate();
        // Convert the boolean to a string
        String result = String.valueOf(rowsInserted > 0);
        return result;
    }

    //insert student data in pre_student_register table
//    public boolean insertStudent(String qry) throws SQLException {
//        PreparedStatement stmt = conn.prepareStatement(qry);
//        int res = stmt.executeUpdate();
//        return res > 0;
//    }
//    public String registerStudent(String userid, String stud_fname, String stud_mname, String stud_lname,
//            String stud_gender, String stud_dob, String stud_branch, String stud_contact, String stud_email,
//            String stud_city, String stud_state, String stud_address, String stud_pass, String year) throws SQLException {
//        // Get the current year
//        int year = Calendar.getInstance().get(Calendar.YEAR);
//        String curr_year = String.valueOf(year).substring(2, 4);
    // Get the count of students by branch and year
//        int users = get_student_by_branch(stud_branch, curr_year);
//        Calendar calendar = Calendar.getInstance();
//        int years = calendar.get(Calendar.YEAR);
//        String yea = String.valueOf(years);
//        String curr_year = String.valueOf(year).substring(2, 4);
//        int user = get_student_by_branch(stud_branch, yea);
//        String userid = "";
//        if (users >= 0 && users < 9) {
//            int count = users + 1;
//            userid = curr_year + stud_branch + "00" + count;
//        } else if (users >= 9 && users < 99) {
//            int count = users + 1;
//            userid = curr_year + stud_branch + "0" + count;
//        } else if (users >= 99 && users < 999) {
//            int count = users + 1;
//            userid = curr_year + stud_branch + count;/
//        }
    // Define the SQL query for insertion
//        String sql = "INSERT INTO pre_student_register "
//                + "(student_id, first_name, middle_name, last_name, "
//                + "gender, dob, branch, contact_no,email, city, state, address, password, registered_year, current_semester) "
//                + "VALUES ('" + userid + "', '" + stud_fname + "', '" + stud_mname + "', '" + stud_lname + "', '" + 
//                stud_gender + "', '" + stud_dob + "', '" +stud_branch + "', " + stud_contact + ", '" + stud_email + "', '" +
//                stud_city + "', '" + stud_state + "', '" + stud_address + "', '" + stud_pass + "', " + year + ", 1)";
//        return sql;
//        String sql = "INSERT INTO pre_student_register (student_id,first_name,middle_name,last_name,"
//                + "gender, dob,branch,contact_no,email,city,state,address,password,registered_year, "
//                + "current_semester) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,1)";
////        PreparedStatement stmt = conn.prepareStatement(sql);
//        stmt.setString(1, userid);
//        stmt.setString(2, stud_fname);
//        stmt.setString(3, stud_mname);
//        stmt.setString(4, stud_lname);
//        stmt.setString(5, stud_gender);
//        stmt.setString(6, stud_dob);
//        stmt.setString(7, stud_branch);
//        stmt.setString(8, stud_contact);
//        stmt.setString(9, stud_email);
//        stmt.setString(10, stud_city);
//        stmt.setString(11, stud_state);
//        stmt.setString(12, stud_address);
//        stmt.setString(13, stud_pass);
//        stmt.setInt(14, Integer.parseInt(curr_year));
//        stmt.setInt(15, 1);
    // Execute the SQL query
//        int rowsInserted = statement.executeUpdate();
//        return sql;
//        int rowsInserted = stmt.executeUpdate();
    // Convert the boolean to a string
//        String result = String.valueOf(rowsInserted > 0);
//        return result;
//    }
//    public int insertStudent(String qry) throws SQLException {
//
//        String sql = "INSERT INTO pre_student_register (student_id,first_name,middle_name,last_name,"
//                + "gender, dob,branch,contact_no,email,city,state,address,password,registered_year, "
//                + "current_semester) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,1)";
//        PreparedStatement stmt = conn.prepareStatement(qry);
//        int res = stmt.executeUpdate(sql);
//        return res;
//    }
    //insert user data in users table
    public boolean insertUserData(String user_id, String user_password, String user_role) throws SQLException {
        String query = "INSERT INTO users (user_id, user_password, user_role) VALUES (?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, user_id);
        stmt.setString(2, user_password);
        stmt.setString(3, user_role);
        int res = stmt.executeUpdate();
        return res > 0;

    }

    //check credential
    public Map<String, Object> checkCredential(String user_id, String user_password) throws SQLException {
        String qry = "SELECT * FROM users WHERE user_id = ? and user_password = ?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, user_id);
        stmt.setString(2, user_password);

        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            Map<String, Object> res = new HashMap<>();
            res.put("user_id", rs.getString("user_id"));
            res.put("user_password", rs.getString("user_password"));
            res.put("user_role", rs.getString("user_role"));
            // Add more columns as needed

            return res;
        } else {
            return new HashMap<>();
        }
    }

//delete_pre_student_register
    public boolean delete_pre_student_register(String studentid) throws SQLException {
        String query = "DELETE FROM pre_student_register WHERE student_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, studentid);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    //delete_student_info
    public boolean delete_student_info(String studentid) throws SQLException {
        String query = "DELETE FROM student_info WHERE student_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, studentid);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    //delete user
    public boolean delete_user(String userid) throws SQLException {
        String query = "DELETE FROM users WHERE user_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, userid);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    // update User table details
    public boolean UpdateregisterStudent(String userid, String stud_fname, String stud_mname, String stud_lname, String stud_gender, String stud_dob, String stud_branch, String stud_email, String stud_contact, String stud_address, String stud_city, String stud_state) {
        String query = "UPDATE pre_student_register SET first_name = ?, middle_name = ?, last_name = ?, gender = ?, branch = ?, email = ?, contact_no = ?, dob = ?, city = ?, state = ?, address = ? WHERE student_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, stud_fname);
            stmt.setString(2, stud_mname);
            stmt.setString(3, stud_lname);
            stmt.setString(4, stud_gender);
            stmt.setString(5, stud_branch);
            stmt.setString(6, stud_email);
            stmt.setString(7, stud_contact);
            stmt.setString(8, stud_dob);
            stmt.setString(9, stud_city);
            stmt.setString(10, stud_state);
            stmt.setString(11, stud_address);
            stmt.setString(12, userid);
            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        }
    }

    //update student_info table
    public boolean updateStudentDetails(String userid, String profile_pic, String blood_group, String tenth_school, String tenth_board,
            int tenth_total_marks, int tenth_obtained_marks, String tenth_marksheet, String twelve_stream, String twelve_school,
            String twelve_board, int twelve_total_marks, int twelve_obtained_marks, String twelve_marksheet, String bachelor_stream,
            String bachelor_college, String bachelor_university, int bachelor_total_cgpa, int bachelor_obtained_cgpa,
            String bachelor_degree) throws SQLException {
        String query = "UPDATE student_info SET profile_pic = ?, blood_group = ?, 10th_school = ?, 10th_board = ?, 10th_total_marks = ?,"
                + " 10th_obtained_marks = ?, 10th_marksheet = ?, 12th_stream = ?, 12th_school = ?, 12th_board = ?, 12th_total_marks = ?,"
                + " 12th_obtained_marks = ?, 12th_marksheet = ?, bachelor_stream = ?, bachelor_college = ?, bachelor_university = ?,"
                + " bachelor_total_cgpa = ?, bachelor_obtained_cgpa = ?, bachelor_degree = ? WHERE student_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, profile_pic);
        stmt.setString(2, blood_group);
        stmt.setString(3, tenth_school);
        stmt.setString(4, tenth_board);
        stmt.setInt(5, tenth_total_marks);
        stmt.setInt(6, tenth_obtained_marks);
        stmt.setString(7, tenth_marksheet);
        stmt.setString(8, twelve_stream);
        stmt.setString(9, twelve_school);
        stmt.setString(10, twelve_board);
        stmt.setInt(11, twelve_total_marks);
        stmt.setInt(12, twelve_obtained_marks);
        stmt.setString(13, twelve_marksheet);
        stmt.setString(14, bachelor_stream);
        stmt.setString(15, bachelor_college);
        stmt.setString(16, bachelor_university);
        stmt.setInt(17, bachelor_total_cgpa);
        stmt.setInt(18, bachelor_obtained_cgpa);
        stmt.setString(19, bachelor_degree);
        stmt.setString(20, userid);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    //get student details
    public Map<String, Object> get_student_details(String studentId) {
        Map<String, Object> studentInfo = new HashMap<>();
        String query = "SELECT * FROM student_info WHERE student_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, studentId);
            ResultSet resultSet = stmt.executeQuery();

            if (resultSet.next()) {
                studentInfo.put("student_id", resultSet.getString("student_id"));
                studentInfo.put("profile_pic", resultSet.getString("profile_pic"));
                studentInfo.put("blood_group", resultSet.getString("blood_group"));
                studentInfo.put("10th_school", resultSet.getString("10th_school"));
                studentInfo.put("10th_board", resultSet.getString("10th_board"));
                studentInfo.put("10th_total_marks", resultSet.getInt("10th_total_marks"));
                studentInfo.put("10th_obtained_marks", resultSet.getInt("10th_obtained_marks"));
                studentInfo.put("10th_marksheet", resultSet.getString("10th_marksheet"));
                studentInfo.put("12th_stream", resultSet.getString("12th_stream"));
                studentInfo.put("12th_school", resultSet.getString("12th_school"));
                studentInfo.put("12th_board", resultSet.getString("12th_board"));
                studentInfo.put("12th_total_marks", resultSet.getInt("12th_total_marks"));
                studentInfo.put("12th_obtained_marks", resultSet.getInt("12th_obtained_marks"));
                studentInfo.put("12th_marksheet", resultSet.getString("12th_marksheet"));
                studentInfo.put("bachelor_stream", resultSet.getString("bachelor_stream"));
                studentInfo.put("bachelor_college", resultSet.getString("bachelor_college"));
                studentInfo.put("bachelor_university", resultSet.getString("bachelor_university"));
                studentInfo.put("bachelor_total_cgpa", resultSet.getInt("bachelor_total_cgpa"));
                studentInfo.put("bachelor_obtained_cgpa", resultSet.getInt("bachelor_obtained_cgpa"));
                studentInfo.put("bachelor_degree", resultSet.getString("bachelor_degree"));
                // Add more properties here
            }
//            resultSet.close();
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return studentInfo;
    }

    //clear img from database
    public boolean clear_image(String student_id, String column_name) throws SQLException {
        String query = "UPDATE student_info SET " + column_name + " = '' WHERE student_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, student_id);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    //add notice
    public boolean add_notice(String notice_title, String notice_text, String upload, String student_branch) throws SQLException {
        String qry = "INSERT INTO notices (notice_title,notice_text,notice_img,student_branch,notice_date) VALUES (?,?,?,?,?)";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, notice_title);
        stmt.setString(2, notice_text);
        stmt.setString(3, upload);
        stmt.setString(4, student_branch);
        stmt.setDate(5, new java.sql.Date(Calendar.getInstance().getTimeInMillis()));
        int res = stmt.executeUpdate();
        return res > 0;
    }

    //get all notices
    public List<Map<String, Object>> get_notices() {
        List<Map<String, Object>> notices = new ArrayList<>();
        String qry = "SELECT * from notices ORDER BY notice_date";
        try {
            PreparedStatement stmt = conn.prepareStatement(qry);
            ResultSet res = stmt.executeQuery();
            while (res.next()) {
                Map<String, Object> notice = new HashMap<>();
//                notice.put("notice_id", res.getInt("notice_id"));
                notice.put("id", res.getInt("id"));
                notice.put("notice_title", res.getString("notice_title"));
                notice.put("notice_text", res.getString("notice_text"));
                notice.put("notice_img", res.getString("notice_img"));
                notice.put("student_branch", res.getString("student_branch"));
                notice.put("notice_date", res.getString("notice_date"));
//                notice.put("notice_date", res.getDate("notice_date"));
                notices.add(notice);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return notices;
    }

    //get departmentwise notice
    public List<HashMap<String, Object>> get_notice(String student_branch) {
        List<HashMap<String, Object>> notices = new ArrayList<>();
        String qry = "SELECT * FROM notices WHERE student_branch=? ORDER BY notice_date";
        try {
            PreparedStatement stmt = conn.prepareStatement(qry);
            stmt.setString(1, student_branch);
            ResultSet res = stmt.executeQuery();
            while (res.next()) {
                HashMap<String, Object> notice = new HashMap<>();
                notice.put("id", res.getInt("id"));
                notice.put("notice_title", res.getString("notice_title"));
                notice.put("notice_text", res.getString("notice_text"));
                notice.put("notice_img", res.getString("notice_img"));
                notice.put("student_branch", res.getString("student_branch"));
                notice.put("notice_date", res.getString("notice_date"));
                notices.add(notice);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return notices;
    }

    //register subject
    public boolean register_subject(String subjectName, String subjectCode, String subjectType, String studentBranch, int studentSemester, int subjectExternalMarks, int subjectInternalMarks) {
        String query = "INSERT INTO course_details(subject_name, subject_code, semester, branch, subject_type, subject_external_marks, subject_internal_marks, active) VALUES (?, ?, ?, ?, ?, ?, ?, 'yes')";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setString(1, subjectName);
            statement.setString(2, subjectCode);
            statement.setInt(3, studentSemester);
            statement.setString(4, studentBranch);
            statement.setString(5, subjectType);
            statement.setInt(6, subjectExternalMarks);
            statement.setInt(7, subjectInternalMarks);

            int rowsInserted = statement.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            System.out.println("Error registering subject: " + e.getMessage());
        }
        return false;
    }

    //get subjects list details
    public List<Map<String, Object>> get_subjects_list() throws SQLException {
        String qry = "SELECT * FROM course_details";
        PreparedStatement stmt = conn.prepareStatement(qry);
        ResultSet res = stmt.executeQuery();
        List<Map<String, Object>> result = new ArrayList<>();
        ResultSetMetaData metaData = res.getMetaData();
        int columnCount = metaData.getColumnCount();
        while (res.next()) {
            Map<String, Object> row = new HashMap<>();
            for (int i = 1; i <= columnCount; i++) {
                row.put(metaData.getColumnName(i), res.getObject(i));
            }
            result.add(row);
        }
        return result;
    }

    //get subject list by branch
    public List<Map<String, Object>> getSubjectsListByBranch(String branch) throws SQLException {
        String qry = "SELECT * FROM course_details WHERE branch LIKE ?";
        PreparedStatement stmt = this.conn.prepareStatement(qry);
        stmt.setString(1, "%" + branch + "%");
        boolean res = stmt.execute();
        ResultSet rs = stmt.getResultSet();
        List<Map<String, Object>> result = new ArrayList<>();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("sid", rs.getInt("sid"));
            row.put("subject_name", rs.getString("subject_name"));
            row.put("subject_code", rs.getString("subject_code"));
            row.put("semester", rs.getInt("semester"));
            row.put("branch", rs.getString("branch"));
            row.put("subject_type", rs.getString("subject_type"));
            row.put("subject_external_marks", rs.getInt("subject_external_marks"));
            row.put("subject_internal_marks", rs.getInt("subject_internal_marks"));
            row.put("active", rs.getString("active"));
            row.put("faculty_id", rs.getString("faculty_id"));
            result.add(row);
        }
        return result;
    }

    //get subject by sid
    public Map<String, Object> get_subject_by_sid(int sid) throws SQLException {
        String qry = "SELECT * FROM course_details WHERE sid=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setInt(1, sid);
        ResultSet res = stmt.executeQuery();
        Map<String, Object> subject = new HashMap<>();
        while (res.next()) {
            subject.put("sid", res.getInt("sid"));
            subject.put("subject_name", res.getString("subject_name"));
            subject.put("subject_code", res.getString("subject_code"));
            subject.put("semester", res.getInt("semester"));
            subject.put("branch", res.getString("branch"));
            subject.put("subject_type", res.getString("subject_type"));
            subject.put("subject_external_marks", res.getInt("subject_external_marks"));
            subject.put("subject_internal_marks", res.getInt("subject_internal_marks"));
            subject.put("active", res.getString("active"));
            subject.put("faculty_id", res.getString("faculty_id"));
        }
        return subject;
    }

    //get_active_course_details_by_branch_and_semester
    public List<Map<String, Object>> get_active_course_details_by_branch_and_semester(String branch, int semester) throws SQLException {
        String qry = "SELECT * FROM course_details WHERE branch=? AND semester=? AND active='yes'";
        PreparedStatement stmt = this.conn.prepareStatement(qry);
        stmt.setString(1, branch);
        stmt.setInt(2, semester);
//        stmt.setString(2, semester);
//        int res = stmt.executeUpdate();
        ResultSet rs = stmt.executeQuery();
        List<Map<String, Object>> result = new ArrayList<>();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("sid", rs.getInt("sid"));
            row.put("subject_name", rs.getString("subject_name"));
            row.put("subject_code", rs.getString("subject_code"));
            row.put("semester", rs.getInt("semester"));
            row.put("branch", rs.getString("branch"));
            row.put("subject_type", rs.getString("subject_type"));
            row.put("subject_external_marks", rs.getInt("subject_external_marks"));
            row.put("subject_internal_marks", rs.getInt("subject_internal_marks"));
            row.put("active", rs.getString("active"));
            row.put("faculty_id", rs.getString("faculty_id"));
            result.add(row);
        }
        return result;
    }

    //update subjects
    public int update_subject_details(int sid, String subjectName, String subjectCode, String subjectType,
            String studentBranch, int studentSemester, int subjectExternalMarks, int subjectInternalMarks,
            String active, String facultyId) {
        String qry = "UPDATE course_details SET subject_name=?,subject_code=?,semester=?,branch=?,subject_type=?,subject_external_marks=?,subject_internal_marks=?,active=?,faculty_id=? WHERE sid=?";
        try {
            PreparedStatement stmt = conn.prepareStatement(qry);
            stmt.setString(1, subjectName);
            stmt.setString(2, subjectCode);
            stmt.setInt(3, studentSemester);
            stmt.setString(4, studentBranch);
            stmt.setString(5, subjectType);
            stmt.setInt(6, subjectExternalMarks);
            stmt.setInt(7, subjectInternalMarks);
            stmt.setString(8, active);
            stmt.setString(9, facultyId);
            stmt.setInt(10, sid);
            int res = stmt.executeUpdate();
            return res;
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    //delete subjects
    public int detete_subject_details(int sid) throws SQLException {
        String qry = "DELETE FROM course_details WHERE sid=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setInt(1, sid);
        int res = stmt.executeUpdate();
        return res;
    }

    //get subject by faculty
    public List<Map<String, Object>> get_subjects_list_by_faculty(String faculty_id) throws SQLException {
        List<Map<String, Object>> res = new ArrayList<>();
        String qry = "SELECT * FROM course_details WHERE faculty_id=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, faculty_id);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("sid", rs.getInt("sid"));
//            row.put("faculty_id", rs.getString("faculty_id"));
//                row.put("day", rs.getString("day"));
            res.add(row);
        }
        return res;
    }

    //get students
    public List<Map<String, Object>> get_students_by_branch_and_semester(String branch, int semester) throws SQLException {
        String qry = "SELECT * FROM pre_student_register WHERE branch=? AND current_semester=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, branch);
        stmt.setInt(2, semester);
        ResultSet res = stmt.executeQuery();
        List<Map<String, Object>> result = new ArrayList<>();
        while (res.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("student_id", res.getString("student_id"));
            row.put("email", res.getString("email"));
            row.put("branch", res.getString("branch"));
//            row.put("current_semester", res.getInt("current_semester"));
            row.put("semester", res.getInt("current_semester"));
            row.put("first_name", res.getString("first_name"));
            row.put("middle_name", res.getString("middle_name"));
            row.put("last_name", res.getString("last_name"));
            result.add(row);
        }
        return result;
    }

    //check results is added or not
    public List<Map<String, Object>> check_internal_records(String student_id, int semester) throws SQLException {
        List<Map<String, Object>> result = new ArrayList<>();
        String qry = "SELECT * FROM results WHERE student_id=? AND semester=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, student_id);
        stmt.setInt(2, semester);
        ResultSet res = stmt.executeQuery();
        while (res.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("student_id", res.getString("student_id"));
            row.put("semester", res.getInt("semester"));
            row.put("subject_id", res.getInt("subject_id"));
            row.put("exam", res.getString("exam"));
            row.put("internal_obtained_marks", res.getInt("internal_obtained_marks"));
            row.put("external_obtained_marks", res.getInt("external_obtained_marks"));
            row.put("status", res.getString("status"));
            result.add(row);
        }
        return result;
    }

    //check external results is added or not
    public int check_external_records(String student_id, int semester) throws SQLException {
        String qry = "SELECT * FROM results WHERE student_id=? AND semester=? AND external_obtained_marks!=-1";
//        String qry = "SELECT * FROM results WHERE student_id=? AND semester=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, student_id);
        stmt.setInt(2, semester);
        ResultSet res = stmt.executeQuery();
//        res.last();
//        int count = res.getRow();
        int count = 0;

        while (res.next()) {
            count++;
        }
        return count;
    }

    //add student marks
    public int add_internal_marks(String student_id, int subid, int sem, String exam_month, int internal_obtained_marks) throws SQLException {
        String qry = "INSERT INTO results(student_id,subject_id,semester,exam,internal_obtained_marks,external_obtained_marks) VALUES(?,?,?,?,?,?)";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, student_id);
        stmt.setInt(2, subid);
        stmt.setInt(3, sem);
        stmt.setString(4, exam_month);
        stmt.setInt(5, internal_obtained_marks);
        stmt.setInt(6, -1);
        int res = stmt.executeUpdate();
        return res;
    }

    //function get subject internal marks
    public Map<String, Object> get_subject_internal_marks(String student_id, int sub_id, int sem, String exam) throws SQLException {
        String qry = "SELECT internal_obtained_marks FROM results WHERE student_id=? AND subject_id=? AND semester=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, student_id);
        stmt.setInt(2, sub_id);
        stmt.setInt(3, sem);
        ResultSet res = stmt.executeQuery();
        Map<String, Object> result = new HashMap<>();
        if (res.next()) {
            result.put("internal_obtained_marks", res.getInt("internal_obtained_marks"));
        }
        return result;
    }

    //add student external marks
    public int addExternalMarks(String studentId, int subId, int sem, String exam, int externalMarks) throws SQLException {
        Map<String, Object> internalMarks = get_subject_internal_marks(studentId, subId, sem, exam);
        int internalObtainedMarks = (int) internalMarks.get("internal_obtained_marks");

        int totalMarks = internalObtainedMarks + externalMarks;
        String grade;

        if (totalMarks >= 80 && totalMarks <= 100) {
            grade = "AA";
        } else if (totalMarks < 80 && totalMarks >= 73) {
            grade = "AB";
        } else if (totalMarks < 73 && totalMarks >= 66) {
            grade = "BB";
        } else if (totalMarks < 66 && totalMarks >= 60) {
            grade = "BC";
        } else if (totalMarks < 60 && totalMarks >= 55) {
            grade = "CC";
        } else if (totalMarks < 55 && totalMarks >= 50) {
            grade = "CD";
        } else if (totalMarks < 50 && totalMarks >= 45) {
            grade = "DD";
        } else if (totalMarks >= 0 && totalMarks < 45) {
            grade = "FF";
        } else {
            grade = "Not are a student you"; // Handle any other cases according to your requirements
        }

        String query = "UPDATE results SET external_obtained_marks = ?, status = ? WHERE student_id = ? AND semester = ? AND subject_id = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, externalMarks);
        stmt.setString(2, grade);
        stmt.setString(3, studentId);
        stmt.setInt(4, sem);
        stmt.setInt(5, subId);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected;
    }

    public List<Map<String, Object>> get_semester(String current_student_id) {
        List<Map<String, Object>> semesters = new ArrayList<>();

        String qry = "SELECT DISTINCT(semester) FROM results WHERE student_id = ? AND external_obtained_marks != -1";
        try (PreparedStatement stmt = conn.prepareStatement(qry)) {
            stmt.setString(1, current_student_id);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Map<String, Object> sem = new HashMap<>();
                sem.put("semester", rs.getInt("semester"));
                semesters.add(sem);
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle or log the exception appropriately
        }

        return semesters;
    }

    //get_student_results
    public List<Map<String, Object>> getStudentResults(String studentId, int semester) {
        List<Map<String, Object>> results = new ArrayList<>();
        String query = "SELECT results.subject_id, course_details.subject_code,course_details.subject_name, course_details.subject_type, "
                + "course_details.subject_external_marks, course_details.subject_internal_marks, "
                + "results.semester, results.internal_obtained_marks, results.external_obtained_marks ,results.status "
                + "FROM results INNER JOIN course_details ON results.subject_id = course_details.sid WHERE "
                + "results.student_id = ? AND results.semester = ? ORDER BY course_details.subject_code";
        try (PreparedStatement statement = conn.prepareStatement(query)) {
            statement.setString(1, studentId);
            statement.setInt(2, semester);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                Map<String, Object> resultRow = new HashMap<>();
                resultRow.put("subject_id", resultSet.getInt("subject_id"));
                resultRow.put("subject_code", resultSet.getString("subject_code"));
                resultRow.put("subject_name", resultSet.getString("subject_name"));
                resultRow.put("subject_type", resultSet.getString("subject_type"));
                resultRow.put("subject_external_marks", resultSet.getInt("subject_external_marks"));
                resultRow.put("subject_internal_marks", resultSet.getInt("subject_internal_marks"));
                resultRow.put("semester", resultSet.getInt("semester"));
                resultRow.put("internal_obtained_marks", resultSet.getInt("internal_obtained_marks"));
                resultRow.put("external_obtained_marks", resultSet.getInt("external_obtained_marks"));
                resultRow.put("status", resultSet.getString("status"));
                results.add(resultRow);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }
        return results;
    }

    public Map<String, Object> allstudentdetails(String studentId) throws SQLException {
        Map<String, Object> result = new HashMap<>();

        // Query for pre_student_register table
        String q1 = "SELECT student_id, first_name,middle_name,last_name,gender,branch,email,contact_no,dob,city,state,address,password,"
                + "registered_year, current_semester FROM pre_student_register WHERE student_id = ?";

        // Query for student_info table
        String q2 = "SELECT student_id, profile_pic, blood_group,10th_school,10th_board,10th_total_marks,10th_obtained_marks,"
                + "10th_marksheet,12th_stream,12th_school,12th_board,12th_total_marks,12th_obtained_marks,12th_marksheet,bachelor_stream,"
                + " bachelor_college,bachelor_university,bachelor_total_cgpa,bachelor_obtained_cgpa,bachelor_degree FROM "
                + "student_info WHERE student_id = ?";

        try (PreparedStatement stmt1 = conn.prepareStatement(q1);
                PreparedStatement stmt2 = conn.prepareStatement(q2)) {
            // Set the student_id parameter for both queries
            stmt1.setString(1, studentId);
            stmt2.setString(1, studentId);

            // Execute the first query and populate the result map
            ResultSet rs1 = stmt1.executeQuery();
            while (rs1.next()) {
                result.put("student_id", rs1.getString("student_id"));
                result.put("first_name", rs1.getString("first_name"));
                result.put("middle_name", rs1.getString("middle_name"));
                result.put("last_name", rs1.getString("last_name"));
                result.put("gender", rs1.getString("gender"));
                result.put("branch", rs1.getString("branch"));
                result.put("email", rs1.getString("email"));
                result.put("contact_no", rs1.getString("contact_no"));
                result.put("dob", rs1.getString("dob"));
                result.put("city", rs1.getString("city"));
                result.put("state", rs1.getString("state"));
                result.put("address", rs1.getString("address"));
                result.put("password", rs1.getString("password"));
                result.put("registered_year", rs1.getDate("registered_year"));
                result.put("current_semester", rs1.getInt("current_semester"));
            }

            // Execute the second query and populate the result map
            ResultSet rs2 = stmt2.executeQuery();
            while (rs2.next()) {
                result.put("student_id", rs2.getString("student_id"));
                result.put("profile_pic", rs2.getString("profile_pic"));
                result.put("blood_group", rs2.getString("blood_group"));
                result.put("10th_school", rs2.getString("10th_school"));
                result.put("10th_board", rs2.getString("10th_board"));
                result.put("10th_total_marks", rs2.getInt("10th_total_marks"));
                result.put("10th_obtained_marks", rs2.getInt("10th_obtained_marks"));
                result.put("10th_marksheet", rs2.getString("10th_marksheet"));
                result.put("12th_stream", rs2.getString("12th_stream"));
                result.put("12th_school", rs2.getString("12th_school"));
                result.put("12th_board", rs2.getString("12th_board"));
                result.put("12th_total_marks", rs2.getInt("12th_total_marks"));
                result.put("12th_obtained_marks", rs2.getInt("12th_obtained_marks"));
                result.put("12th_marksheet", rs2.getString("12th_marksheet"));
                result.put("bachelor_stream", rs2.getString("bachelor_stream"));
                result.put("bachelor_college", rs2.getString("bachelor_college"));
                result.put("bachelor_university", rs2.getString("bachelor_university"));
                result.put("bachelor_total_cgpa", rs2.getInt("bachelor_total_cgpa"));
                result.put("bachelor_obtained_cgpa", rs2.getInt("bachelor_obtained_cgpa"));
                result.put("bachelor_degree", rs2.getString("bachelor_degree"));
                // Add more fields from query2 as needed
            }
        } catch (SQLException e) {
//            System.out.println(e.toString());
            e.printStackTrace();
        }
        return result;
    }

    //add class time table
    public boolean add_class_time_table(String day, String timeStart, String timeEnd, int subject, String branch, int semester, String venue) {
        String query = "INSERT INTO class_time_table (day, subject_id, time_start, time_end, branch, semester, venue) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, day);
            stmt.setInt(2, subject);
            stmt.setString(3, timeStart);
            stmt.setString(4, timeEnd);
            stmt.setString(5, branch);
            stmt.setInt(6, semester);
            stmt.setString(7, venue);

            int rowsAffected = stmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }

    //get_time_table_by_day
    public List<Map<String, Object>> get_time_table_by_day(String branch, int sem, String day) throws SQLException {
        String qry = "SELECT class_time_table.id,class_time_table.day,class_time_table.subject_id,class_time_table.time_start,class_time_table.time_end,class_time_table.branch,class_time_table.venue,course_details.subject_name,course_details.subject_code,course_details.subject_type,course_details.faculty_id FROM class_time_table INNER JOIN course_details ON class_time_table.subject_id=course_details.sid WHERE class_time_table.branch=? AND class_time_table.day=? AND class_time_table.semester=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, branch);
        stmt.setString(2, day);
        stmt.setInt(3, sem);
        ResultSet res = stmt.executeQuery();
        List<Map<String, Object>> result = new ArrayList<>();
        while (res.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("id", res.getInt("id"));
            row.put("day", res.getString("day"));
            row.put("subject_id", res.getString("subject_id"));
            row.put("time_start", res.getString("time_start"));
            row.put("time_end", res.getString("time_end"));
            row.put("branch", res.getString("branch"));
            row.put("venue", res.getString("venue"));
            row.put("subject_name", res.getString("subject_name"));
            row.put("subject_code", res.getString("subject_code"));
            row.put("subject_type", res.getString("subject_type"));
            row.put("faculty_id", res.getString("faculty_id"));
            result.add(row);
        }
        return result;
    }

//get_time_table
    public List<Map<String, Object>> get_time_table(String branch, int semester) throws SQLException {
        String qry = "SELECT class_time_table.id,class_time_table.day,class_time_table.semester,class_time_table.subject_id,class_time_table.time_start,class_time_table.time_end,class_time_table.branch,class_time_table.venue,course_details.subject_name,course_details.subject_code,course_details.subject_type,course_details.faculty_id,faculty.first_name,faculty.middle_name,faculty.last_name FROM class_time_table INNER JOIN course_details ON class_time_table.subject_id=course_details.sid INNER JOIN faculty ON course_details.faculty_id=faculty.faculty_id WHERE class_time_table.branch=? AND class_time_table.semester=? ORDER BY class_time_table.day";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, branch);
        stmt.setInt(2, semester);
        ResultSet res = stmt.executeQuery();
        List<Map<String, Object>> result = new ArrayList<Map<String, Object>>();
        while (res.next()) {
            Map<String, Object> row = new HashMap<String, Object>();
            row.put("id", res.getInt("id"));
            row.put("day", res.getString("day"));
            row.put("semester", res.getInt("semester"));
            row.put("subject_id", res.getString("subject_id"));
            row.put("time_start", res.getString("time_start"));
            row.put("time_end", res.getString("time_end"));
            row.put("branch", res.getString("branch"));
            row.put("venue", res.getString("venue"));
            row.put("subject_name", res.getString("subject_name"));
            row.put("subject_code", res.getString("subject_code"));
            row.put("subject_type", res.getString("subject_type"));
            row.put("faculty_id", res.getString("faculty_id"));
            row.put("first_name", res.getString("first_name"));
            row.put("middle_name", res.getString("middle_name"));
            row.put("last_name", res.getString("last_name"));
            result.add(row);
        }
        return result;
    }

    //get faculty time table
    public List<Map<String, Object>> get_faculty_time_table(String faculty_id, String day) throws SQLException {
        List<Map<String, Object>> res = new ArrayList<>();
        List<Map<String, Object>> subjectsArray = get_subjects_list_by_faculty(faculty_id);
        if (subjectsArray.isEmpty()) {
            return res; // Return empty result or handle it as needed
        }
        StringBuilder subjectsList = new StringBuilder();
        for (Map<String, Object> sub : subjectsArray) {
            subjectsList.append(sub.get("sid")).append(",");
        }
        String newSubjectList = subjectsList.substring(0, subjectsList.length() - 1);
        String qry = "SELECT class_time_table.id,class_time_table.day,class_time_table.semester,"
                + "class_time_table.subject_id,class_time_table.time_start,class_time_table.time_end,"
                + "class_time_table.venue,course_details.subject_name,course_details.subject_code,"
                + "course_details.branch,course_details.subject_type "
                + "FROM class_time_table INNER JOIN course_details ON class_time_table.subject_id=course_details.sid  "
                + "WHERE class_time_table.subject_id IN (" + newSubjectList + ") AND "
                + "class_time_table.day='" + day + "' ORDER BY class_time_table.time_start";
        PreparedStatement stmt = conn.prepareStatement(qry);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("id", rs.getInt("id"));
            row.put("day", rs.getString("day"));
            row.put("semester", rs.getInt("semester"));
            row.put("subject_id", rs.getInt("subject_id"));
            row.put("time_start", rs.getString("time_start"));
            row.put("time_end", rs.getString("time_end"));
            row.put("venue", rs.getString("venue"));
            row.put("subject_name", rs.getString("subject_name"));
            row.put("subject_code", rs.getString("subject_code"));
            row.put("branch", rs.getString("branch"));
            row.put("subject_type", rs.getString("subject_type"));
//            row.put("sid", rs.getInt("sid"));
            res.add(row);
        }
        return res;
    }

    //delete time table using branch and semester
    public boolean delete_time_table(String branch, int semester) throws SQLException {
        String query = "DELETE FROM class_time_table WHERE branch = ? AND semester = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, branch);
        stmt.setInt(2, semester);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    //get faculty
    public Map<String, Object> get_faculty(String faculty_id) throws SQLException {
        String query = "SELECT * FROM faculty WHERE faculty_id=?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, faculty_id);
        ResultSet res = stmt.executeQuery();
        if (res.next()) {
            Map<String, Object> faculty = new HashMap<>();
            faculty.put("faculty_id", res.getString("faculty_id"));
            faculty.put("faculty_nam", res.getString("first_name"));
            faculty.put("faculty_na", res.getString("middle_name"));
            faculty.put("faculty_name", res.getString("last_name"));
            // add other columns as needed
            return faculty;
        } else {
            return null;
        }
    }

    //check faculty email exits or not
    public int count_faculty() {
        String query = "SELECT COUNT(*) FROM faculty";
        int count = 0;
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting faculty: " + e.getMessage());
        }

        return count;
    }

    //get_faculty_by_email_count
    public int get_faculty_by_email_count(String email) {
        String query = "SELECT COUNT(*) FROM faculty WHERE email = ?";
        int count = 0;

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println("Error counting faculty by email: " + e.getMessage());

//            e.printStackTrace();
        }

        return count;
    }

    public int getFacultyByEmailCount(String email) throws SQLException {
        String qry = "SELECT * FROM faculty WHERE email=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, email);
        ResultSet rs = stmt.executeQuery();
        int res = 0;
        while (rs.next()) {
            res++;
        }
        return res;
    }

    public boolean insertFaculty(String faculty_id, String firstname, String middlename, String lastname,
            String qualification, String gender, String dob, String email, String contact, String address, String city,
            String state, String faculty_password) throws SQLException {

        String qry = "INSERT INTO faculty(`faculty_id`, `first_name`, `middle_name`, `last_name`, `qualification`, `gender`, `dob`, `email`, `contact`, `address`, `city`, `state`, `password`) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, faculty_id);
        stmt.setString(2, firstname);
        stmt.setString(3, middlename);
        stmt.setString(4, lastname);
        stmt.setString(5, qualification);
        stmt.setString(6, gender);
        stmt.setString(7, dob);
        stmt.setString(8, email);
        stmt.setString(9, contact);
        stmt.setString(10, address);
        stmt.setString(11, city);
        stmt.setString(12, state);
        stmt.setString(13, faculty_password);
        int res = stmt.executeUpdate();
        return res > 0;
    }

//get_all_faculty
    public List<Map<String, Object>> get_all_faculty() throws SQLException {
        String qry = "SELECT * FROM faculty";
        PreparedStatement stmt = conn.prepareStatement(qry);
        ResultSet rs = stmt.executeQuery();
        List<Map<String, Object>> res = new ArrayList<>();
        while (rs.next()) {
            Map<String, Object> row = new HashMap<>();
            row.put("faculty_id", rs.getString("faculty_id"));
            row.put("first_name", rs.getString("first_name"));
            row.put("middle_name", rs.getString("middle_name"));
            row.put("last_name", rs.getString("last_name"));
            row.put("qualification", rs.getString("qualification"));
            row.put("gender", rs.getString("gender"));
            row.put("dob", rs.getString("dob"));
            row.put("email", rs.getString("email"));
            row.put("contact", rs.getString("contact"));
            row.put("address", rs.getString("address"));
            row.put("city", rs.getString("city"));
            row.put("state", rs.getString("state"));
            row.put("password", rs.getString("password"));
            res.add(row);
        }
        return res;
    }

    //get_attendance
    public Map<String, Object> get_attendance(String faculty_id, int lecture_id, String lecture_date) throws SQLException {
        Map<String, Object> attendance = new HashMap<>();
        String qry = "SELECT * FROM student_attendance WHERE faculty_id=? AND class_time_table_id=? AND lecture_date=?";
        PreparedStatement stmt = conn.prepareStatement(qry);
        stmt.setString(1, faculty_id);
        stmt.setInt(2, lecture_id);
        stmt.setString(3, lecture_date);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            // Retrieve the attendance details
            attendance.put("id", rs.getInt("id"));
            attendance.put("faculty_id", rs.getString("faculty_id"));
            attendance.put("lecture_id", rs.getInt("class_time_table_id"));
            attendance.put("lecture_date", rs.getString("lecture_date"));
            attendance.put("present_student_list", rs.getString("present_student_list"));
            // Add other attendance details as needed
        }
        return attendance;
    }

    //get_attendance_by_attendance_id
    public Map<String, Object> getAttendanceByAttendanceId(int id) throws SQLException {
        String query = "SELECT student_attendance.id, student_attendance.faculty_id, "
                + "student_attendance.present_student_list,"
                + "student_attendance.class_time_table_id, "
                + "student_attendance.lecture_date,"
                //                + "student_attendance.class_time_table_id, "
                + "class_time_table.subject_id, "
                + "class_time_table.time_start, "
                + "class_time_table.time_end, "
                + "class_time_table.venue, "
                + "course_details.subject_name, "
                + "course_details.subject_code, "
                + "course_details.subject_type, "
                + "course_details.branch, "
                + "course_details.semester "
                + "FROM student_attendance INNER JOIN class_time_table ON "
                + "student_attendance.class_time_table_id = class_time_table.id "
                + "INNER JOIN course_details ON class_time_table.subject_id = course_details.sid WHERE student_attendance.id = ?";
        Map<String, Object> attendance = new HashMap<>();
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, id);
        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            attendance.put("id", rs.getInt("id"));
            attendance.put("faculty_id", rs.getString("faculty_id"));
            attendance.put("present_student_list", rs.getString("present_student_list"));
            attendance.put("class_time_table_id", rs.getInt("class_time_table_id"));
            attendance.put("lecture_date", rs.getString("lecture_date"));
            attendance.put("subject_id", rs.getInt("subject_id"));
            attendance.put("time_start", rs.getTime("time_start"));
            attendance.put("time_end", rs.getTime("time_end"));
            attendance.put("venue", rs.getString("venue"));
            attendance.put("subject_name", rs.getString("subject_name"));
            attendance.put("subject_code", rs.getString("subject_code"));
            attendance.put("subject_type", rs.getString("subject_type"));
            attendance.put("branch", rs.getString("branch"));
            attendance.put("semester", rs.getInt("semester"));
        }
        return attendance;
    }

    //add_attendance
    public boolean add_attendance(String facultyId, String studentsList, int classTimeTableId, String lectureDate) throws SQLException {
        String query = "INSERT INTO student_attendance (faculty_id, present_student_list, class_time_table_id, lecture_date) VALUES(?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, facultyId);
        stmt.setString(2, studentsList);
        stmt.setInt(3, classTimeTableId);
        stmt.setString(4, lectureDate);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }

    ////////////------------------------------------------------------------------------////////////////////////
    // Total Count
    public int get_total_student_count() throws SQLException {
        String query = "SELECT COUNT(*) From users WHERE user_role = 'student'";
        PreparedStatement stmt = conn.prepareStatement(query);
        ResultSet resultSet = stmt.executeQuery();
        if (resultSet.next()) {
            return resultSet.getInt(1);
        }
        return 0;
    }

    public int get_total_faculty_count() {
        String query = "SELECT COUNT(*) FROM users WHERE user_role = 'faculty'";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
//            e.printStackTrace();
            System.out.println(e.toString());
        }

        return 0;
    }

    public int get_total_courses_count() {
        String query = "SELECT COUNT(*) FROM course_details";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
//            e.printStackTrace();
            System.out.println(e.toString());
        }

        return 0;
    }

    public int get_total_notices_count() {
        String query = "SELECT COUNT(*) FROM notices";

        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            ResultSet resultSet = stmt.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.toString());
        }

        return 0;
    }

    // change semester for all student
    public boolean change_semester(int newSemester, String branch, int current_semester) throws SQLException {
        String query = "UPDATE pre_student_register SET current_semester = ? WHERE branch = ? AND current_semester = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setInt(1, newSemester);
        stmt.setString(2, branch);
        stmt.setInt(3, current_semester);
        int rowsAffected = stmt.executeUpdate();
        return rowsAffected > 0;
    }
//}

// Check is When we add new course first is check database in exit or not
    public boolean isCourseExists(String subjectCode, String subjectName) {
        String checkQuery = "SELECT * FROM course_details WHERE subject_code = ? OR subject_name = ?";
        try {
            PreparedStatement preparedStatement = conn.prepareStatement(checkQuery);
            preparedStatement.setString(1, subjectCode);
            preparedStatement.setString(2, subjectName);
            ResultSet resultSet = preparedStatement.executeQuery();
            return resultSet.next(); // Returns true if a record exists
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Assume course doesn't exist if there's an error
    }
//}

    // Check for timetable conflicts
//    public boolean hasTimetableConflict(String day, String timestart, String timeend, String branch, int semester) {
//        try {
//            // Create a SQL query to check for conflicts
//            String query = "SELECT * FROM class_time_table " +
//                           "WHERE day = ? " +
//                           "AND ((time_start <= ? AND time_end >= ?) " +
//                           "OR (time_start <= ? AND time_end >= ?)) " +
//                           "AND branch = ? AND semester = ?";
//
//            PreparedStatement preparedStatement = conn.prepareStatement(query);
//            preparedStatement.setString(1, day);
//            preparedStatement.setString(2, timestart);
//            preparedStatement.setString(3, timestart);
//            preparedStatement.setString(4, timeend);
//            preparedStatement.setString(5, timeend);
//            preparedStatement.setString(6, branch);
//            preparedStatement.setInt(7, semester);
//
//            ResultSet resultSet = preparedStatement.executeQuery();
//
//            return resultSet.next(); // If there is a result, a conflict exists
//
//        } catch (SQLException e) {
//            e.printStackTrace();
//            // Handle the exception (e.g., log it or throw a custom exception)
//            return false;  // Assume no conflict if there's an exception
//        }
//    }
//public boolean hasTimetableConflict(String day, String timestart, String timeend, String branch, int semester) {
//    try {
//        // Create a SQL query to check for conflicts
//        String query = "SELECT COUNT(*) FROM class_time_table " +
//                       "WHERE day = ? " +
//                       "AND ((? BETWEEN time_start AND time_end) OR (? BETWEEN time_start AND time_end)) " +
//                       "AND branch = ? AND semester = ?";
//
//        PreparedStatement preparedStatement = conn.prepareStatement(query);
//        preparedStatement.setString(1, day);
//        preparedStatement.setString(2, timestart);
//        preparedStatement.setString(3, timeend);
//        preparedStatement.setString(4, branch);
//        preparedStatement.setInt(5, semester);
//
//        ResultSet resultSet = preparedStatement.executeQuery();
//        resultSet.next();
//        int count = resultSet.getInt(1);
//
//        return count > 0; // If count is greater than 0, a conflict exists
//
//    } catch (SQLException e) {
//        e.printStackTrace();
//        // Handle the exception (e.g., log it or throw a custom exception)
//        return false;  // Assume no conflict if there's an exception
//    }
    public boolean hasTimetableConflict(String day, String timestart, String timeend, String branch, int semester) {
        try {
            // Create a SQL query to check for conflicts
            String query = "SELECT COUNT(*) FROM class_time_table "
                    + "WHERE day = ? "
                    + "AND ((? < time_start AND ? < time_start) OR (? > time_end AND ? > time_end)) "
                    + "AND branch = ? AND semester = ?";

            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, day);
            preparedStatement.setString(2, timeend); // New time slot's start
            preparedStatement.setString(3, timestart); // New time slot's end
            preparedStatement.setString(4, timestart); // New time slot's start
            preparedStatement.setString(5, timeend); // New time slot's end
            preparedStatement.setString(6, branch);
            preparedStatement.setInt(7, semester);

            ResultSet resultSet = preparedStatement.executeQuery();
            resultSet.next();
            int count = resultSet.getInt(1);

            return count > 0; // If count is greater than 0, a conflict exists

        } catch (SQLException e) {
            e.printStackTrace();
            // Handle the exception (e.g., log it or throw a custom exception)
            return false;  // Assume no conflict if there's an exception
        }
    }

    public List<String> getSemesters(String branch) throws SQLException {
        List<String> semesters = new ArrayList<>();

        // Replace the following code with your database connection logic
        String q = "Select current_semester from pre_student_register where branch=?";
        PreparedStatement preparedStatement = conn.prepareStatement(q);
        preparedStatement.setString(1, branch);
        ResultSet resultSet = preparedStatement.executeQuery();

        while (resultSet.next()) {
            int semester = resultSet.getInt("current_semester");
//            semesters.add(Integer.toString(semester)); // Convert to string
            semesters.add(String.valueOf(semester));
        }
        return semesters;
    }
//}

    // get Branch to all studetns email id to send notice also
    public List<String> getBranchEmails(String studentBranch) throws SQLException {
        List<String> emailList = new ArrayList<>();
        // SQL query to retrieve email addresses for a specific branch
        String query = "SELECT email FROM pre_student_register WHERE branch = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, studentBranch);
        ResultSet resultSet = preparedStatement.executeQuery();

        // Retrieve email addresses and add them to the list
        while (resultSet.next()) {
            String email = resultSet.getString("email");
            emailList.add(email);
        }
        return emailList;
    }
//}

    public boolean checkEmailExists(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM user_verification WHERE user_email = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, email);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            int count = resultSet.getInt(1);
            return count > 0; // If count > 0, the email exists
        }
        return false;
    }
//}

    public int updatePassword(String email, String newPassword) throws SQLException {

        // SQL query to update the user's password based on their email
        String query = "UPDATE pre_student_register SET password = ? WHERE email = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, newPassword);
        preparedStatement.setString(2, email);
        int rowsUpdated = preparedStatement.executeUpdate();
        if (rowsUpdated > 0) {
            // Password updated successfully
            System.out.println("Password updated for email: " + email);
        } else {
            // Handle the case where no rows were updated (email not found)
            System.out.println("Password update failed: Email not found.");
        }
        return rowsUpdated;
    }

    public String getStudentIdByEmail(String email) {
        try {
            String query = "SELECT student_id FROM pre_student_register WHERE email = ?";
            PreparedStatement preparedStatement = conn.prepareStatement(query);
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getString("student_id"); // Return the student_id if the email exists
            }
            return null;// Return null to indicate that the email doesn't exist
        } catch (SQLException e) {
            e.printStackTrace(); // You can log or handle the exception as needed
        }
        return null;
    }

    public int updatePasswor(String studentId, String newPassword) throws SQLException {
        // SQL query to update the user's password based on their userid
        String query = "UPDATE users SET user_password = ? WHERE user_id = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, newPassword);
        preparedStatement.setString(2, studentId);
        int rowsUpdated = preparedStatement.executeUpdate();
        if (rowsUpdated > 0) {
            // Password updated successfully
            System.out.println("Password updated for userid: " + studentId);
        } else {
            // Handle the case where no rows were updated (email not found)
            System.out.println("Password update failed: studentId not found.");
        }
        return rowsUpdated;
    }
//
//    public boolean isAttendanceTaken(String lectureId) throws SQLException {
//    // Assuming you have a database connection or data source set up
//
//        // Use a SQL query to check if attendance is recorded for the given lecture ID
//        String query = "SELECT COUNT(*) FROM student_attendance WHERE lecture_id = ?";
//
//        PreparedStatement statement = conn.prepareStatement(query);
//        statement.setString(1, lectureId);
//
//        ResultSet resultSet = statement.executeQuery();
//
//        if (resultSet.next()) {
//            int count = resultSet.getInt(1);
//            return count > 0; // If count > 0, attendance has been taken
//        }
//        return false;
//    }

    public boolean checkIdExists(String id) throws SQLException {
        String query = "SELECT COUNT(*) FROM users WHERE user_id = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, id);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            int count = resultSet.getInt(1);
            return count > 0; // If count > 0, the email exists
        }
        return false;
    }

//    public boolean checkBranchExists(String studentid,String branch) throws SQLException {
//        String query = "SELECT COUNT(*) FROM pre_student_register WHERE student_id=? AND branch = ?";
//        PreparedStatement preparedStatement = conn.prepareStatement(query);
//        preparedStatement.setString(1, studentid);
//        preparedStatement.setString(2, branch);
//        ResultSet resultSet = preparedStatement.executeQuery();
//        if (resultSet.next()) {
//            int count = resultSet.getInt(1);
//            return count > 0; // If count > 0, the email exists
//        }
//        return false;
//    }
    public boolean checkBranchExists(String studentid, String branch) throws SQLException {
        String query = "SELECT COUNT(*) FROM pre_student_register WHERE student_id = ? AND branch = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, studentid);
        preparedStatement.setString(2, branch);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            int count = resultSet.getInt(1);
            return count > 0; // If count > 0, the student and branch combination exists
        }
        return false;
    }

    public boolean checkResultsExist(String studentid, int sem) throws SQLException {
        String query = "SELECT COUNT(*) FROM results WHERE student_id = ? AND semester =?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, studentid);
        preparedStatement.setInt(2, sem);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            int count = resultSet.getInt(1);
            return count > 0; // If count > 0, the result exists
        }
        return false;
    }

    // Method to get subject marks
    public Map<String, Object> getSubjectMarks(String studentId, int sem, String subjectCode) throws SQLException {
        Map<String, Object> subjectMarks = new HashMap<>();
        String query = "SELECT internal_obtained_marks, external_obtained_marks "
                + "FROM results "
                + "INNER JOIN course_details ON results.subject_id = course_details.sid "
                + "WHERE results.student_id = ? AND results.semester = ? AND course_details.subject_code = ?";
        PreparedStatement stmt = conn.prepareStatement(query);
        stmt.setString(1, studentId);
        stmt.setInt(2, sem);
        stmt.setString(3, subjectCode);
        ResultSet rs = stmt.executeQuery();
        if (rs.next()) {
            int internalMarks = rs.getInt("internal_obtained_marks");
            int externalMarks = rs.getInt("external_obtained_marks");
            subjectMarks.put("internal_obtained_marks", internalMarks);
            subjectMarks.put("external_obtained_marks", externalMarks);
        }
        return subjectMarks;
    }

    public int getSubjectIdBySubjectCode(String subjectCode) throws SQLException {
        int subjectId = -1; // Initialize to a default value (e.g., -1) for not found
        String query = "SELECT subject_id FROM results WHERE subject_id = (SELECT sid FROM course_details WHERE subject_code = ? LIMIT 1)";
        PreparedStatement preparedStatement = conn.prepareStatement(query);
        preparedStatement.setString(1, subjectCode);

        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            subjectId = resultSet.getInt("subject_id");
        }

        resultSet.close();
        preparedStatement.close();

        return subjectId;
    }

    // Method to update student marks
    public int updateMarks(String studentId, int internalMarks, int externalMarks, String subjectid) throws SQLException {
        String updateQuery = "UPDATE results SET internal_obtained_marks = ?, external_obtained_marks = ? WHERE student_id = ? AND subject_id=?";
        PreparedStatement preparedStatement = conn.prepareStatement(updateQuery);
        preparedStatement.setInt(1, internalMarks);
        preparedStatement.setInt(2, externalMarks);
        preparedStatement.setString(3, studentId);
        preparedStatement.setString(4, subjectid);

        // Execute the update query
        int rowsUpdated = preparedStatement.executeUpdate();

        // Return the number of rows updated
        return rowsUpdated;
    }

    public Map<String, Integer> getMarkRanges(String subjectCode) throws SQLException {
        Map<String, Integer> markRanges = new HashMap<>();
        // SQL query to fetch internal and external marks based on the subjectCode
        String sql = "SELECT subject_internal_marks, subject_external_marks FROM course_details WHERE subject_code = ?";

        PreparedStatement preparedStatement = conn.prepareStatement(sql);
        preparedStatement.setString(1, subjectCode);

        ResultSet resultSet = preparedStatement.executeQuery();

        if (resultSet.next()) {
            markRanges.put("internalMax", resultSet.getInt("subject_internal_marks"));
            markRanges.put("externalMax", resultSet.getInt("subject_external_marks"));
        }
        return markRanges;
    }

    // Method to get a timetable entry by its ID
    public Map<String, Object> getTimetableEntryById(int timeTableId) throws SQLException {
        Map<String, Object> timetableEntry = new HashMap<>();
        String query = "SELECT * FROM class_time_table WHERE id = ?";
        PreparedStatement preparedStatement = conn.prepareStatement(query);

        preparedStatement.setInt(1, timeTableId);
        ResultSet resultSet = preparedStatement.executeQuery();
        if (resultSet.next()) {
            timetableEntry.put("id", resultSet.getInt("id"));
            timetableEntry.put("day", resultSet.getString("day"));
            timetableEntry.put("subject_id", resultSet.getInt("subject_id"));
            timetableEntry.put("time_start", resultSet.getString("time_start"));
            timetableEntry.put("time_end", resultSet.getString("time_end"));
            timetableEntry.put("branch", resultSet.getString("branch"));
            timetableEntry.put("semester", resultSet.getInt("semester"));
            timetableEntry.put("venue", resultSet.getString("venue"));
        }
        return timetableEntry;
    }

    // Update timetable in the database
    public boolean update_class_time_table(String day, int subject, String timeStart, String timeEnd,  String venue,int timeTableId) throws SQLException {
        // Prepare the SQL query
        String query = "UPDATE class_time_table SET day=?,subject_id=?,time_start=?, time_end=?, venue=? WHERE id=?";
        PreparedStatement ps = conn.prepareStatement(query);
        // Set the parameters
        ps.setString(1, day);
        ps.setInt(2, subject);
        ps.setString(3, timeStart);
        ps.setString(4, timeEnd);
//        ps.setString(5, branch);
//        ps.setInt(6, semester);
        ps.setString(5, venue);
        ps.setInt(6, timeTableId);
        // Execute the update query
        int rowsUpdated = ps.executeUpdate();
        return rowsUpdated > 0;
    }

}
