<%-- 
    Document   : display_time_table
    Created on : 8 Jun, 2023, 7:23:08 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="mca.MainClass"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userrole").equals("admin")) {
                    MainClass obj = new MainClass();
                    String branch = "";
                    int semester = 0;

//                    List<Map<String, Object>> time_table = new ArrayList<>();
                    List<Map<String, Object>> time_table = new ArrayList<Map<String, Object>>();
                    if (request.getParameter("branch") != null && request.getParameter("semester") != null) {
                        branch = request.getParameter("branch");
                        semester = Integer.parseInt(request.getParameter("semester"));

                        time_table = obj.get_time_table(branch, semester);
                    } else {
                        time_table = obj.get_time_table(branch, semester);
                    }
//                    Integer.parseInt(request.getParameter("semester"));
//
//                    if (request.getParameter("branch") != null && request.getParameter("semester") != null) {
//                        String branch = request.getParameter("branch");
//                        int semester = Integer.parseInt(request.getParameter("semester"));
////                        String semester = request.getParameter("semester");
//
//                        List<Map<String, Object>> time_table = obj.get_time_table(branch, semester);
////                    } else {
//                        String branch = "";
//                        int semester = Integer.parseInt(" ");
//                        List<Map<String, Object>> time_table = obj.get_time_table(branch, semester);
//                    }

        %>
        <div class="container my-5">
            <table class="table table-hover text-start shadow">
                <tr class="alert-info text-danger text-uppercase">
                    <th colspan=3><%= "Branch : " + branch%></th>
                    <th colspan=4><%= "Semester : " + semester%></th>
                    <th colspan=2>
                <form action="" method="post">
                    <input type="hidden" name="branch" value="<%= branch%>">
                    <input type="hidden" name="semester" value="<%= semester%>">
                    <input type="submit" name="delete_tt" value="Delete" class="btn btn-danger btn-sm">&nbsp;
                    <a href="add_time_table.jsp" class="btn btn-dark btn-sm">Add TimeTable</a>
                </form>
                </th>
                </tr>
                <tr class="alert-primary">
                    <th>Day</th>
                    <th>Start Time</th>
                    <th>End Time</th>
                    <th>Subject Code</th>
                    <th>Subject Name</th>
                    <th>Type</th>
                    <th>Venue</th>
                    <th>Faculty</th>
                    <th>Edit</th>  
                </tr>
                <%
                    if (!time_table.isEmpty()) {
                        Date date = new Date();
                        SimpleDateFormat sdf = new SimpleDateFormat("d-M-yyyy");
                        String t = sdf.format(date);
                        String currentday = "";
                        if (t.equalsIgnoreCase("Thu")) {
                            currentday = "Thursday";
                        } else if (t.equalsIgnoreCase("Tue")) {
                            currentday = "Tuesday";
                        } else if (t.equalsIgnoreCase("Wed")) {
                            currentday = "Wednesday";
                        } else if (t.equalsIgnoreCase("Sat")) {
                            currentday = "Saturday";
                        } else {
                            currentday = "";
                        }
                        for (Map<String, Object> row : time_table) {
                %>
                <tr class="alert-warning">
                    <td class="text-uppercase <%= currentday.equals(row.get("day")) ? "text-danger h6" : ""%>">
                        <%= row.get("day")%>
                    </td>
                    <td><%= row.get("time_start")%></td>
                    <td><%= row.get("time_end")%></td>
                    <td><%= row.get("subject_code")%></td>
                    <td><%= row.get("subject_name")%></td>
                    <td><%= row.get("subject_type")%></td>
                    <td><%= row.get("venue")%></td>
                    <td><%= row.get("first_name") + " " + row.get("middle_name") + " " + row.get("last_name")%></td>
                    <!--<td><input type="submit" class="btn btn-dark" name="update_subject" value="Update"></td>-->
                    <td>
                        <form action="edit_time_table.jsp?subject_name=<%= row.get("subject_name")%>" method="post">
                            <input type="hidden" name="branch" value="<%= branch%>">
                            <input type="hidden" name="semester" value="<%= semester%>">
                            <input type="hidden" name="timeTableId" value="<%= row.get("id")%>">
                            <button type="submit" class="btn btn-dark btn-sm">Edit</button>
                        </form>
                    </td>
                </tr>
                <%
                    }
                } else {
                %>
                <tr>
                    <th colspan="7" style="text-align: center;color:red;">
                        Time Table not found
                    </th>
                </tr>
                <%
                    }

                %>
            </table>
        </div>
        <%                    if (request.getParameter("delete_tt") != null) {
                        String branc = request.getParameter("branch");
                        int semeste = Integer.parseInt(request.getParameter("semester"));
                        boolean delete_tt = obj.delete_time_table(branc, semeste);
                        if (delete_tt) {
                            out.println("<script>alert('Timetable deleted successfully.')</script>");
                            out.println("<script>window.location.href='http://localhost:8080/mcaproject/dashboard.jsp'</script>");
                        } else {
                            out.println("<script>alert('Oops! Something went wrong. Please try again later.');</script>");
                            out.println("<script>window.location.href='http://localhost:8080/mcaproject/display_time_table.jsp'</script>");
                        }

                    }
                }
            }
        %>

        <%@ include file="footer.jsp" %>

    </body>
</html>
