<%-- 
    Document   : student_details
    Created on : 7 Jun, 2023, 9:16:37 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.io.File"%>
<%@page import="java.util.Map"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>    

<!DOCTYPE html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
</head>

<%    if (session.getAttribute("current_userid") != null) {
        MainClass obj = new MainClass();
        Map<String, Object> student = obj.get_student_by_userid((String) session.getAttribute("current_userid"));
//        out.println(student);
//        out.println(session.getAttribute("current_userid"));
        Map<String, Object> student_details = obj.get_student_details((String) session.getAttribute("current_userid"));
//        out.println(student_details);
        String marksSheet12 = (String) student_details.get("12th_marksheet");
        String profilePic = (String) student_details.get("profile_pic");
        String defaultPic = "site_img/default.png"; // Provide the path to your default image
%>
<div class="container mt-3">
    <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
        <h1 class="rounded text-center py-2">Student Profile</h1>
        <form action="updatestudent" method="post" enctype="multipart/form-data">

            <!-- Personal Details -->
            <fieldset class="border p-4 border border-1 border-dark rounded">
                <legend class="w-auto">Personal Details</legend>
                <hr>
                <div class="row my-2">
                    <div class="col-md-2 mx-auto mt-2">
                        <%-- Check if profile picture is available, display it; otherwise, show default image --%>
                        <a class="img-link" href="<%= (profilePic != null && !profilePic.isEmpty()) ? profilePic : defaultPic%>" target="">
                            <img class="img-fluid" style="width: 100px; height: 100px;" src="<%= (profilePic != null && !profilePic.isEmpty()) ? profilePic : defaultPic%>" alt="">
                        </a>
                        <label>
                            <a class='text-success' href="<%= (profilePic != null && !profilePic.isEmpty()) ? profilePic : defaultPic%>">
                                <!-- You can add some additional text here if needed -->
                            </a>
                        </label>
                    </div>
                    <div class="col-md-4">
                        <label for="">User Id</label>
                        <input type="text" class="form-control" name="userid"
                               value="<%= student.get("student_id")%>" readonly>
                    </div>

                    <div class="col-md-4">
                        <label for="">Password</label>
                        <input type="text" class="form-control" name="password"
                               value="<%= student.get("password")%>" readonly>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-4">
                        <label for="">Firstname</label>
                        <input type="text" class="form-control" name="firstname"
                               value="<%= student.get("first_name")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Middlename</label>
                        <input type="text" class="form-control" name="middlename"
                               value="<%= student.get("middle_name")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="">Lastname</label>
                        <input type="text" class="form-control" name="lastname"
                               value="<%= student.get("last_name")%>" readonly>
                    </div>
                </div>
                <div class="row my-2 g-2">
                    <div class="col-md-4">
                        <label for="">Gender</label><br>
                        <input class="form-check-input" type="radio" name="gender" id="male" value="male"
                               <%= student.get("gender").equals("male") ? "checked" : ""%>>
                        <span for="">Male&nbsp;</span>
                        <input class="form-check-input" type="radio" name="gender" id="female" value="female"
                               <%= student.get("gender").equals("female") ? "checked" : ""%>>
                        <span class="" for="">Female&nbsp;</span>
                        <input class="form-check-input" type="radio" name="gender" id="other" value="other"
                               <%= student.get("gender").equals("other") ? "checked" : ""%>>
                        <span class="" for="">Other</span>
                    </div>
                    <div class="col-md-4">
                        <label for="">Date of Birth</label>
                        <input type="date" class="form-control" name="dob"
                               value="<%= student.get("dob")%>" readonly>
                    </div>
                    <div class="col-md-4">
                        <label for="blood_group">Select Blood Group</label><br>
                        <select name="blood_group" class="form-control col-md-4">
                            <option value=""  selected>-- Choose BLOOD GROUP --</option>
                            <option value="A" <%= student_details.get("blood_group").equals("A") ? "selected" : ""%>>A</option>
                            <option value="A+" <%= student_details.get("blood_group").equals("A+") ? "selected" : ""%>>A+</option>
                            <option value="B" <%= student_details.get("blood_group").equals("B") ? "selected" : ""%>>B</option>
                            <option value="B+" <%= student_details.get("blood_group").equals("B+") ? "selected" : ""%>>B+</option>
                            <option value="O" <%= student_details.get("blood_group").equals("O") ? "selected" : ""%>>O</option>
                            <option value="O+" <%= student_details.get("blood_group").equals("O+") ? "selected" : ""%>>O+</option>
                        </select>
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col-md-6">
                        <label for="">Select Course</label><br>
                        <div class="dropdown">
                            <select name="branch" class="form-control col-md-4">
                                <option value="MCA" <%= student.get("branch").equals("MCA") ? "selected" : ""%>>MCA</option>
                                <option value="MSCIT" <%= student.get("branch").equals("MSCIT") ? "selected" : ""%>>MSCIT</option>
                                <option value="BCA" <%= student.get("branch").equals("BCA") ? "selected" : ""%>>BCA</option>
                                <option value="BSCIT" <%= student.get("branch").equals("BSCIT") ? "selected" : ""%>>BSCIT</option>
                            </select>
                        </div>
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col-md-6">
                        <label for="">Email</label>
                        <input type="email" class="form-control" name="email"
                               value="<%= student.get("email")%>" readonly>
                    </div>
                    <div class="col-md-6">
                        <label for="">Contact</label>
                        <input type="number" class="form-control" name="contact"
                               value="<%= student.get("contact_no")%>">
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col-md-12">
                        <label for="">Address</label>
                        <textarea class="form-control" name="address" rows="3" cols="12"><%= student.get("address")%></textarea>
                    </div>
                </div>
                <div class="row my-2">
                    <div class="col-md-6">
                        <label for="">City</label>
                        <input type="text" class="form-control" name="city"
                               value="<%= student.get("city")%>">
                    </div>
                    <div class="col-md-6">
                        <label for="">State</label>
                        <input type="text" class="form-control" name="state"
                               value="<%= student.get("state")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="row mt-3">
                        <div class="col-md-3">
                            <%
//                                String profilePic = (String) student_details.get("profile_pic");
                            %>
                            <label for="">Profile Image</label>
                            <input type="file" name="profile" id="uploadfile"
                                   <%= (profilePic != null && !profilePic.isEmpty()) ? "disabled" : ""%> 
                                   accept="image/*" onchange="checkFileSize('uploadfile', 'fileSizeErrorp')">
                            <span id="fileSizeErrorp" style="color: red;"></span>
                        </div>
                        <div class="col-md-6">
                            <%
                                if (profilePic != null && !profilePic.isEmpty()) {%>
                            <label>
                                <a class='text-success' href="http://localhost:8080/mcaproject/<%= profilePic%>">
                                    <%= profilePic.substring(6)%>
                                </a>
                            </label>
                            <button type="submit" name="profile_clear" value="Clear" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button>
                        </div>
                        <%
                            }%>
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
                        <input type="text" class="form-control" name="10th_school"
                               value="<%= student_details.get("10th_school")%>">
                    </div>
                    <div class="col-md-6">
                        <label for="">10th Board</label>
                        <input type="text" class="form-control" name="10th_board"
                               value="<%= student_details.get("10th_board")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-6">
                        <label for="">10th Total Marks</label>
                        <input type="text" class="form-control" name="10th_total_marks"
                               value="<%= student_details.get("10th_total_marks")%>">
                    </div>
                    <div class="col-md-6">
                        <label for="">10th Obtained Marks</label>
                        <input type="text" class="form-control" name="10th_obtained_marks"
                               value="<%= student_details.get("10th_obtained_marks")%>">
                    </div>
                </div>
                <div class="row mt-3 ">
                    <div class="col-md-3">
                        <label for="">10th Marks sheet</label>
                        <%
                            String marksSheet10 = (String) student_details.get("10th_marksheet");
                        %>
                        <input type="file" name="10th_marksheet" id="uploadfile10"
                               <%= (marksSheet10 != null && !marksSheet10.isEmpty()) ? "disabled" : ""%> 
                               accept="image/*" onchange="checkFileSize('uploadfile10', 'fileSizeError10')">
                        <span id="fileSizeError10" style="color: red;"></span>
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

                        <button type="submit" name="10th_marksheet_clear" value="Clear" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button>
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
                               value="<%= student_details.get("12th_stream")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">12th School</label>
                        <input type="text" class="form-control" name="12th_school"
                               value="<%= student_details.get("12th_school")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">12th Board</label>
                        <input type="text" class="form-control" name="12th_board"
                               value="<%= student_details.get("12th_board")%>">
                    </div>
                </div>
                <div class="row mt-2">
                    <div class="col-md-4">
                        <label for="">12th Total Marks</label>
                        <input type="text" class="form-control" name="12th_total_marks"
                               value="<%= student_details.get("12th_total_marks")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">12th Obtained Marks</label>
                        <input type="text" class="form-control" name="12th_obtained_marks"
                               value="<%= student_details.get("12th_obtained_marks")%>">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-3 mt-2">
                        <label for="">12th Marks sheet</label>
                        <%
//                            String marksSheet12 = (String) student_details.get("12th_marksheet");
                        %>
                        <input type="file" name="12th_marksheet" id="uploadfile12"
                               <%= (marksSheet12 != null && !marksSheet12.isEmpty()) ? "disabled" : ""%>
                               accept="image/*" onchange="checkFileSize('uploadfile12', 'fileSizeError12')">
                        <span id="fileSizeError12" style="color: red;"></span>

                    </div>
                    <div class="col-md-9">
                        <% if (marksSheet12 != null && !marksSheet12.isEmpty()) {%>
                        <label>
                            <a class='text-success' href="http://localhost:8080/mcaproject/<%= marksSheet12%>">
                                <%= marksSheet12.substring(6)%>
                            </a>
                        </label>
                        <button type="submit" name="12_marksheet_clear" value="Clear" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button>
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
                               value="<%= student_details.get("bachelor_stream")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">Bachelor College</label>
                        <input type="text" class="form-control" name="bachelor_college"
                               value="<%= student_details.get("bachelor_college")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">Bachelor University</label>
                        <input type="text" class="form-control" name="bachelor_university"
                               value="<%= student_details.get("bachelor_university")%>">
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4">
                        <label for="">Bachelor Total Cgpa/Percentage</label>
                        <input type="text" class="form-control" name="bachelor_total_cgpa"
                               value="<%= student_details.get("bachelor_total_cgpa")%>">
                    </div>
                    <div class="col-md-4">
                        <label for="">Bachelor Obtained Cgpa/Percentage</label>
                        <input type="text" class="form-control" name="bachelor_obtained_cgpa"
                               value="<%= student_details.get("bachelor_obtained_cgpa")%>">
                    </div>
                </div>
                <div class="row mt-3">
                    <div class="col-md-3">
                        <label for="">Bachelor degree : </label>
                        <%
                            String bachelordegree = (String) student_details.get("bachelor_degree");
                        %>
                        <input type="file" name="bachelor_degree" id="uploadfileBachelor"
                               <%=bachelordegree != null && !bachelordegree.isEmpty() ? "disabled" : ""%>
                               accept="image/*" onchange="checkFileSize('uploadfileBachelor', 'fileSizeErrorBachelor')">
                        <span id="fileSizeErrorBachelor" style="color: red;"></span>

                    </div>
                    <div class="col-md-9">
                        <% if (bachelordegree != null && !bachelordegree.isEmpty()) {%>
                        <label>
                            <a class='text-success' href="http://localhost:8080/mcaproject/<%=bachelordegree%>">
                                <%=bachelordegree.substring(6)%>
                            </a>
                        </label>

                        <button type="submit" name="degree_clear" value="Clear" class="btn btn-danger"><i class="fa-solid fa-trash"></i></button>
                    </div>
                    <% } %>
                </div>
            </fieldset>
            <!-- Update Button  -->
            <div class="row my-3">
                <div class="col-md-12">
                    <input type="submit" class="btn btn-dark" name="updateregistrationbtn" value="Update">&nbsp;
                    <a href="student_dashboard.jsp" class="btn btn-dark">Back</a>
                </div>
            </div>
        </form>
    </div>
</div>
<%
    }
%>
<script>
            function checkFileSize(inputId, errorId) {
            const maxSizeInBytes = 1024 * 1024; // 1MB (adjust as needed)
                    const input = document.getElementById(inputId);
                    const fileSize = input.files[0].size;
                    const fileSizeInMB = fileSize / (1024 * 1024); // Convert to MB

//                    const fileSizeErrorId = "fileSizeError" + inputId.substr( - 2);
                    const fileSizeError = document.getElementById(errorId);
                    const submitButton = document.querySelector('input[type="submit"]');
//                    const fileSizeError = document.getElementById("fileSizeError");
//                    const submitButton = document.querySelector('input[type="submit"]');
                    if (fileSize > maxSizeInBytes) {
            fileSizeError.textContent = "File size exceeds the allowed limit (1MB). Please choose a smaller file.";
                    input.value = ""; // Clear the file input
                    submitButton.disabled = true; // Disable form submission
            } else {
            fileSizeError.textContent = ""; // Clear any previous error message
                    submitButton.disabled = false; // Enable form submission
            }
            }
</script>

