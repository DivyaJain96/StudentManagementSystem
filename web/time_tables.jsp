<%-- 
    Document   : time_tables
    Created on : 7 Jun, 2023, 9:18:32 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <c:if test="${not empty sessionScope.current_userid}">
            <c:if test="${sessionScope.current_userrole == 'admin'}">
                <div class="container mt-5">
                    <div class="content alert-warning card text-dark p-5 shadow my-3 rounded col-md-8 mx-auto">
                        <h1>Show Timetable</h1>
                        <hr>
                        <form action="display_time_table.jsp" method="post" id="myForm">
                            <div class="row my-3">
                                <div class="col-md-12">
                                    <label>Branch</label>
                                    <select name="branch" id="branch" class="form-control" required>
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
                                    <select name="semester" id="select1" class="form-control" required>
                                        <option value="" disabled selected>--Select--</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row my-3">
                                <div class="col">
                                    <button type="submit" class="btn btn-dark" name="add_tt">
                                        <span class="h6">Show Timetable </span>
                                    </button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </c:if>
        </c:if>

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
            });
        </script>
        <%@ include file="footer.jsp" %>
    </body>
</html>
