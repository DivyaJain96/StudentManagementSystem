<%-- 
    Document   : success_password
    Created on : 19 Oct, 2023, 11:53:30 AM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <div class="container my-5">
            <div class="card col-md-6 mx-auto alert-warning shadow">
                <div class="card-body">

                    <%
                        if (request.getParameter("registration_status") != null) {
                            String registrationStatus = request.getParameter("registration_status");
                            if (registrationStatus.equals("success")) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Registration Successfully check email for student id!!<br>
                        if you want to login <a href="index.jsp">Click here</a>
                    </div>
                    <%
                            }
                        }
                    %>
                    <%
                        if (request.getParameter("password_status") != null) {
                            String passwordStatus = request.getParameter("password_status");
                            if (passwordStatus.equals("success")) {
                    %>
                    <div class="alert alert-success" role="alert">
                        Password  Update Successfully !!<br>
                        if you want to login <a href="index.jsp">Click here</a>
                    </div>
                    <%
                    } else if (passwordStatus.equals("failed")) {
                    %>
                    <div class="alert alert-danger" role="alert">
                        Password Updated Failed !!
                    </div>
                    <%
                            }
                        }
                    %>
                </div>
            </div>
        </div>
    </body>
</html>

<jsp:include page="footer.jsp" />