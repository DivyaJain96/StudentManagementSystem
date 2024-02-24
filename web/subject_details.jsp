<%-- 
    Document   : subject_details
    Created on : 7 Jun, 2023, 9:18:09 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="mca.MainClass"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userid").equals("admin")) {
                    MainClass obj = new MainClass();
                    List<Map<String, Object>> facultys = obj.get_all_faculty();
        %>
        <div class="container mt-5">

            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
                <div>
                    <% if (request.getParameter("status") != null) {
                            if (request.getParameter("status").equals("success")) {%>
                    <div class="alert alert-success" role="alert">
                        <%= "Course Updated Successfully"%>
                    </div>
                    <%  } else if (request.getParameter("status").equals("failed")) {%>
                    <div class="alert alert-danger" role="alert">
                        <%= "Course is not Updated !!"%>
                    </div>
                    <%  }
                        }
                    %>
                </div>
                <h1>Edit Course Details</h1>
                <hr>
                <% if (request.getParameter("sid") != null) {
                        int sid;
                        try {
                            sid = Integer.parseInt(request.getParameter("sid"));
                        } catch (NumberFormatException e) {
                            sid = 0; // or any other default value
                        }
//                        int sid = Integer.parseInt(request.getParameter("sid"));
                        Map<String, Object> subject = obj.get_subject_by_sid(sid);
                        if (subject != null) {
                %>
                <form action="" method="post">
                    <div class="row">
                        <div>
                            <input type="hidden" name="sid" value="<%= subject.get("sid")%>"></div>
                        <div class="col-md-3">
                            <label for="subjectname">Subject Name</label>
                            <input type="text" class="form-control" name="subject_name" value="<%= subject.get("subject_name")%>"></div>
                        <div class="col-md-3">
                            <label for="subjectcode">Subject Code</label>
                            <input type="text" class="form-control" name="subject_code" value="<%= subject.get("subject_code")%>"></div>
                        <div class="col-md-3">    
                            <label for="subjecttype">Subject Type</label>
                            <div class="dropdown">
                                <select name="subject_type" class="form-control col-md-4">
                                    <option value="theory" <% if (subject.get("subject_type") != null
                                                    && subject.get("subject_type").equals("theory")) { %>selected<% } %>>Theory</option>
                                    <option value="practical" <% if (subject.get("subject_type") != null
                                                        && subject.get("subject_type").equals("practical")) { %>selected<% }%>>Practical</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label>Branch</label>
                            <div class="dropdown">
                                <select name="student_branch" class="form-control col-md-4">
                                        <option value="mca" <% if (subject.get("branch") != null
                                                    && subject.get("branch").equals("mca")) { %>selected<% } %>>MCA</option>
                                            <option value="mscit" <% if (subject.get("branch") != null
                                                        && subject.get("branch").equals("mscit")) { %>selected<% } %>>MSCIT</option>
                                            <option value="bca" <% if (subject.get("branch") != null
                                                        && subject.get("branch").equals("bca")) { %>selected<% } %>>BCA</option>
                                            <option value="bscit" <% if (subject.get("branch") != null
                                                        && subject.get("branch").equals("bscit")) { %>selected<% }%>>BSCIT</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-3">
                            <label>Semester</label>
                            <div class="dropdown">
                                <select name="student_semester" class="form-control col-md-4 ">
                                    <option><%= subject.get("semester")%></option>
                                            <option value="1" <% if (subject.get("semester") != null
                                                && subject.get("semester").equals("1")) { %>selected<% } %>>1</option>
                                            <option value="2" <% if (subject.get("semester") != null
                                                && subject.get("semester").equals("2")) { %>selected<% } %>>2</option>
                                            <option value="3" <% if (subject.get("semester") != null
                                                && subject.get("semester").equals("3")) { %>selected<% } %>>3</option>
                                            <option value="4" <% if (subject.get("semester") != null
                                                && subject.get("semester").equals("4")) { %>selected<% } %>>4</option>
                                            <option value="5" <% if (subject.get("semester") != null
                                                && subject.get("semester").equals("5")) { %>selected<% } %>>5</option>
                                            <option value="6" <% if (subject.get("semester") != null
                                                && subject.get("semester").equals("6")) { %>selected<% }%>>6</option>

                                </select>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <label>Subject External Marks</label>
                            <input type="number" class="form-control" name="subject_external_marks"
                                   value="<%= subject.get("subject_external_marks") != null ? subject.get("subject_external_marks") : ""%>" required min="0" 
                                   max="100" oninput="validateMarks(this)"  
                                   pattern="^\d{1,3}$" title="Please enter a two or three-digit number between in (0-1000)" >
                            <div id="internalMarksError" style="color: red;"></div>
                        </div>
                        <div class="col-md-3">
                            <label for="">Subject Internal Marks</label>
                            <input type="number"
                                   class="form-control" name="subject_internal_marks"
                                   value="<%= subject.get("subject_internal_marks") != null ? subject.get("subject_internal_marks") : ""%>"
                                   required min="0" 
                                   max="100" oninput="validateMarks(this)"  
                                   pattern="^\d{1,3}$" title="Please enter a two or three-digit number between in (0-1000)" >
                            <div id="externalMarksError" style="color: red;"></div>
                        </div>
                        <div class="col-md-3">
                            <label for="">Active</label>
                            <div class="dropdown">
                                <select name="active" class="form-control col-md-4">
                                    <option value="yes" <% if (subject.get("active") != null
                                                    && subject.get("active").equals("yes")) { %>selected<% } %>>Yes</option>
                                    <option value="no" <% if (subject.get("active") != null
                                                        && subject.get("active").equals("no")) { %>selected<% }%>>No</option>
                                </select>
                            </div>
                        </div>

                    </div>

                    <div class="row my-3">
                        <div class="col-md-12">
                            <div class="dropdown">
                                <select name="faculty_id" class="form-control col-md-4">
                                    <option value=""  selected>-----</option> <!-- Default "Select" option -->
                                    <!--<option value="faculty_id">-----</option>-->
                                    <% for (Map<String, Object> faculty : facultys) {%>
                                    <option value="<%= faculty.get("faculty_id")%>"
                                            <% if (subject.get("faculty_id") != null
                                                        && subject.get("faculty_id").equals(faculty.get("faculty_id"))) { %>selected<% }%>>
                                        <%= faculty.get("first_name")%> <%= faculty.get("middle_name")%> <%= faculty.get("last_name")%>
                                    </option>
                                    <% }%>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-dark" name="update_subject" value="Update">
                            <a href="subjects_list.jsp" class="btn btn-dark">Back</a>
                        </div>
                    </div>
                </form>
                <% if (request.getParameter("update_subject") != null) {
                        String facultyId = request.getParameter("faculty_id");
                        // Check if the "Select" option is chosen
                        if (facultyId != null && !facultyId.isEmpty()) {
                            int update_subjec = obj.update_subject_details(
                                    Integer.parseInt(request.getParameter("sid")),
                                    //                                request.getParameter("sid"),
                                    request.getParameter("subject_name"),
                                    request.getParameter("subject_code"),
                                    request.getParameter("subject_type"),
                                    request.getParameter("student_branch"),
                                    Integer.parseInt(request.getParameter("student_semester")),
                                    Integer.parseInt(request.getParameter("subject_external_marks")),
                                    Integer.parseInt(request.getParameter("subject_internal_marks")),
                                    request.getParameter("active"),
                                    //                            Integer.parseInt(request.getParameter("faculty_id"))
                                    //                                request.getParameter("faculty_id")
                                    facultyId
                            );
                            if (update_subjec > 0) {%>
                <script>
                    alert("Course updated successfully");
                            window.location.href = "http://localhost:8080/mcaproject/subjects_list.jsp";                </script>
                <% } else {%>
                <script>
                            alert("Course update failed");
                            window.location.href = "http://localhost:8080/mcaproject/subject_details.jsp?sid=<%= request.getParameter("sid")%>&status=failed";                </script>
                <% }
                } else {
                    // Set facultyId to null or an empty string as needed
                    String facultyIdValue = null; // or ""
                    int update_subject = obj.update_subject_details(
                            Integer.parseInt(request.getParameter("sid")),
                            request.getParameter("subject_name"),
                            request.getParameter("subject_code"),
                            request.getParameter("subject_type"),
                            request.getParameter("student_branch"),
                            Integer.parseInt(request.getParameter("student_semester")),
                            Integer.parseInt(request.getParameter("subject_external_marks")),
                            Integer.parseInt(request.getParameter("subject_internal_marks")),
                            request.getParameter("active"),
                            facultyIdValue // Use null or an empty string
                    );
                    if (update_subject > 0) {%>
                <script>
                            alert("Course updated successfully");
                            window.location.href = "http://localhost:8080/mcaproject/subjects_list.jsp";                </script>
                <% } else {%>
                <script>
                            alert("Course update failed");
                            window.location.href = "http://localhost:8080/mcaproject/subject_details.jsp?sid=<%= request.getParameter("sid")%>&status=failed";                </script>
                <% }
                            }
                        }
                    }
                %>
            </div>
        </div>
        <%
                    } else {
                        out.println("Oops! Something went wrong. Please try again later.");
                    }
                } else {
                    response.sendRedirect("error.jsp");
                }
            }
        %>
    </body>
</html>
<%@ include file="footer.jsp" %>
<script>

            function validateMarks(input) {
            const value = input.value;
                    const errorElement = input.nextElementSibling;
                    if (value.length > 3) {
            input.value = value.slice(0, 3);
                    errorElement.textContent = "Please enter a marks between 0-1000";
            } else {
            errorElement.textContent = "";
            }
            }
</script>