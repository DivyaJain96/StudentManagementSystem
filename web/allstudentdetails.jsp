<%-- 
    Document   : allstudentdetails
    Created on : 27 Sep, 2023, 6:19:07 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="mca.MainClass"%>
<%@ include file="header.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
        <!-- Assuming you're using Bootstrap for styling -->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">

        <title>JSP Page</title>
    </head>
    <body>

        <%            if (session.getAttribute("current_userrole") != null) {
                String currentUserRole = (String) session.getAttribute("current_userrole");
                if (currentUserRole.equals("admin")) {
        %>

        <div class="container my-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded" >
                <div class="row">
                    <div class="col-md-4">
                        <form action="ALLDetailsStudent.jsp" method="post" class="form-inline">
                            <div class="form-group d-flex align-items-center">
                                <label for="branch" class="mr-2">StudentId : &nbsp</label>
                                <input type="text" name="studentid" required="" placeholder="Enter a Student Id">
                                <button type="submit" class="btn btn-dark form-group ml-2" name="search_ID">
                                    <i class="fas fa-search"></i>
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <%
                }
            }

        %>
    </body>
</html>

