<%-- 
    Document   : update_result
    Created on : 17 Oct, 2023, 7:48:56 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userrole").equals("admin")) {
                MainClass obj = new MainClass();
        %>
        <div class="container my-2">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded" >
                <%
                    String studentId = request.getParameter("student_id");
                    String branch = request.getParameter("branch");
                    int sem = Integer.parseInt(request.getParameter("sem"));
                    String subjectCode = request.getParameter("subjectcode");
                    String subjectname = request.getParameter("subjectname");
                    String subjecttype = request.getParameter("subjecttype");

//                    out.println(studentId + "" + branch + "" + sem + "" + subjectCode + "" + subjectname + "" + subjecttype);
                    int subjectid = obj.getSubjectIdBySubjectCode(subjectCode);
                    // Fetch allowed internal and external mark ranges from the database
                    Map<String, Integer> markRanges = obj.getMarkRanges(subjectCode);
                    int internalMin = 0;  // Modify to fetch from the database
                    int internalMax = markRanges.get("internalMax");
                    int externalMin = 0;  // Modify to fetch from the database
                    int externalMax = markRanges.get("externalMax");
//                    out.println(internalMin+""+internalMax);
//                    out.println(externalMin+""+externalMax);
//                    out.println(subjectid);
                    // Make sure to trim and clean the input strings
                    String internalMarksStr = request.getParameter("internalmark").trim();
                    String externalMarksStr = request.getParameter("externalmark").trim();

                    int internalMark = 0;
                    int externalMark = 0;

                    // Validate and parse the input strings to integers
                    try {
                        internalMark = Integer.parseInt(internalMarksStr);
                        externalMark = Integer.parseInt(externalMarksStr);
                %>
                <div class="row">
                    <!--<div class="container my-5">-->
                    <div class="col-md-6">
                        <h1>Update Marks for Student</h1>

                        <form action="" method="post">
                            <input type="hidden" name="student_id" value="<%= studentId%>">
                            <input type="hidden" name="branch" value="<%= branch%>">
                            <input type="hidden" name="sem" value="<%= sem%>">
                            <input type="hidden" name="subject_code" value="<%= subjectCode%>">
                            <input type="hidden" name="subject_id" value="<%= subjectid%>">
                            <div class="form-group">
                                <label for="subject_code">Subject Code : </label>
                                <%= subjectCode%>
                            </div>
                            <div class="form-group">
                                <label for="subject_name">Subject Name:</label>
                                <%=subjectname%>
                            </div>
                            <div class="form-group">
                                <label for="subject_type">Subject Type &nbsp;&nbsp;:</label>
                                <%= subjecttype%>
                            </div>
                            <div class="col-md-12 mb-1 form-group">
                                <label for="internal_marks">Internal Marks :</label>
                                <input type="number" class="form" name="internal_marks" value="<%= internalMark%>" required 
                                       min="<%= internalMin%>" max="<%= internalMax%>"
                                       oninput="validateMarks(this)"
                                       maxlength="3"  pattern="^\d{1,3}$" title="Please enter a two or three-digit number only in (0-100)" >
                                <div id="internalMarksError" style="color: red;"></div>
                            </div>
                            <div class="col-md-6 form-group">
                                <label for="external_marks">External Marks:</label>
                                <input type="number" class="form" name="external_marks" value="<%= externalMark%>" required
                                       min="<%= externalMin%>" max="<%= externalMax%>" oninput="validateMarks(this)"
                                       maxlength="3"  pattern="^\d{1,3}$" title="Please enter a two or three-digit number only in(0-100)">
                                <div id="externalMarksError" style="color: red;"></div>
                            </div>
                            </br>
                            <button type="submit" class="btn btn-success" name="update_marks">Update Marks</button>
                            <a href="show_result.jsp" class="btn btn-dark">Back</a>
                        </form>
                    </div>
                </div>
                <%
                    } catch (NumberFormatException e) {
                        // Handle the exception or display an error message as needed
                        response.sendRedirect("error.jsp");
                    }
                } else {
                %>
                <div class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i>&nbsp;Access Denied !!</div>
                <%
                    }
                %>

                <%@ include file="footer.jsp" %>
                <%
                    if (request.getParameter("update_marks") != null) {
                        String studentId = request.getParameter("student_id");
                        String subjectid = request.getParameter("subject_id");
                        int internalMarks = Integer.parseInt(request.getParameter("internal_marks"));
                        int externalMarks = Integer.parseInt(request.getParameter("external_marks"));
                        MainClass obj = new MainClass();
                        int updated = obj.updateMarks(studentId, internalMarks, externalMarks, subjectid);
                        if (updated > 0) {
                %>
                <div class="container my-5">
                    <p class="alert-success">Marks updated successfully.</p>
                </div>
                <script>
                    setTimeout(function() {
                    window.location.href = "show_result.jsp";
                    }, 2000); // Redirect after 2 seconds (adjust the delay as needed)
                </script>
                <%
                } else {
                %>
                <div class="container my-5">
                    <p class="alert-danger">Failed to update marks. Please try again.</p>
                </div>
                <script>
                            setTimeout(function() {
                            window.location.href = "update_result.jsp";
                            }, 2000); // Redirect after 2 seconds (adjust the delay as needed)
                </script>

                <%                        }
                    }
                %>

                <script>

                            function validateMarks(input) {
                            const value = input.value;
                                    const errorElement = input.nextElementSibling;
                                    if (value.length > 3) {
                            input.value = value.slice(0, 3);
                                    errorElement.textContent = "Please enter a two or three-digit number only";
                            } else {
                            errorElement.textContent = "";
                            }
                            }
                </script>