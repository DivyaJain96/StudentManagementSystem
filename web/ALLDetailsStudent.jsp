<%-- 
    Document   : ALLDetailsStudent
    Created on : 4 Oct, 2023, 4:29:51 PM
    Author     : Divya Kumar Jain
--%>
<%@page import="java.util.Map"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>All Student Details</title>
    </head>
    <body>
</html>
<%    if (request.getParameter("search_ID") != null) {

        String studentid = request.getParameter("studentid");
//        out.println(studentid);
        MainClass obj = new MainClass();
        if (studentid != null && !studentid.isEmpty()) {
            Map<String, Object> details = obj.allstudentdetails(studentid);
//            out.print(details);
            if (details != null && !details.isEmpty()) {
                String profile_pic = (String) details.get("profile_pic");
                String defaultPic = "site_img/default.png"; // Provide the path to your default image
%>
<div class="container mt-3">
    <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
        <h1 class="rounded text-center py-2">Student Details</h1>
        <form>
            <fieldset class="border p-4 border border-1 border-dark rounded">
                <legend class="w-auto">Personal Details</legend>
                <hr>
                <div class="row my-2">
                    <div class="col-md-2 mx-auto mt-2">
                         <%-- Check if profile picture is available, display it; otherwise, show default image --%>
                        <a class="img-link" href="<%= (profile_pic != null && !profile_pic.isEmpty()) ? profile_pic : defaultPic %>" target="">
                            <img class="img-fluid" style="width: 100px; height: 100px;" src="<%= (profile_pic != null && !profile_pic.isEmpty()) ? profile_pic : defaultPic %>" alt="">
                        </a>
                        <label>
                            <a class='text-success' href="<%= (profile_pic != null && !profile_pic.isEmpty()) ? profile_pic : defaultPic %>">
                                <!-- You can add some additional text here if needed -->
                            </a>
                        </label>
                    </div>
                    <div class="col-md-4">
                        <label for="">Student Id</label>
                        <input type="text" class="form-control" value="<%= details.get("student_id")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Password</label>
                        <input type="password" class="form-control" value="<%= details.get("password")%>" readonly>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <label for="">Firstname</label>
                        <input type="text" class="form-control" value="<%= details.get("first_name")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Middlename</label>
                        <input type="text" class="form-control" value="<%= details.get("middle_name")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Lastname</label>
                        <input type="text" class="form-control" value="<%= details.get("last_name")%>" readonly>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-4">
                        <label for="">Gender</label>
                        <input type="text" class="form-control" value="<%= details.get("gender")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Date of Birth</label>
                        <input type="date" class="form-control" value="<%= details.get("dob")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Blood Group</label>
                        <input type="text" class="form-control" value="<%= details.get("blood_group")%>" readonly>
                    </div>
                </div>
                </br>
                </br>
                <div class="row">
                    <div class="col-md-4">
                        <label for="">Course</label>
                        <input type="text" class="form-control" value="<%= details.get("branch")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Email</label>
                        <input type="email" class="form-control" value="<%= details.get("email")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Contact</label>
                        <input type="number" class="form-control" value="<%= details.get("contact_no")%>" readonly>
                    </div>
                </div>
                </br>
                </br>

                <div class="row my-2">
                    <div class="col-md-12">
                        <label for="">Address</label>
                        <textarea class="form-control" rows="3" cols="12" readonly=""><%= details.get("address")%></textarea>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label for="">City</label>
                        <input type="text" class="form-control" value="<%= details.get("city")%>" readonly>
                    </div>
                    <div class="col-md-6">
                        <label for="">State</label>
                        <input type="text" class="form-control" value="<%= details.get("state")%>" readonly>
                    </div>
                </div>
            </fieldset>

            <!-- 10th Details -->
            <fieldset class="p-4 border border-1 border-dark rounded mt-3">
                <legend class="w-auto">10th Details</legend>
                <hr>
                <div class="row">
                    <div class="col-md-6">
                        <label for="">10th School</label>
                        <input type="text" class="form-control" value="<%= details.get("10th_school")%>" readonly="">
                    </div>
                    <div class="col-md-6">
                        <label for="">10th Board</label>
                        <input type="text" class="form-control" value="<%= details.get("10th_board")%>" readonly="">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label for="">10th Total Marks</label>
                        <input type="text" class="form-control" value="<%= details.get("10th_total_marks")%>" readonly="">
                    </div>
                    <div class="col-md-6">
                        <label for="">10th Obtained Marks</label>
                        <input type="text" class="form-control" value="<%= details.get("10th_obtained_marks")%>" readonly="">
                    </div>
                </div>
                <!--                <div class="row my-2">
                                    <div class="col-md-2 mx-auto mt-2">
                                        <img href=http://localhost:8080/mcaproject/" class="img-fluid" style="width:100px;height:100px;"  src="<%= details.get("10th_marksheet")%>"  alt="">
                                    </div>
                                </div>-->
                <div class="row mt-3 ">
                    <div class="col-md-3">
                        <label for="">10th Marks sheet</label>
                        <%
                            String marksSheet10 = (String) details.get("10th_marksheet");
                        %>
                        <input type="file" name="10th_marksheet" id="uploadfile"
                               <%= (marksSheet10 != null && !marksSheet10.isEmpty()) ? "disabled" : ""%>>
                    </div>

                    <div class="col-md-9">

                        <%
                            //                                    String marksSheet = (String) student_details.get("10th_marksheet");
                            if (marksSheet10 != null && !marksSheet10.isEmpty()) {%>
                        <label>
                            <a class='text-success' href="http://localhost:8080/mcaproject/<%=marksSheet10%>">
                                <%= marksSheet10.substring(6)%>
                            </a>
                        </label>

                        <% }%>
                    </div>
                </div>
            </fieldset>
            <!-- 12th Details -->
            <fieldset class="rounded p-4 border border-1 border-dark mt-3">
                <legend class="w-auto">12 th Details</legend>
                <hr>
                <div class="row">
                    <div class="col-md-4">
                        <label for="">12th Stream</label>
                        <input type="text" class="form-control" name="12th_stream"
                               value="<%= details.get("12th_stream")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">12th School</label>
                        <input type="text" class="form-control" name="12th_school"
                               value="<%= details.get("12th_school")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">12th Board</label>
                        <input type="text" class="form-control" name="12th_board"
                               value="<%= details.get("12th_board")%>">
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-4">
                        <label for="">12th Total Marks</label>
                        <input type="text" class="form-control" name="12th_total_marks"
                               value="<%= details.get("12th_total_marks")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">12th Obtained Marks</label>
                        <input type="text" class="form-control" name="12th_obtained_marks"
                               value="<%= details.get("12th_obtained_marks")%>">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-3 mt-2">
                        <label for="">12th Marks sheet</label>
                        <%
                            String marksSheet12 = (String) details.get("12th_marksheet");
                        %>
                        <input type="file" name="12th_marksheet" id="uploadfile"
                               <%= (marksSheet12 != null && !marksSheet12.isEmpty()) ? "disabled" : ""%>>
                    </div>
                    <div class="col-md-9">
                        <% if (marksSheet12 != null && !marksSheet12.isEmpty()) {%>
                        <label>
                            <a class='text-success' href="http://localhost:8080/mcaproject/<%= marksSheet12%>">
                                <%= marksSheet12.substring(6)%>
                            </a>
                        </label>
                        <% }%>
                    </div>
                </div>
            </fieldset>
            <!-- Bachelors Details -->
            <fieldset class="mt-3 p-4 border border-1 border-dark rounded">
                <legend class="w-auto">Bachelors Details</legend>
                <hr>

                <div class="row">
                    <div class="col-md-4">
                        <label for="">Bachelor Stream</label>
                        <input type="text" class="form-control" name="bachelor_stream"
                               value="<%= details.get("bachelor_stream")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">Bachelor College</label>
                        <input type="text" class="form-control" name="bachelor_college"
                               value="<%= details.get("bachelor_college")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">Bachelor University</label>
                        <input type="text" class="form-control" name="bachelor_university"
                               value="<%= details.get("bachelor_university")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <label for="">Bachelor Total Cgpa</label>
                        <input type="text" class="form-control" name="bachelor_total_cgpa"
                               value="<%= details.get("bachelor_total_cgpa")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">Bachelor Obtained Cgpa</label>
                        <input type="text" class="form-control" name="bachelor_obtained_cgpa"
                               value="<%= details.get("bachelor_obtained_cgpa")%>">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-3">
                        <label for="">Bachelor degree : </label>
                        <%
                            String bachelordegree = (String) details.get("bachelor_degree");
                        %>
                        <input type="file" name="bachelor_degree" id="uploadfile"
                               <%=bachelordegree != null && !bachelordegree.isEmpty() ? "disabled" : ""%>>
                    </div>
                    <div class="col-md-9">
                        <% if (bachelordegree != null && !bachelordegree.isEmpty()) {%>
                        <label>
                            <a class='text-success' href="http://localhost:8080/mcaproject/<%=bachelordegree%>">
                                <%=bachelordegree.substring(6)%>
                            </a>
                        </label>
                    </div>
                    <% } %>
                </div>
            </fieldset>
            <!-- Back Button  -->
            <div class="row my-3">
                <div class="col-md-12">
                    <a href="allstudentdetails.jsp" class="btn btn-dark">Back</a>
                </div>
            </div>
        </form>
        <%      } else {

        %>
        <script>
            alert('Student ID <%= studentid%> not found!🚫🚫🚫');

            window.location.href = "http://localhost:8080/mcaproject/allstudentdetails.jsp";</script>
            <%
                        }
                    }
                }
            %>
    </div>
</div>