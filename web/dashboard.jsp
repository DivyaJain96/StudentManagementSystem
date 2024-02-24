<%-- 
    Document   : dashboard
    Created on : 5 Jun, 2023, 8:19:16 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%--<%@ include file="mca/MainClass.java" %>--%>
<%@ page import="mca.MainClass" %>
<%@ page import="java.util.*" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DashBoard</title>
    </head>
    <body>
        <%     if (session.getAttribute("current_userid") != null) {
                // out.println("Welcome " + session.getAttribute("current_userid"));
                // out.println(session.getAttribute("current_userrole"));
//            }

                MainClass student = new MainClass();
                int total_student = student.get_total_student_count();
                int total_faculty = student.get_total_faculty_count();
                int total_courses = student.get_total_courses_count();
                int total_notices = student.get_total_notices_count();

                // out.println(total_student);
                // out.println(total_faculty);

        %>
        <div class="container my-5">
            <div class="content row p-2">
                <a class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-warning">
                        <div class="mx-auto">
                            <h4 class="border border-dark p-2 rounded-circle" style="width:50px;height:50px;">👨‍🎓</h4>
                        </div>
                        <h6>Total Student</h6>
                        <h4><%= total_student%></h4>
                    </div>
                </a>
                <a class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-success">
                        <div class="mx-auto">
                            <h4 class="border border-dark p-2 rounded-circle" style="width:50px;height:50px;">👩‍🏫</h4>
                        </div>
                        <h6>Total Faculty</h6>
                        <h4><%= total_faculty%></h4>
                    </div>
                </a>
                <a class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-danger">
                        <div class="mx-auto">
                            <h4 class="border border-dark p-2 rounded-circle" style="width:50px;height:50px;">📚</h4>
                        </div>
                        <h6>Total Courses</h6>
                        <h4><%= total_courses%></h4>
                    </div>
                </a>
                <a class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-info">
                        <div class="mx-auto">
                            <h4 class="border border-dark p-2 rounded-circle" style="width:50px;height:50px;">📝</h4>
                        </div>
                        <h6>Total Notices</h6>
                        <h4><%= total_notices%></h4>
                    </div>
                </a>
            </div>
        </div>
        <%
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
    </body>
</html>
<%@ include file="footer.jsp" %>