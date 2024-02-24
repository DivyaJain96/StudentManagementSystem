<%-- 
    Document   : class_time_table
    Created on : 7 Jun, 2023, 9:11:25 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mca.MainClass" %>
<%@ include file="header.jsp" %>
<%@ page session="true" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>        
        <div class="container">
            <table class="table table-striped container shadow my-5"> 
                <tr class="alert-info text-danger text-uppercase">
                    <th colspan="2" class="py-3">
                        <%                              if (request.getParameter("search_day") != null) {
                                out.println("Date: " + request.getParameter("search_day"));
                            } else {
                                out.println("Date: " + new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
                            }
                        %>
                    </th>
                    <th class="py-3">
                        <%
                            if (request.getParameter("search_day") != null) {
                                String searchDay = request.getParameter("search_day");
                                Date date = new SimpleDateFormat("yyyy-MM-dd").parse(searchDay);
                                SimpleDateFormat sdf2 = new SimpleDateFormat("EEEE");
                                String dayOfWeek = sdf2.format(date);
                                out.println("Day: " + dayOfWeek);
                            } else {
                                out.println("Day: " + new SimpleDateFormat("EEEE").format(new Date()));
                            }
                        %>
                    </th>
                    <th style="text-align: right;" colspan=2>

                <form action="" method="post" class="row mx-auto">
                    <div class="col-md-9">
                        <input type="date" name="search_day" class="form-control col" required>
                    </div>
                    <button type="submit" name="search_btn"  style="height:30px" value="Search" class="col-md-3 btn btn-dark btn-sm my-1">
                        <i class="fa fa-search" aria-hidden="true"></i>
                </form>
                </th>
                </tr>
                <%
                    MainClass obj = new MainClass();
                    String today = new SimpleDateFormat("EEEE").format(new Date());
//                    String current_student_id = (String)session.getAttribute("current_userid");
//                    out.println(session.getAttribute("current_userid"));
                    String currentStudentId = (String) session.getAttribute("current_userid");
//                    String currentUserRole = (String) session.getAttribute("current_userrole");
                    String current_user_role = (String) session.getAttribute("current_userrole");
//                    out.println(current_user_role);
                    HashMap<String, Object> current_student = obj.get_student_by_userid(currentStudentId);

                    String current_student_branch = current_student.get("branch").toString().toLowerCase();
//                    out.println(current_student_branch);
                    int current_student_sem = Integer.parseInt(current_student.get("current_semester").toString());
//                    out.println(current_student_sem);

                    List<Map<String, Object>> time_table;

                    String search_day = request.getParameter("search_day");
                    if (search_day != null) {
                        java.util.Date date = new java.text.SimpleDateFormat("yyyy-MM-dd").parse(search_day);
                        String search_day_lower = new java.text.SimpleDateFormat("EEEE").format(date).toLowerCase();
                        time_table = obj.get_time_table_by_day(current_student_branch, current_student_sem, search_day_lower);
                    } else {
                        time_table = obj.get_time_table_by_day(current_student_branch, current_student_sem, today);
                    }
                %>

                <tr class="alert-primary">
                    <th style="text-align:center ;">Time</th>
                    <th style="text-align:center ;">Faculty</th>
                    <th style="text-align:center ;">Course</th>
                    <th style="text-align:center ;">Venue</th>
                    <th style="text-align: center;">Attendance Status</th>
                </tr>
                <%
                    // Display time table
                    if (time_table != null && !time_table.isEmpty()) {
                        for (Map<String, Object> row : time_table) {
                            // Get faculty details
                            Map<String, Object> faculty = obj.get_faculty((String) row.get("faculty_id"));
                %>
                <tr class="alert-warning">
                    <td style="text-align:center ;"><%= row.get("time_start")%> - <%= row.get("time_end")%></td>
                    <td style="text-align:center ;">
                        <%= faculty.get("faculty_nam")%> <%=faculty.get("faculty_na")%> <%= faculty.get("faculty_name")%>
                    </td>
                    <td style="text-align:center ;"><%= row.get("subject_code")%> / <%= row.get("subject_name")%> / <%= row.get("subject_type")%></td>
                    <td style="text-align:center ;"><%= row.get("venue")%></td>
                    <td style="text-align:center ;">
                        <%
                            // Get lecture attendance
                            Map<String, Object> attendance = null;
                            if (request.getParameter("search_day") != null) {
                                String searchDay = request.getParameter("search_day");
                                attendance = obj.get_attendance(row.get("faculty_id").toString(), Integer.parseInt(row.get("id").toString()), searchDay);
                            } else {
                                String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
                                attendance = obj.get_attendance(row.get("faculty_id").toString(), Integer.parseInt(row.get("id").toString()), currentDate);
                            }

                            // Check present or absent
                            if (attendance != null) {
                                String presentStudentList = (String) attendance.get("present_student_list");
                                if (presentStudentList != null) {
                                    String[] studentList = presentStudentList.split(",");
                                    boolean present = Arrays.asList(studentList).contains(currentStudentId);
                                    if (present) {
                                        out.println("<h3 style='color:green'>P</h3>");
                                    } else {
                                        out.println("<h3 style='color:red'>A</h3>");
                                    }
                                } else {
                                    out.println("----");
                                }
                            }
                        %>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>

                <tr class="alert-warning">
                    <td colspan="5" style="color: red;text-align:center">
                        Schedule not found for <%= (request.getParameter("search_day") != null) ? request.getParameter("search_day") : ""%>
                    </td>
                </tr>
                <%
                    }
                %>
            </table>
        </div>
    </body>
</html>
<%@ include file="footer.jsp" %>
