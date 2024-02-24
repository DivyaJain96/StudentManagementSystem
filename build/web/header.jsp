<%-- 
    Document   : header
    Created on : 6 Jun, 2023, 5:46:50 PM
    Author     : Divya Kumar Jain
--%>
<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Student Management System</title>
        <!-- Required meta tags -->
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- Custom css -->
        <link rel="stylesheet" href="css/custom.css">
        <!-- Font awesome Icon  -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
              integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"
                integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous">
        </script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"
                integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous">
        </script>
        <script>
//            function validateForms() {
            function(){
            'use strict';
            window.addEventListener('load', function() {
                var forms = document.getElementsByClassName('needs-validation');
                var validation = Array.prototype.filter.call(forms, function(form) {
                    form.addEventListener('submit', function(event) {
                        if (form.checkValidity() === false) {
                            event.preventDefault();
                            event.stopPropagation();
                        }
                        form.classList.add('was-validated');
                    }, false);
                });
            }, false)
            }();
//            }
        </script>
    </head>
    <body class="bg-light">
        <div class="header">
            <%
                if (session.getAttribute("current_userrole") != null) {
                    String currentUserRole = (String) session.getAttribute("current_userrole");
                    if (currentUserRole.equals("admin")) {
            %>

            <nav class="navbar navbar-expand-lg navbar-dark h6" style="background-color: black;">
                <div class="container-fluid">

                    <div class="navbar-brand">
                        <a class="nav-link text-decoration-none text-white rounded mr-2" aria-current="page"
                           href="dashboard.jsp">DashBoard</a>
                    </div>

                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                            aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>

                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0 text-white mx-auto px-3">

                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                   aria-expanded="false">
                                    Course
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="add_course_details.jsp">Add Course</a></li>
                                    <li><a class="dropdown-item" href="subjects_list.jsp">Show Course List</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                   aria-expanded="false">
                                    Notice
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="add_notice.jsp">Add Notice</a></li>
                                    <li><a class="dropdown-item" href="show_notice.jsp">Show Notice</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                   aria-expanded="false">
                                    Time Table
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="add_time_table.jsp">Add Time Table</a></li>
                                    <li><a class="dropdown-item" href="time_tables.jsp">Show Time Table</a>
                                    </li>
                                </ul>
                            </li>
                            
                            <li class="nav-item">
                                <a class="nav-link mr-2" aria-current="page" href="faculty_registration.jsp">Faculty
                                    Register</a>
                            </li>
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown"
                                   aria-expanded="false">
                                    Result
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="add_results.jsp">Add Results</a></li>
                                    <li><a class="dropdown-item" href="show_result.jsp">Show Student Results</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link mr-2" aria-current="page" href="change_sem.jsp">Change Semester</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link mr-2" aria-current="page" href="allstudentdetails.jsp">Search Student Details</a>
                            </li>
                            <!--<li class="nav-item">-->
                            <!--<a class="nav-link mr-2" aria-current="page" href="show_result.jsp">Show Student Results</a>-->
                            <!--</li>-->
                        </ul>
                        <ul class="dropdown h6 my-2">
                            <a class="nav-link dropdown-toggle text-capitalize text-white" href="#" role=""
                               data-bs-toggle="dropdown" aria-expanded="false">
                                <%= session.getAttribute("current_userid")%>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                            </ul>
                        </ul>
                    </div>

                    <!--<div>
                        <a class="navbar-brand">Welcome,
                    <%--<%= session.getAttribute("current_userid")%>--%>
                    </a>
                    </div> -->

                </div>
                <!-- <a href="/stud_man/add_notice.jsp">Add Notice</a>
                    <a href="/stud_man/change_sem.jsp">Change Semester</a>
                    <a href="/stud_man/logout.jsp">Logout</a> -->

                <%
                } else if (session.getAttribute("current_userrole") != null && session.getAttribute("current_userrole").equals("student")) {
                %>
                <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:black;">
                    <div class="container">
                        <div class="navbar-brand">
                            <a class="nav-link mr-2 text-white" aria-current="page" href="student_dashboard.jsp">Student
                                Dash</a>
                        </div>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav me-auto mb-2 mb-lg-0 text-white mx-auto px-3">

                                <li class="nav-item">
                                    <a class="nav-link mr-2" aria-current="page" href="show_notice.jsp">Show Notice</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link mr-2" aria-current="page" href="results1.jsp">Results</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link mr-2" aria-current="page" href="class_time_table.jsp">Time Table</a>
                                </li>
                            </ul>
                            <ul class="dropdown h6 my-2">
                                <a class="nav-link dropdown-toggle text-uppercase text-white text-start" href="#" role=""
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <%= session.getAttribute("current_userid")%>
                                </a>
                                <ul class="dropdown-menu text-start">
                                    <li><a class="dropdown-item" href="student_details.jsp">My Profile</a></li>
                                    <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                                </ul>
                            </ul>
                        </div>

                        <!--<a class="navbar-brand"
                            href="student_details.jsp">Welcome,
                        <%--<%= session.getAttribute("current_userid")%>--%>
                        </a>-->



                    </div>
                </nav>

                <!-- <a href="/stud_man/student_details.jsp" class="btn btn-success">Student Details</a>
                <a href="/stud_man/logout.jsp">Logout</a> -->

                <%
                } else if (session.getAttribute("current_userrole") != null && session.getAttribute("current_userrole").equals("faculty")) {
                %>
                <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:black;">
                    <div class="container">
                        <div class="navbar-brand">
                            <a class="nav-link text-decoration-none text-white rounded mr-2" aria-current="page"
                               href="faculty_dashboard.jsp">Faculty Dash</a>
                        </div>

                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav h6 me-auto mb-2 mb-lg-0 text-white mx-auto px-3">
                                <li class="nav-item">
                                    <a class="nav-link mr-2" aria-current="page" href="faculty_time_table.jsp">Time Table</a>
                                </li>
                                <li>
                                    <a class="nav-link mr-2" aria-current="page" href="show_notice.jsp">Show Notice</a>
                                </li>
                            </ul>
                            <ul class="h6 dropdown my-2">
                                <a class="nav-link dropdown-toggle text-capitalize text-white" href="#" role=""
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <%= session.getAttribute("current_userid")%>
                                </a>
                                <ul class="dropdown-menu">
                                    <li><a class="dropdown-item" href="logout.jsp">Logout</a></li>
                                </ul>
                            </ul>
                        </div>
                    </div>
                </nav>
                <%
                    }
                } else {
                %>
                <nav class="navbar navbar-expand-lg navbar-dark" style="background-color:black;">
                    <div class="container">
                        <a class="navbar-brand" href="index.jsp">Student Management System</a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                                aria-expanded="false" aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarSupportedContent">

                            <ul class="navbar-nav ms-auto mb-2 mb-lg-0 text-white">
                                <li class="nav-item h6 my-1">
                                    <button type="button" class="btn btn-light text-dark" data-bs-toggle="modal"
                                            data-bs-target="#LoginModal">
                                        <span class="h6">Sign In</span>
                                    </button>
                                </li>
                            </ul>
                            </form>
                        </div>
                    </div>
                </nav>

                <div class="modal fade" id="LoginModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
                     aria-hidden="true">
                    <div class="modal-dialog modal-dialog-centered">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h4 class="modal-title" id="exampleModalLabel">Sign In Here</h4>
                                <button type="button" class="btn btn-dark" data-bs-dismiss="modal">
                                    <span aria-hidden="true" class="h5">&times;</span>
                                </button>
                            </div>
                            <div class="modal-body">
                                <form action="login.jsp" method="post">
                                    <!-- <label class="">Userid</label> -->
                                    <input type="text" placeholder="Eg. 23MCA001" name="user_id" class="form-control" required>

                                    <!-- <label class="mt-2">Password</label> -->
                                    <input type="password" placeholder="Password" name="user_password" class="form-control my-3" required>


                                    <div class="text-left my-3">
                                        <input type="submit" name="login" value="Login" class="btn btn-dark w-100">
                                    </div>
                                </form>
                            </div>
                            <div class="modal-footer">
                               If you have Forgot Password ? <a href="forgot.jsp" class="text-dark text-decoration-none h6"
                                                     style="cursor:pointer;"> Forgot Password</a>
                                <!--</div>-->
                                <!--<div class="modal-footer">-->
                                If you have not account ? <a href="registration.jsp" class="text-dark text-decoration-none h6"
                                                             style="cursor:pointer;"> click here</a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- <a href="/stud_man/registration.jsp">Student Registration</a>
                <a href="/stud_man/login.jsp">Login</a> -->
                <%
                    }
                %>

        </div>
    </body>
</html>
