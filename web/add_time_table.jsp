<%-- 
    Document   : add_time_table
    Created on : 5 Jun, 2023, 8:56:51 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Timetable</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userrole").equals("admin")) {
        %>

        <div class="container mt-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded col-md-8 mx-auto">
                <h1>Add Timetable</h1>
                <hr>
                <form action="add_tt.jsp" method="post" id="myForm" class="">
                    <div class="row my-3">
                        <div class="col-md-12">
                            <label for="branchs">Branch</label>
                            <select name="branch" id="branch" class="form-select" required>
                                <option value="" disabled selected>-- Choose Branch --</option>
                                <option value="bca">BCA</option>
                                <option value="bscit">BSCIT</option>
                                <option value="mca">MCA</option>
                                <option value="mscit">MSCIT</option>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-12">
                            <label class="h6">Semester</label>
                            <select name="semester" id="select1" class="my-1 form-select" required>
                                <option value="" disabled selected>--Select--</option>
                                <!--   <option value="1">1</option>
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
                            <button type="submit" class="btn btn-dark" name="add_tt">
                                <span class="h6">Add New </span>
                            </button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
        <script>
            var branch = document.getElementById('branch');
                    var select1 = document.getElementById('select1');
                    branch.addEventListener('change', function() {
                    if (branch.value === 'mca' || branch.value === 'mscit' || branch.value === 'MCA' || branch.value === 'MSCIT') {
                    select1.innerHTML = "";
                            for (var i = 1; i <= 4; i++) {
                    var op = document.createElement('option');
                            op.value = i;
                            op.innerHTML = i;
                            select1.appendChild(op);
                    }
                    } else {
                    select1.innerHTML = "";
                            for (var i = 1; i <= 6; i++) {
                    var op = document.createElement('option');
                            op.value = i;
                            op.innerHTML = i;
                            select1.appendChild(op);
                    }
                    }
                    });</script>

        <script>
                    const branch = document.getElementById('branch');
                    const select1 = document.getElementById('select1');
                    branch.addEventListener('change', () => {
                    if (branch.value == 'mca' || branch.value == 'mscit' || branch.value == 'MCA' || branch.value == 'MSCIT') {
                    select1.innerHTML = "";
                            //select2.innerHTML = "";
                            for (var i = 1; i <= 4; i++) {
                    op = document.createElement('option');
                            op.value = i;
                            op.innerHTML = i;
                            select1.appendChild(op);
                    }

                    } else {
                    select1.innerHTML = "";
                            // select2.innerHTML = "";
                            for (var i = 1; i <= 6; i++) {
                    op = document.createElement('option');
                            op.value = i;
                            op.innerHTML = i;
                            select1.appendChild(op);
                    }

                    }

                    }
                    );
        </script>
    </body>
</html>
<%@ include file="footer.jsp" %>

