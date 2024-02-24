<%-- 
    Document   : student_dashboard
    Created on : 7 Jun, 2023, 9:27:59 AM
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
        <%            if (session.getAttribute("current_userid") == null) {
//                out.println("Welcome " + session.getAttribute("current_userid"));
                response.sendRedirect("error.jsp");
            }
        %>

        <%if (session.getAttribute("current_userid") != null) {
//                out.println("Welcome " + session.getAttribute("current_userid"));
//                out.println(session.getAttribute("current_userrole"));
//                out.println("Welcome " + session.getAttribute("current_userrole"));
            }%>

        <div class="container my-5">
            <div class="content row p-2">
                <a href="class_time_table.jsp" class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-success" style="height:15rem;">
                        <div class="mx-auto">
                            <h4 class="shadow border border-dark p-2 rounded-circle" style="width:50px;height:50px;">👩‍🏫</h4>
                        </div>
                        <h4 class="my-3">Show Timetable</h4>
                    </div>
                </a>
                <a href="show_notice.jsp" class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-warning" style="height:15rem;">
                        <div class="mx-auto">
                            <h4 class="shadow border border-dark p-2 rounded-circle" style="width:50px;height:50px;">👨‍🎓</h4>
                        </div>
                        <h4 class="my-3">Show Notice</h4>
                    </div>
                </a>
            </div>
            <div class="row">
                <a href="results.jsp" class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-info"style="height:15rem;">
                        <div class="mx-auto">
                            <h4 class="border border-dark p-2 rounded-circle" style="width:50px;height:50px;">📝</h4>
                        </div>
                        <h4 class="my-3">Show Results</h4>
                    </div>
                </a>
            </div>
        </div>
    </body>
</html>
<%@ include file="footer.jsp" %>