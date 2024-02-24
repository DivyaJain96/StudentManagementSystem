<%-- 
    Document   : add_attendance
    Created on : 5 Jun, 2023, 8:40:11 PM
    Author     : Divya Kumar Jain
--%>


<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="mca.MainClass" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%    MainClass obj = new MainClass();

            if (request.getParameter("add_attendanc") != null) {

                String faculty_id = (String) session.getAttribute("current_userid");
//                out.println(faculty_id);
//                int lecture_id = Integer.parseInt(request.getParameter("lecture_id"));
                try {
//                    int lecture_id = Integer.parseInt(request.getParameter("lecture_id"));
//                    int lecture_id = Integer.parseInt(request.getParameter("sid"));
//                int lecture_id = Integer.parseInt(request.getParameter("id"));
                    int lecture_id = Integer.parseInt(request.getParameter("lecture_id"));
//                    out.println(lecture_id);
                    String lecture_date = request.getParameter("lecture_date");
//                    out.println(lecture_date);
                    int subject_id = Integer.parseInt(request.getParameter("subject_id"));
//                    out.println(subject_id);
                    Map<String, Object> subject = obj.get_subject_by_sid(subject_id);
//                    out.println(subject);
                    String branch = request.getParameter("branch");
//                    out.println(branch);
                    int semester = Integer.parseInt(request.getParameter("semester"));
//                    out.println(semester);
//                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
//                    Date selectedDate = dateFormat.parse(lecture_date);
//                    Date currentDateObj = new Date();

                    // Check if the selected date is in the past
//                    if (selectedDate.before(currentDateObj)) {
                    // Check if attendance is already taken or not
                    Map<String, Object> check_attendance = obj.get_attendance(faculty_id, lecture_id, lecture_date);
//                    out.println(check_attendance);
                    if (check_attendance != null && !check_attendance.isEmpty()) {
//                        out.println(semester);
//                        out.println(check_attendance.get("faculty_id"));
//                        out.println(check_attendance.get("id"));
%>  
        <div class="container my-5">
            <div class="alert alert-danger" role="alert">
                Attendance is already taken !!
                <a href="faculty_time_table.jsp" class="btn btn-dark">back</a>
                <hr>
                <form action="download_student_attendance.jsp" method="post">
                    <input type="hidden" name="attendance_id" value="
                           <%= check_attendance.get("id")%>">
                    <button type="submit" name="download_attendanc" class="btn btn-dark my-2">
                        Download Attendance
                    </button>
                </form>
            </div>
        </div>
        <%
        } else {

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date selectedDate = dateFormat.parse(lecture_date);
            Date currentDate = new Date();

            String selectedDates = dateFormat.format(selectedDate);
            String currentDates = dateFormat.format(currentDate);
//            out.println(selectedDates);
//            out.println(currentDates);

//            out.println(lecture_date);
//            out.println(currentDate);
//        
            if (selectedDates.equals(currentDates)) {
//                out.println("Both dates are the same.");

//                out.println("Selected Date: " + dateFormat.format(selectedDate));
//                out.println("Current Date: " + dateFormat.format(currentDate));

        %>


        <%//            out.println(check_attendance.get("id"));
//            out.println(check_attendance.get("lecture_id"));
//            }
//        } else {
            List<Map<String, Object>> students = obj.get_students_by_branch_and_semester(branch, semester);
        %>
        <form action="" method="post">
            <table class="table container my-5 shadow">
                <tr class="alert-info text-danger text-center">
                    <th>Date : <%= lecture_date%></th>
                    <th>Branch : <%= branch%></th>
                    <th>Subject :
                        <%= subject.get("subject_code")%> / <%= subject.get("subject_name")%> / <%= subject.get("subject_type")%>
                    </th>
                    <th>Semester : <%= semester%></th>
                </tr>
                <tr class="alert-primary">
                    <th></th>
                    <th style="text-align: center;">Student Id</th>
                    <th style="text-align: center;">Student Name</th>
                    <th style="text-align: center;"></th>
                </tr>
                <% if (students != null && !students.isEmpty()) {
                        for (Map<String, Object> student : students) {
                            Map<String, Object> studentDetails = obj.get_student_details((String) student.get("student_id"));
                %>
                <tr class="alert-warning">
                    <td class="text-center">
                        <% if (studentDetails.get("profile_pic") != null && !studentDetails.get("profile_pic").toString().isEmpty()) {%>
                        <img class="shadow rounded" style="width:50px;height:50px;"
                             src="<%= studentDetails.get("profile_pic")%>" alt="">
                        <% } else {%>
                        <!-- Show a demo profile picture if no profile picture is available -->
                        <img class="shadow rounded" style="width:50px;height:50px;"
                             src="site_img\default.png" alt="">
                        <% }%>
                    </td>
                    <td style="text-align: center;">
                        <%= student.get("student_id")%>
                    </td>
                    <td style="text-align: center;">
                        <%= student.get("first_name") + " " + student.get("middle_name") + " " + student.get("last_name")%>
                    </td>
                    <td style="text-align: left;">
                        <input type="checkbox" class="form-check-input" name="student_list[]"
                               value="<%= student.get("student_id")%>">
                    </td>
                </tr>
                <% }

//                } else {
//                    String status = "disabled";
//                    out.println('<tr class="alert-warning">
//                    <td colspan="4" class =" text-center text-danger h6">No Data Found</td>
//                    </tr>');
                    }

                %>
                <tr class="alert-info">
                    <td colspan="4" style="text-align: right;">
                        <input type="hidden" name="lecture_id" value="<%= lecture_id%>">
                        <input type="hidden" name="lecture_date" value="<%= lecture_date%>">
                        <input type="hidden" name="branch" value="<%= branch%>">
                        <input type="hidden" name="subject_id" value="<%= subject_id%>">
                        <input type="hidden" name="semester" value="<%= semester%>">
                        <button type="submit" name="save_attendance" class="btn btn-dark" <% if (students == null || students.isEmpty()) { %> disabled <% } %>>
                            Save
                        </button>
                        <a href="faculty_time_table.jsp" class="btn btn-dark">Back</a>
                    </td>
                </tr>
            </table>
        </form>
        <%
        } else if (selectedDate.before(currentDate)) {
//            out.println("The selected date is before the current date.");
        %>
        <div class="container my-5">
            <div class="alert alert-danger" role="alert">
                You cannot take attendance for a past date.
                <a href="faculty_time_table.jsp">Back</a>
            </div>
        </div>
        <%}

                    }
                } catch (NumberFormatException e) {
                    out.println("Invalid lecture ID");
                }
            }

            if (request.getParameter("save_attendance") != null) {
                int lecture_ids = Integer.parseInt(request.getParameter("lecture_id"));
                String lecture_dates = request.getParameter("lecture_date");
                String subject_ids = request.getParameter("subject_id");
                String branchs = request.getParameter("branch");
                String semeste = request.getParameter("semester");
                String faculty_ids = (String) session.getAttribute("current_userid");
//                String[] student_list = request.getParameterValues("student_list");
//                String students_list = String.join(",", student_list);
//                String students_list = " ";
//                = String.join(",", student_list);
                String[] studentListArray = request.getParameterValues("student_list[]");
                StringBuilder students_list = new StringBuilder();
                for (int i = 0; i < studentListArray.length; i++) {
                    students_list.append(studentListArray[i]);

                    if (i < studentListArray.length - 1) {
                        students_list.append(",");
                    }
                }
                String s = students_list.toString();
//                String students_list = String.join(",", studentListArray);
                boolean attendance = obj.add_attendance(faculty_ids, s, lecture_ids, lecture_dates);

                if (attendance) {
        %>
        <div class="alert alert-success" role="alert">
            <script>alert('Attendance added successfully')</script>
            <script>window.location.href = 'http://localhost:8080/mcaproject/faculty_time_table.jsp'</script>
        </div>
        <%
        } else {
        %>
        <div class="alert alert-danger" role="alert">
            Something went wrong!!
            <a href="faculty_time_table.jsp">please try again</a>
        </div>
        <%
                }
            }
        %>

        <%
            // Check attendance is added or not
            // function get_attendance_for_faculty(lecture_date, branch, subject_id, semester);
            // Get student by sem and semester
%>

    </body>
</html>
<%@ include file="footer.jsp" %>