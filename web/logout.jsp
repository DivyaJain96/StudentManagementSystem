<%-- 
    Document   : logout.jsp
    Created on : 7 Jun, 2023, 2:58:14 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1></h1>
        <%// Unset session variables
            session.removeAttribute("current_userid");
            session.removeAttribute("current_userrole");

            // Redirect the user using JavaScript
        %>
        <script>
            window.location.href = "http://localhost:8080/mcaproject/index.jsp";
        </script>
    </body>
</html>
<%@ include file="footer.jsp" %>