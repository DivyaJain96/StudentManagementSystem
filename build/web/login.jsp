<%-- 
    Document   : login
    Created on : 5 Jun, 2023, 8:31:46 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="mca.MainClass" %>
<%@ page session="true" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <!--
            <form action="#" method="post">
                <label>Userid</label>
                <input type="text" name="userid" class="form-control">

                <label>Password</label>
                <input type="password" name="password" class="form-control">

                <div class="text-center">
                    <input type="submit" name="login" value="Login" class="btn btn-info">
                </div>
            </form>
        -->
    </body>
</html>
<%    if (request.getParameter("login") != null) {
        MainClass obj = new MainClass();

//        String userid = (String)request.getParameter("userid");//this is not change 
        String user_id = request.getParameter("user_id");
        String user_password = request.getParameter("user_password");

        Map<String, Object> user = obj.checkCredential(user_id, user_password);
//        String user = obj.check_credential(userid, password);

//        HttpSession session = request.getSession();
        if (user != null && !user.isEmpty()) {
            String userId = (String) user.get("user_id");
            String userName = (String) user.get("user_password");
            
            // Set the session timeout to 30 minutes (in seconds)
            int sessionTimeoutInSeconds = 30 * 60; // 30 minutes
            session.setMaxInactiveInterval(sessionTimeoutInSeconds);
            session.setAttribute("current_userid", user.get("user_id"));
            session.setAttribute("current_userrole", user.get("user_role"));
            if (user.get("user_role").equals("admin")) {
                response.sendRedirect("http://localhost:8080/mcaproject/dashboard.jsp");
            } else if (user.get("user_role").equals("faculty")) {
                response.sendRedirect("http://localhost:8080/mcaproject/faculty_dashboard.jsp");
            } else if (user.get("user_role").equals("student")) {
                response.sendRedirect("http://localhost:8080/mcaproject/student_dashboard.jsp");
            }
        } else {

%>
<script>
    alert('Please Enter Correct Username and Password');
// Redirect to a new page after displaying the alert
    window.location.href = "http://localhost:8080/mcaproject/";
</script>
<%       }
    } else {
        response.sendRedirect("http://localhost:8080/mcaproject/");
    }
%>
<%@ include file="footer.jsp" %>
