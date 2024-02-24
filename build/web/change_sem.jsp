<%-- 
    Document   : change_sem
    Created on : 7 Jun, 2023, 9:11:08 PM
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
        <div class="container mt-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
                <%                    if (session.getAttribute("current_userrole").equals("admin")) {
//                        out.println(session.getAttribute("current_userrole"));
                        if (request.getParameter("change_sem_btn") != null) {
                            MainClass obj = new MainClass();
//                            out.println(request.getParameter("branch"));
                            String branch = request.getParameter("branch");
                            int current_semester = Integer.parseInt(request.getParameter("current_semester"));
                            int newSem = Integer.parseInt(request.getParameter("new_sem"));

                            boolean changeSem = obj.change_semester(newSem, branch, current_semester);

                            if (changeSem) {%>
                <script>
                    alert("Semester changed successfully!");
                            window.location.href = "http://localhost:8080/mcaproject/dashboard.jsp";                </script>

                <%} else {%>
                <script>
                            alert("Failed to change semester. Please try again.");
                            window.location.href = "http://localhost:8080/mcaproject/change_sem.jsp";                </script>
                <% }
                        }%>
                <div class="text-left">
                    <h2>Change Semester</h2>
                    <hr class="col-3">
                </div>
                <form action="" method="post">
                    <div class="row my-3">
                        <div class="col-md-6">
                            <label>Branch</label>
                            <select name="branch" id="branc" class="form-select my-2" required="">
                                <option value="" disabled selected>--Select--</option>
                                <option value="bca">BCA</option>
                                <option value="bscit">BSCIT</option>
                                <option value="mca">MCA</option>
                                <option value="mscit">MSCIT</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-6">
                            <label class="h6">Current Semester</label>
                            <select name="current_semester" id="select1" class="my-1 form-select" required="">
                                <option value="" disabled selected >--Select--</option>
                                <!--                                <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                                <option value="4">4</option>
                                                                <option value="5">5</option>
                                                                <option value="6">6</option>-->
                            </select>
                        </div>
                        <div class="col-md-6">
                            <label class="h6">New Semester</label>
                            <select name="new_sem" id="select2" class="my-1 form-select" required="">
                                <option value="" disabled selected>--Select--</option>
                                <!--                                <option value="1">1</option>
                                                                <option value="2">2</option>
                                                                <option value="3">3</option>
                                                                <option value="4">4</option>
                                                                <option value="5">5</option>
                                                                <option value="6">6</option>-->
                            </select>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col">
                            <input type="submit" value="Change Semester" name="change_sem_btn" class="btn btn-dark">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
    </body>
    <script>
                const branch = document.getElementById('branc');
                const select1 = document.getElementById('select1');
                const select2 = document.getElementById('select2');
                branch.addEventListener('change', () => {
                if (branch.value == 'mca' || branch.value == 'mscit' || branch.value == 'MCA' || branch.value == 'MSCIT')
                {
                select1.innerHTML = "";
                        select2.innerHTML = "";
                        for (var i = 1; i <= 4; i++)
                {
                op = document.createElement('option');
                        op.value = i;
                        op.innerHTML = i;
                        select1.appendChild(op);
                }
                for (var i = 1; i <= 4; i++)
                {
                op = document.createElement('option');
                        op.value = i;
                        op.innerHTML = i;
                        select2.appendChild(op);
                }
                }
                else
                {
                select1.innerHTML = "";
                        select2.innerHTML = "";
                        for (var i = 1; i <= 6; i++)
                {
                op = document.createElement('option');
                        op.value = i;
                        op.innerHTML = i;
                        select1.appendChild(op);
                }
                for (var i = 1; i <= 6; i++)
                {
                op = document.createElement('option');
                        op.value = i;
                        op.innerHTML = i;
                        select2.appendChild(op);
                }
                }

                });</script>
</html>
<%@ include file="footer.jsp" %>

