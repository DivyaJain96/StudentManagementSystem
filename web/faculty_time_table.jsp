<%-- 
    Document   : faculty_time_table
    Created on : 5 Jun, 2023, 8:37:59 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mca.MainClass"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%            if (session != null && session.getAttribute("current_userid") != null && session.getAttribute("current_userrole") != null) {
                if (session.getAttribute("current_userrole").equals("faculty")) {
                    MainClass obj = new MainClass();
                    String faculty_id = (String) session.getAttribute("current_userid");
//                    out.print(faculty_id);
        %>

        <table class="container table alert-warning my-5 shadow text-center">
            <tr class="text-center alert-info text-danger">
                <th colspan="4" class="p-4">
                    <%
                        String searchDay = null;
                        if (request.getParameter("search_day") != null) {
                            searchDay = request.getParameter("search_day");
                            out.println("Date: " + searchDay);
                        } else {
                            String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
                            out.println("Date: " + currentDate);
                        }
                    %>
                </th>
                <th colspan="1" class="p-4">
                    <%
                        if (searchDay != null) {
                            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                            Date date = sdf.parse(searchDay);
                            sdf.applyPattern("EEEE");
                            out.println("Day: " + sdf.format(date));
                        } else {
                            SimpleDateFormat sdf = new SimpleDateFormat("EEEE");
                            Date date = new Date();
                            out.println("Day: " + sdf.format(date));
                        }
                    %>
                </th>
                <th colspan="1">
            <form action="" method="post" class="row mx-auto p-3">
                <div class="col-md-9 px-1">
                    <input type="date" name="search_day" class="form-control" required>
                </div>
                <button type="submit" name="search_btn" value="Search" class="btn btn-dark btn-sm col-md-3">
                    <i class="fa fa-search" aria-hidden="true" style="font-size:20px ;"></i>
                </button>
            </form>
        </th>
    </tr>
    <tr class="alert-primary">
        <th style="text-align: center;">Time</th>
        <th style="text-align: center;">Branch</th>
        <th style="text-align: center;">Semester</th>
        <th style="text-align: center;">Venue</th>
        <th style="text-align: center;">Subject</th>
        <th>Action</th>
    </tr>
    <%
        List<Map<String, Object>> time_table = new ArrayList<Map<String, Object>>();
        if (request.getParameter("search_btn") != null) {
            String date = request.getParameter("search_day");
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String day = new SimpleDateFormat("EEEE").format(dateFormat.parse(date));
            time_table = obj.get_faculty_time_table(faculty_id, day);
        } else {
            String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            String day = new SimpleDateFormat("EEEE").format(new Date());
            time_table = obj.get_faculty_time_table(faculty_id, day);
        }

        if (searchDay != null) {

            if (time_table != null && !time_table.isEmpty()) {
                for (Map<String, Object> tt : time_table) {

                    String date = request.getParameter("search_day");
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    Date selectedDate = dateFormat.parse(date);
                    Date currentDate = new Date();
                    String selectedDates = dateFormat.format(selectedDate);
                    String currentDates = dateFormat.format(currentDate);
//                    out.println(selectedDates);
//                    out.println(currentDates);
//                    out.println(date);/
//                    out.println(currentDate);
                    if (selectedDates.equals(currentDates)) {
//                        out.println("Both dates are the same.");

//                        out.println("Selected Date: " + dateFormat.format(selectedDate));
//                        out.println("Current Date: " + dateFormat.format(currentDate));


    %>

    <tr>
        <td style="text-align:center;"><%= tt.get("time_start") + "-" + tt.get("time_end")%></td>
        <td style="text-align:center;"><%= tt.get("branch")%></td>
        <td style="text-align:center;"><%= tt.get("semester")%></td>
        <td style="text-align:center;"><%= tt.get("venue")%></td>
        <td style="text-align:center;"><%= tt.get("subject_code") + "/ " + tt.get("subject_name") + "/ " + tt.get("subject_type")%></td>
        <td class="text-center">
            <form action="add_attendance.jsp" method="post">
                <input type="hidden" name="lecture_id" value="<%= tt.get("id")%>">
                <input type="hidden" name="lecture_date" value="<%= searchDay != null ? searchDay : new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
                <input type="hidden" name="branch" value="<%= tt.get("branch")%>">
                <input type="hidden" name="subject_id" value="<%= tt.get("subject_id")%>">
                <input type="hidden" name="semester" value="<%= tt.get("semester")%>">
                <button type="submit" name="add_attendanc" class="btn btn-dark">Take Attendance</button>
            </form>
        </td>

    </tr>
    <%
    } else if (selectedDate.before(currentDate)) {
//        out.println("The selected date is before the current date.");%>

    <tr>
        <td style="text-align:center;"><%= tt.get("time_start") + "-" + tt.get("time_end")%></td>
        <td style="text-align:center;"><%= tt.get("branch")%></td>
        <td style="text-align:center;"><%= tt.get("semester")%></td>
        <td style="text-align:center;"><%= tt.get("venue")%></td>
        <td style="text-align:center;"><%= tt.get("subject_code") + "/ " + tt.get("subject_name") + "/ " + tt.get("subject_type")%></td>
        <td class="text-center">
            <form action="add_attendance.jsp" method="post">
                <input type="hidden" name="lecture_id" value="<%= tt.get("id")%>">
                <input type="hidden" name="lecture_date" value="<%= searchDay != null ? searchDay : new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
                <input type="hidden" name="branch" value="<%= tt.get("branch")%>">
                <input type="hidden" name="subject_id" value="<%= tt.get("subject_id")%>">
                <input type="hidden" name="semester" value="<%= tt.get("semester")%>">
                <button type="submit" name="add_attendanc" class="btn btn-dark">Take Attendance</button>
            </form>
        </td>

    </tr>
    <%} else {
//        out.println("The selected date is after the current date.");%>

    <tr>
        <td style="text-align:center;"><%= tt.get("time_start") + "-" + tt.get("time_end")%></td>
        <td style="text-align:center;"><%= tt.get("branch")%></td>
        <td style="text-align:center;"><%= tt.get("semester")%></td>
        <td style="text-align:center;"><%= tt.get("venue")%></td>
        <td style="text-align:center;"><%= tt.get("subject_code") + "/ " + tt.get("subject_name") + "/ " + tt.get("subject_type")%></td>
        <td class="text-center">
            <form action="add_attendance.jsp" method="post">
                <input type="hidden" name="lecture_id" value="<%= tt.get("id")%>">
                <input type="hidden" name="lecture_date" value="<%= searchDay != null ? searchDay : new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
                <input type="hidden" name="branch" value="<%= tt.get("branch")%>">
                <input type="hidden" name="subject_id" value="<%= tt.get("subject_id")%>">
                <input type="hidden" name="semester" value="<%= tt.get("semester")%>">
                <!--<button type="submit" name="add_attendanc" class="btn btn-dark">Take Attendance</button>-->
                <button type="button" class="btn btn-dark" onclick="showFutureDateMessage()">Take Attendance</button>
            </form>
        </td>

    </tr>


    <%
            }
        }
    } else {
    %>
    <tr>
        <td colspan="6" style="color: red;text-align:center">
            Schedule not found 
            <% if (request.getParameter("search_day") != null) {%>
            <%= request.getParameter("search_day")%>
            <% }%>
        </td>
    </tr>
    <%
        }
    } else {
        if (time_table != null && !time_table.isEmpty()) {
            for (Map<String, Object> tt : time_table) {
                String currentDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
    %>

    <tr>
        <td style="text-align:center;"><%= tt.get("time_start") + "-" + tt.get("time_end")%></td>
        <td style="text-align:center;"><%= tt.get("branch")%></td>
        <td style="text-align:center;"><%= tt.get("semester")%></td>
        <td style="text-align:center;"><%= tt.get("venue")%></td>
        <td style="text-align:center;"><%= tt.get("subject_code") + "/ " + tt.get("subject_name") + "/ " + tt.get("subject_type")%></td>
        <td class="text-center">
            <form action="add_attendance.jsp" method="post">
                <input type="hidden" name="lecture_id" value="<%= tt.get("id")%>">
                <input type="hidden" name="lecture_date" value="<%= searchDay != null ? searchDay : new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>">
                <input type="hidden" name="branch" value="<%= tt.get("branch")%>">
                <input type="hidden" name="subject_id" value="<%= tt.get("subject_id")%>">
                <input type="hidden" name="semester" value="<%= tt.get("semester")%>">
                <button type="submit" name="add_attendanc" class="btn btn-dark">Take Attendance</button>
            </form>
        </td>
    </tr>
    <%
        }
    } else {
    %>
    <tr>
        <td colspan="6" style="color: red;text-align:center">
            Schedule not found 
            <% if (request.getParameter("search_day") != null) {%>
            <%= request.getParameter("search_day")%>
            <% }%>
        </td>
    </tr>
    <%
            }
        }
    %>
</table>
<%        }
    }

%>
</body>
</html>
<%@include file="footer.jsp"%>
<script>
    function showFutureDateMessage() {
        alert("You cannot take attendance for a future date.");
    }
</script>