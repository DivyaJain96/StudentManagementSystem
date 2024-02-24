<%-- 
    Document   : update_time_table
    Created on : 23 Nov, 2023, 8:36:38 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%    MainClass obj = new MainClass();
    if (request.getParameter("update_timetable") != null) {

        String semesterParam = request.getParameter("semester");
        String subjectParam = request.getParameter("subject");
        String timeTableIdParam = request.getParameter("timeTableId");
        out.println(semesterParam);
        out.println(subjectParam);
        out.println(timeTableIdParam);
        if (semesterParam != null && subjectParam != null && timeTableIdParam != null) {
            int semester = Integer.parseInt(semesterParam);
            int subject = Integer.parseInt(subjectParam);
            int timeTableId = Integer.parseInt(timeTableIdParam);

            String day = request.getParameter("day");
            String timestart = request.getParameter("timestart");
            String timeend = request.getParameter("timeend");
            String venue = request.getParameter("venue");
            String branch = request.getParameter("branch");
//        int semester = Integer.parseInt(request.getParameter("semester"));
//        int subject = Integer.parseInt(request.getParameter("subject"));
//        int timeTableId = Integer.parseInt(request.getParameter("timeTableId"));

// Check for timetable conflicts
            boolean hasConflict = obj.hasTimetableConflict(day, timestart, timeend, branch, semester);
            if (hasConflict) {%>
<div class="alert alert-danger" role="alert">
    <script>alert("Timetable Conflict: A lecture is already scheduled at this time. Please choose a different time slot.");</script>
</div>
<%} else {
    boolean update_class_time_table = obj.update_class_time_table(day, subject, timestart, timeend, venue, timeTableId);
    if (update_class_time_table) {%>
<div class="alert alert-success" role="alert">
    <script>alert("Timetable updated successfully");
        window.location.href = "time_tables.jsp";
    </script>
</div>
<% } else {%>
<div class="alert alert-danger" role="alert">
    <%
        out.println("Oops! Something went wrong. Please try again later.");
    %>
</div>
<%
                }
            }
        } else {
            // Handle the case where one or more parameters are missing
            out.println("Invalid parameters. Please provide valid values for semester, subject, and timeTableId.");
        }
    }%>

<%@ include file="footer.jsp" %>
