<%-- 
    Document   : faculty_dashboard
    Created on : 5 Jun, 2023, 8:35:49 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="header.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%                    String faculty_id = (String) session.getAttribute("current_userid");
//               out.print(faculty_id);%>
        <div class="container my-5">
            <div class="content row p-2">
                <a href="faculty_time_table.jsp" class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-success" style="height:15rem;">
                        <div class="mx-auto">
                            <h4 class="shadow border border-dark p-2 rounded-circle" style="width:50px;height:50px;">👩‍🏫</h4>
                        </div>
                        <h4 class="my-3">Take Attendance</h4>
                    </div>
                </a>
                <a href="show_notice.jsp" class="text-decoration-none col-md-6">
                    <div class="card text-center m-2 text-dark p-5 shadow rounded alert-success" style="height:15rem;">
                        <div class="mx-auto">
                            <h4 class="shadow border border-dark p-2 rounded-circle" style="width:50px;height:50px;">👩‍🏫</h4>
                        </div>
                        <h4 class="my-3">Show Notice</h4>
                    </div>
                </a>
            </div>
        </div>

    </body>
</html>
<%@include file="footer.jsp"%>
