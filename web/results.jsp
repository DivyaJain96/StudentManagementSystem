<%-- 
    Document   : results
    Created on : 7 Jun, 2023, 9:15:38 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.mysql.jdbc.StringUtils"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student Results</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userid") != null) {
                String currentUserId = (String) session.getAttribute("current_userid");
                String currentUserRole = (String) session.getAttribute("current_userrole");
                if ("student".equals(currentUserRole)) {

                    MainClass obj = new MainClass();
                    HashMap<String, Object> currentStudent = obj.get_student_by_userid(currentUserId);
                    List<Map<String, Object>> semesters = obj.get_semester(currentUserId);

        %>
        <div class="container my-5">
            <form action="" method="post" class="alert-warning p-5">
                <div class="row">
                    <div class="col-md-4">
                        <label>Select Semester</label>
                        <div class="dropdown">
                            <select name="student_semester" class="form-select col-md-4" required>
                                <% for (Map<String, Object> sem : semesters) {%>
                                <option value="<%= sem.get("semester")%>"
                                        <%= request.getParameter("student_semester") != null
                                                && request.getParameter("student_semester").equals(sem.get("semester").toString())
                                                ? "selected" : ""%>>
                                    <%= sem.get("semester")%>
                                </option>
                                <% }%>
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
            <%
                if (request.getParameter("show_results") != null) {
                    int semester = Integer.parseInt(request.getParameter("student_semester"));
                    List<Map<String, Object>> getResults = obj.getStudentResults(currentUserId, semester);
                    int resultCount = getResults.size();
                    int totalMarks = 0;
                    int obtainedMarks = 0;
                    // Calculate CGPA
                    double cgpa = 0.0; // Initialize CGPA to 0.0
                    if (totalMarks > 0) {
                        cgpa = ((double) obtainedMarks / totalMarks) * 10;
                    }
            %>       
            <table class="table alert-info my-4">
                <tr>
                    <td class="text-end"><label for="name">Name</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%= currentStudent.get("first_name") + " " + currentStudent.get("middle_name") + ". " + currentStudent.get("last_name")%></td>
                    <td class="text-end">
                        <label>Stud. ID</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%= currentStudent.get("student_id")%></td>
                </tr>
                <tr>
                    <td class="text-end">
                        <label>Program</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%=currentStudent.get("branch")%></td>
                    <td class="text-end">
                        <label>Semester</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%= semester%></td>
                </tr>
            </table>
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
                    for (int i = 0; i < resultCount; i++) {
                        Map<String, Object> result = getResults.get(i);
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
                        totalMarks += (Integer.parseInt(result.get("subject_external_marks").toString()) + Integer.parseInt(result.get("subject_internal_marks").toString()));
                        obtainedMarks += (Integer.parseInt(result.get("internal_obtained_marks").toString())
                                + Integer.parseInt(result.get("external_obtained_marks").toString()));
                        // Calculate CGPA
                        if (totalMarks > 0) {
                            cgpa = ((double) obtainedMarks / totalMarks) * 10;
                            
                        }
                    }
                %>
                <tr class="mt-5">
                    <td colspan="6" style="text-align: right;color:red">
                        <b>
                            GRAND TOTAL : <%= obtainedMarks%> / <%= totalMarks%>
                        </b>
                    </td>
                </tr>
                <tr class="mt-5">
                    <td colspan="6" style="text-align: right;color:red"><b>
                            <!--GRAND CGPA  :-->
                            <%
//                            =  cgpa
                            %>
                            GRAND CGPA: <%= String.format("%.2f", cgpa) %>
                        </b></td>
                </tr> 
            </table>
            <form action="DownloadPDF1" method="Get" style="text-align:right ;">
                <input type="hidden" name="student_id" value="<%= currentStudent.get("student_id")%>">
                <input type="hidden" name="student_name"
                       value="<%= currentStudent.get("first_name") + " " + currentStudent.get("middle_name") + " " + currentStudent.get("last_name")%>">
                <input type="hidden" name="results_sem" value="<%= semester%>">
                <input type="hidden" name="student_branch" value="<%= currentStudent.get("branch")%>">
                <input type="hidden" value='<%= obtainedMarks%>' name="downloadres">
                <input type="submit" name="download" value="Download" class="btn btn-dark">
            </form>
            <%
                }
            %>
        </div>
        <% } else { %>
        <p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle'
                                                                     aria-hidden='true'></i>&nbsp;Access Denied !!</p>
            <%
                    }
                } else {
                    out.println("something went wrong");
                }
            %>

    </body>
</html>
<%@include file="footer.jsp" %>
