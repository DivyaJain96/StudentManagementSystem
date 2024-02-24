<%-- 
    Document   : results1
    Created on : 7 Jun, 2023, 9:15:52 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="mca.MainClass"%>
<%@include file="header.jsp" %>

<%    if (session.getAttribute("current_userid") != null) {
        if (session.getAttribute("current_userrole").equals("student")) {
            String current_student_id = (String) session.getAttribute("current_userid");
            String current_user_role = (String) session.getAttribute("current_userrole");

            if (current_user_role.equals("student")) {
                MainClass obj = new MainClass();
                Map<String, Object> current_student = obj.get_student_by_userid(current_student_id);
                List<Map<String, Object>> semesters = obj.get_semester(current_student_id);
%>
<div class="container mt-5">
    <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
        <form action="" method="post">
            <div class="row">
                <div class="col-md-4">
                    <label>Select Semester</label>
                    <div class="dropdown">
                        <select name="student_semester" class="form-control col-md-4" required="">
                            <%                                            for (Map<String, Object> sem : semesters) {
                            %>
                            <option value="<%= sem.get("semester")%>"
                                    <% if (request.getParameter("student_semester") != null) {
                                            if (request.getParameter("student_semester").equals(sem.get("semester"))) {
                                                out.println("selected");
                                            }
                                        }%>>
                                <%= sem.get("semester")%></option>

                            <%
                                }

                            %>
                        </select>
                    </div>
                </div>


            </div>
            <div class="row">
                <div class="col-md-4">
                    <button type="submit" name="show_results" class="btn btn-dark mt-4">Show</button>
                </div>
            </div>


        </form>

        <%            if (request.getParameter("show_results") != null) {
                int sem = Integer.parseInt(request.getParameter("student_semester"));
                //out.println(sem);
                List<Map<String, Object>> get_results = obj.getStudentResults(current_student_id, sem);
                int result_count = get_results.size();
                int total_marks = 0;
                int obtained_marks = 0;
                // Calculate CGPA
                double cgpa = 0.0; // Initialize CGPA to 0.0
        %>
        <table class="my-4 table table-hover text-center alert-info text-dark h6">
            <tr>
                <td class="text-end">Name </td>
                <td class="text-start">
                    <%= ":&nbsp;&nbsp;" + current_student.get("first_name") + " " + current_student.get("middle_name") + " " + current_student.get("last_name")%>
                </td>
                <td class="text-end">ID. No</td>
                <td class="text-start">
                    <%= ":&nbsp;&nbsp;" + current_student.get("student_id")%>
                </td>
            </tr>
            <tr>
                <td class="text-end">Program</td>
                <td class="text-start">
                    <%= ":&nbsp;&nbsp;" + current_student.get("branch")%>
                </td>
                <td class="text-end">Semester</td>
                <td class="text-start">
                    <%= ":&nbsp;&nbsp;" + request.getParameter("student_semester")%>
                </td>
            </tr>
        </table>
    </div>
    <table class="table alert-warning table-borderless mt-3">
        <tr style="color:red;">
            <th style="font-weight:bold">Subject Code</th>
            <th style="font-weight:bold">Subject Name</th>
            <th style="font-weight:bold">Subject Type</th>
            <th style="font-weight:bold">Subject Total Marks</th>
            <th style="font-weight:bold">Subject Obtained Marks</th>
            <th style="font-weight:bold">Grade</th>
        </tr>
        <%
            for (int i = 0; i < result_count; i++) {
                Map<String, Object> result = get_results.get(i);
        %>

        <tr>
            <td><%= result.get("subject_code")%></td>
            <td><%= result.get("subject_name")%></td>
            <td><%= result.get("subject_type")%></td>
                <td><%= (Integer.parseInt(result.get("subject_external_marks").toString())
                            + Integer.parseInt(result.get("subject_internal_marks").toString()))%></td>
            <td><%= (Integer.parseInt(result.get("internal_obtained_marks").toString())
                            + Integer.parseInt(result.get("external_obtained_marks").toString()))%></td>
            <td><%=result.get("status")%></td>
        </tr>
        <%
                total_marks += (Integer.parseInt(result.get("subject_external_marks").toString()) + Integer.parseInt(result.get("subject_internal_marks").toString()));
                obtained_marks += (Integer.parseInt(result.get("internal_obtained_marks").toString())
                        + Integer.parseInt(result.get("external_obtained_marks").toString()));
                // Calculate CGPA
                if (total_marks > 0) {
                    cgpa = ((double) obtained_marks / total_marks) * 10;
                }
//                        cgpa = obtainedMarks / totalMarks;
            }
        %>
        <tr class="mt-5">
            <td colspan="6" style="text-align: right;color:red"><b>
                    GRAND TOTAL : <%= obtained_marks%> / <%= total_marks%>
                </b></td>
        </tr>
        <tr class="mt-5">
            <td colspan="5" style="text-align: right;color:red"><b>
                    GRAND CGPA : <%= cgpa%>
                </b></td>
        </tr> 
    </table>
    <form action="DownloadPDF1" method="Get" style="text-align:right ;">
        <input type="hidden" name="student_id" value="<%= current_student.get("student_id")%>">
        <input type="hidden" name="student_name" value="<%= current_student.get("first_name") + " "
                       + current_student.get("middle_name") + " " + current_student.get("last_name")%>">
        <input type="hidden" name="results_sem" value="<%= request.getParameter("student_semester")%>">
        <input type="hidden" name="student_branch" value="<%= current_student.get("branch")%>">
        <input type="hidden" value='<%= obtained_marks%>' name="downloadres">
        <input type="submit" name="download" value="Download" class="btn btn-dark">
    </form>
    <%
        }
    %>
</div>
<%
    }
} else {%>
<p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i>&nbsp;Access Denied !!</p>

<%
        }
    } else {
        out.println("something went wrong");
        out.println("Please login first.");
        out.println("Only students can view their results.");
        out.println("something went wrong");
        response.sendRedirect("login.jsp");
    }
%>
<%@include file="footer.jsp" %>
