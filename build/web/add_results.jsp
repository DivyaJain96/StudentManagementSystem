<%-- 
    Document   : add_results
    Created on : 5 Jun, 2023, 8:55:12 PM
    Author     : Divya Kumar Jain
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.List" %>
<%@ page import="mca.MainClass" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userrole").equals("admin")) {
//                    int student_semester = Integer.parseInt(request.getParameter("student_semester"));
                    MainClass obj = new MainClass();
        %>
        <div class="container my-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded" >
                <h1>Add Results</h1>
                <hr>
                <form action="" method="post">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="branch">Branch</label>
                            <div class="dropdown">
                                <select name="student_branch" class="form-select col-md-4" required>
                                    <option value="" disabled selected>--Select--</option>
                                    <option value="MCA" <% if (request.getParameter("student_branch") != null
                                                && request.getParameter("student_branch").equals("MCA")) { %>
                                            selected
                                            <% } %>>MCA</option>
                                    <option value="MSCIT" <% if (request.getParameter("student_branch") != null
                                                && request.getParameter("student_branch").equals("MSCIT")) { %>
                                            selected
                                            <% } %>>MSCIT</option>
                                    <option value="BCA" <% if (request.getParameter("student_branch") != null
                                                && request.getParameter("student_branch").equals("BCA")) { %>
                                            selected
                                            <% } %>>BCA</option>
                                    <option value="BSCIT" <% if (request.getParameter("student_branch") != null
                                                && request.getParameter("student_branch").equals("BSCIT")) { %>
                                            selected
                                            <% } %>>BSCIT</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="semester">Semester</label>
                            <div class="dropdown">
                                <select name="student_semester" class="form-select col-md-4" required>
                                    <option value="" disabled selected>--Select--</option>
                                    <option value="1" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("1")) { %>
                                            selected
                                            <% } %>>1</option>
                                    <option value="2" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("2")) { %>
                                            selected
                                            <% } %>>2</option>
                                    <option value="3" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("3")) { %>
                                            selected
                                            <% } %>>3</option>
                                    <option value="4" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("4")) { %>
                                            selected
                                            <% } %>>4</option>
                                    <option value="5" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("5")) { %>
                                            selected
                                            <% } %>>5</option>
                                    <option value="6" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("6")) { %>
                                            selected
                                            <% } %>>6</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label></label>
                            <button type="submit" class="btn btn-dark mt-4" name="search_subjects">
                                <i class="fas fa-search"></i>
                            </button>
                        </div>
                    </div>
                    <!-- </form> -->
                    <%if (request.getParameter("search_subjects") != null) {
                            String branch = request.getParameter("student_branch");
                            int semester = Integer.parseInt(request.getParameter("student_semester"));
//                            out.print(branch);
//                            out.print(semester);
                            List<Map<String, Object>> courseDetails = obj.get_active_course_details_by_branch_and_semester(branch, semester);
//                            out.print(courseDetails);
                            List<Map<String, Object>> students = obj.get_students_by_branch_and_semester(branch, semester);
//                            out.print(students);
                            if (courseDetails != null && !courseDetails.isEmpty()) {
                    %>

                    <!-- <form action="" method="post"> -->
                    <div class="row my-3">
                        <div class="col-md-4 my-1">
                            <label for="studentid">Student ID </label>
                            <div class="dropdown">
                                <select name="student_id" class="form-select col-md-4" required>
                                    <% for (Map<String, Object> student : students) {%>
                                    <option value="<%= student.get("student_id")%>"><%= student.get("student_id")%></option>
                                    <% }%>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4 my-1">
                            <label for="exam">Exam </label>
                            <div class="dropdown">
                                <select name="exam_type" class="form-select" id="exam_type" required onchange="updateTitles()">
                                    <option value="" disabled selected>--Select--</option>
                                    <option value="internal">Internal</option>
                                    <option value="external">External</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <% for (Map<String, Object> course : courseDetails) {%>
                        <%                    // Fetch allowed internal and external mark ranges from the database
                            Map<String, Integer> markRanges = obj.getMarkRanges(course.get("subject_code").toString());
                            int internalMin = 0;  // Modify to fetch from the database
                            int internalMax = markRanges.get("internalMax");
//                            out.print(internalMax);
                            int externalMin = 0;  // Modify to fetch from the database
                            int externalMax = markRanges.get("externalMax");
                        %>
                        <script>
                                    function updateTitles() {
                                    var examType = document.getElementById("exam_type").value;
                                            var inputFields = document.querySelectorAll('input[type="number"]');
                                            inputFields.forEach(function (input) {
                                            var title = "";
                                                    if (examType === 'internal') {
                                            title = "Please enter a number between " + <%= internalMin%> + " and " + <%= internalMax%>;
                                                    input.min = <%= internalMin%>;
                                                    input.max = <%= internalMax%>;
                                            } else {
                                            title = "Please enter a number between " + <%= externalMin%> + " and " + <%= externalMax%>;
                                                    input.min = <%= externalMin%>;
                                                    input.max = <%= externalMax%>;
                                            }
                                            input.title = title;
                                            });
                                    }
                        </script>

                        <div class="col-md-6">
                            <label for="course" class="my-1">
                                <%= course.get("subject_code") + "-" + course.get("subject_name") + "-" + course.get("subject_type")%></label>

                            <c:choose>
                                <c:when test="${exam_type eq 'internal'}">
                                    <input type="number" class="form-control" name="<%= course.get("sid")%>" value="" required
                                           oninput="validateMarks(this)" min="<%=internalMin%>" max="<%=internalMax%>"
                                           maxlength="3" pattern="^\d{1,3}$" 
                                           >
                                </c:when>
                                <c:otherwise>
                                    <input type="number" class="form-control" name="<%= course.get("sid")%>" value="" required
                                           oninput="validateMarks(this)" min="<%=externalMin%>" max="<%=externalMax%>"
                                           maxlength="3" pattern="^\d{1,3}$" 
                                           >
                                </c:otherwise>
                            </c:choose>
                            <div id="internalMarksError" style="color: red;"></div>
                        </div>
                        <% }%>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mt-4">
                            <input type="submit" name="add_results" class="btn btn-dark" value="Add Result">
                            <a href="dashboard.jsp" class="btn btn-dark">Back</a>
                        </div>
                    </div>
                </form>
                <% }
                    }
                    if (request.getParameter("add_results") != null) {
                        String studentId = request.getParameter("student_id");
                        String branch = request.getParameter("student_branch");
                        int semester = Integer.parseInt(request.getParameter("student_semester"));
                        String examType = request.getParameter("exam_type");
                        String msg = "";
                        String exa = "";
                        // Get subjects based on branch and semester
                        boolean status = true;
                        //                        boolean status = false;
                        List<Map<String, Object>> subjects = obj.get_active_course_details_by_branch_and_semester(branch, semester);
                        //                        out.print(subjects);
                        List<Map<String, Object>> internalRecords = obj.check_internal_records(studentId, semester);
                        //                        int internalRecords = obj.check_internal_records(studentId,semester);
                        //                        out.print(internalRecords);
                        if (internalRecords != null && !internalRecords.isEmpty()) {
                            // Add external marks
                            if (examType.equals("internal")) {
                                status = false;
                                msg = "Internal marks already exist";
                            } else if (examType.equals("external")) {
                                // Check if external records exist
                                int checkExternalRecords = obj.check_external_records(studentId, semester);
                                if (checkExternalRecords > 0) {
                                    msg = "External marks already exist";
                                } else {
                                    for (Map<String, Object> record : internalRecords) {
                                        int subId = Integer.parseInt(record.get("subject_id").toString());
                                        //                                        String s = request.getParameter(String.valueOf(subId));
                                        int external_marks = Integer.parseInt(request.getParameter(String.valueOf(subId)));

                                        int add_external_marks = obj.addExternalMarks(studentId, subId, semester, exa, external_marks);

                                        //                                        
                                        //                                        String subId = record.get("subject_id").toString();
                                        //                                        int external_marks = Integer.parseInt(request.getParameter(subId));
                                        //                                        int addExternalMarks = obj.add_external_marks(studentId, subId, sem, exam, external_marks);
                                        if (add_external_marks > 0) {
                                            msg = "External marks added successfully";
                                        } else {
                                            msg = "External marks are not added";
                                            break;
                                        }
                                    }
                                }
                            }
                        } else {
                            // add internal marks
                            if (examType.equals("external")) {
                                status = false;
                                msg = "Please add internal marks first.";
                            } else {
                                for (Map<String, Object> sub : subjects) {
                                    int subid = Integer.parseInt(sub.get("sid").toString());
                                    int marks = Integer.parseInt(request.getParameter(String.valueOf(subid)));

                                    //                                    String subId = sub.get("sid").toString();
                                    //                                    String marks = request.getParameter(subId);
                                    if (examType.equals("internal")) {
                                        int addMarks = obj.add_internal_marks(studentId, subid, semester, exa, marks);
                                        //                                        boolean addMarks = obj.add_internal_marks(studentId, subid, semester, "", marks);
                                        if (addMarks > 0) {
                                            status = true;
                                            msg = "Internal result added successfully";
                                        } else {
                                            status = false;
                                            msg = "Internal result is not added";
                                            break;
                                        }
                                    }
                                }
                            }
                        }

                        out.println("<script>alert('" + msg + "')</script>");
                        //                        response.sendRedirect("dashboard.jsp");
                    }

                %>
            </div>
        </div>
        <% } else {
                    response.sendRedirect("error.jsp");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
    </body>
</html>
<%@ include file="footer.jsp" %>

<script>
    function validateMarks(input) {
    const value = input.value;
            const errorElement = input.nextElementSibling;
            if (value.length > 3) {
    input.value = value.slice(0, 3);
            errorElement.textContent = "Please enter a two or three-digit number only";
    } else {
    errorElement.textContent = "";
    }
    }

</script>   