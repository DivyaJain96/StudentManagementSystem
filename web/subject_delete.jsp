<%-- 
    Document   : subject_delete
    Created on : 7 Jun, 2023, 9:17:19 PM
    Author     : Divya Kumar Jain
--%>

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
        <%            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userid").equals("admin")) {
                    MainClass obj = new MainClass();
                    if (request.getParameter("sid") != null) {
                        int sid = Integer.parseInt(request.getParameter("sid"));
                        int delete_subject = obj.detete_subject_details(sid);
                        if (delete_subject > 0) {%>

        <script>
            alert("Subject deleted successfully");
            window.location.href = "http://localhost:8080/mcaproject/subjects_list.jsp";
        </script>


        <!--out.println("<script>alert('Subject Is Deleted!!!')</script>");-->
        <!--response.sendRedirect("http://localhost:8080/mcaproject/subjects_list.jsp");-->
        <%} else {%>
        <!--out.println("<script>alert('Subject Is Not Deleted!!!')</script>");-->
        <!--response.sendRedirect("http://localhost:8080/mcaproject/subjects_list.jsp");-->
        <script>
            alert("Failed to delete subject");
            window.location.href = "http://localhost:8080/mcaproject/subjects_list.jsp";
        </script>
        <%
                        }
                    }
                } else {
                    out.println("<p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Oops! Something went wrong. Please try again later.</p>");
//                    out.println("<p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Something Went Wrong  !!</p>");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
        <%@ include file="footer.jsp" %>
    </body>
</html>
