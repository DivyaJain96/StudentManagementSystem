<%-- 
    Document   : add_course_details
    Created on : 5 Jun, 2023, 8:50:07 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="mca.MainClass"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%            if (session.getAttribute("current_userid") != null) {
                String currentUserId = (String) session.getAttribute("current_userid");
                if (currentUserId.equals("admin")) {
        %>
        <div class="container my-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
                <%
                    if (request.getParameter("status") != null) {
                        String status = request.getParameter("status");
                        if (status.equals("success")) {
                %>
                <div class="alert alert-success" role="alert">
                    Course Added Successfully !!!<br>
                </div>
                
                <script>
                            setTimeout(function() {
                            window.location.href = "subjects_list.jsp";
                            }, 2000); // Redirect after 2 seconds (adjust the delay as needed)
                </script>
                <script>
//                    alert("Course Added Successfully !!!<br>!!!");
//                            window.location.href = "http://localhost:8080/mcaproject/subjects_list.jsp";</script>
                    <%
                        //                    response.sendRedirect("subjects_list.jsp");
                    } else if (status.equals("failed")) {
                    %>
                <div class="alert alert-danger" role="alert">
                    Course is not added !!
                </div>
                <%
                            response.sendRedirect("add_course_details.jsp");
                        }
                    }
                %>
                <h1>Add Course Details</h1>
                <hr>
                <form action="" method="post" class="mx-2">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="subjectname">Subject Name</label>
                            <input type="text" class="form-control" name="subject_name" required></div>
                        <div class="col-md-4">
                            <label for="subjectcode">Subject Code</label>
                            <input type="text" class="form-control" name="subject_code" required></div>
                        <div class="col-md-4">
                            <label for="subjecttype">Subject Type</label>
                            <div class="dropdown">
                                <select name="subject_type" class="form-select col-md-4" required>
                                    <option value="" disabled selected>-- Choose Type --</option>
                                    <option value="theory">Theory</option>
                                    <option value="practical">Practical</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 my-2">
                            <label for="branch">Branch</label>
                            <div class="dropdown-tb">
                                <select name="student_branch" id="branch" class="form-select" required>
                                    <option value="" disabled selected>-- Choose Branch --</option>
                                    <option value="mca" class="dl">MCA</option>
                                    <option value="mscit">MSCIT</option>
                                    <option value="bca">BCA</option>
                                    <option value="bscit">BSCIT</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-6 my-2">
                            <label>Semester</label>
                            <div class="dropdown">
                                <select name="student_semester" id="select1" class="my-1 form-select" required>
                                    <option value="" disabled selected class="">--Select--</option>
                                    <option value="1" class="dl">1</option>
                                    <option value="2">2</option>
                                    <option value="3">3</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label for="subjectinternalmarks" >Subject Internal Marks</label>
                            <input type="number" class="form-control" name="subject_internal_marks" required min="0" max="1000" oninput="validateMarks(this)"
                                   maxlength="3"  pattern="^\d{1,3}$" title="Please enter a two or three-digit number between in (0-1000)">
                            <div id="internalMarksError" style="color: red;"></div>
                        </div>
                        <div class="col-md-6">
                            <label for="subjectexternalmarks">Subject External Marks<div id="externalMarksError" style="color: red;"></div></label>
                            <input type="number" class="form-control" name="subject_external_marks" required min="0" max="1000" oninput="validateMarks(this)"
                                   maxlength="3"  pattern="^\d{1,3}$" title="Please enter a two or three-digit number only in(0-1000)">
                            <div id="externalMarksError" style="color: red;"></div>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-dark" name="register_subject" value="Register">
                            <a href="subjects_list.jsp" class="btn btn-dark">Back</a>
                        </div>
                    </div>
                </form>
                <div>
                </div>
                <%
                    if (request.getParameter("register_subject") != null) {
                        String subjectName = request.getParameter("subject_name");
                        String subjectCode = request.getParameter("subject_code");
                        String subjectType = request.getParameter("subject_type");
                        String studentBranch = request.getParameter("student_branch");
//                        String studentSemester = request.getParameter("student_semester");
                        int studentSemester = Integer.parseInt(request.getParameter("student_semester"));
                        int subjectExternalMarks = Integer.parseInt(request.getParameter("subject_external_marks"));
                        int subjectInternalMarks = Integer.parseInt(request.getParameter("subject_internal_marks"));

                        MainClass obj = new MainClass();
                        boolean check = obj.isCourseExists(subjectCode, subjectName);
//                        if (obj.isCourseExists(subjectCode, subjectName)) {
                        if (check) {%>
                <script>
                            alert("Course already exists. Please add another course.");
            window.location.href = "http://localhost:8080/mcaproject/add_course_details.jsp";                
                    </script>
                    
                <%} else {
                            boolean subjectReg = obj.register_subject(subjectName, subjectCode, subjectType, studentBranch, studentSemester, subjectExternalMarks, subjectInternalMarks);

                            if (subjectReg) {
                                response.sendRedirect("http://localhost:8080/mcaproject/add_course_details.jsp?status=success");
                            } else {
                                response.sendRedirect("http://localhost:8080/mcaproject/add_course_details.jsp?status=failed");
                            }
                        }
                    }
                %>
            </div>
        </div>
        <%
                } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
//            }
        %>

        <script>
                    var branch = document.getElementById('branch');
                    var select1 = document.getElementById('select1');
                    branch.addEventListener('change', function() {
                    if (branch.value === 'mca' || branch.value === 'mscit' || branch.value === 'MCA' || branch.value === 'MSCIT') {
                    select1.innerHTML = "";
                            for (var i = 1; i <= 4; i++) {
                    var op = document.createElement('option');
                            op.value = i;
                            op.innerHTML = i;
                            select1.appendChild(op);
                    }
                    } else {
                    select1.innerHTML = "";
                            for (var i = 1; i <= 6; i++) {
                    var op = document.createElement('option');
                            op.value = i;
                            op.innerHTML = i;
                            select1.appendChild(op);
                    }
                    }
                    });</script>

    </body>
</html>
<%@ include file="footer.jsp" %>
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