<%-- 
    Document   : add_res
    Created on : 5 Jun, 2023, 8:52:38 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mca.MainClass"%>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Results</title>
    </head>
    <body>
        <%            if (session.getAttribute("current_userid") != null) {
                String currentUserId = (String) session.getAttribute("current_userid");
                if (currentUserId.equals("admin")) {
                    MainClass obj = new MainClass();
        %>
        <div class="container mt-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded" >
                <h1>Add Results</h1>
                <hr>
                <form action="" method="post">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="branch">Branch</label>
                            <div class="dropdown">
                                <select name="student_branch" class="form-select col-md-4" required>
                                    <option value="MCA" <% if (request.getParameter("student_branch") != null && request.getParameter("student_branch").equals("MCA")) {
                                            out.print("selected");
                                        } %>>MCA</option>
                                    <option value="MSCIT" <% if (request.getParameter("student_branch") != null && request.getParameter("student_branch").equals("MSCIT")) {
                                            out.print("selected");
                                        } %>>MSCIT</option>
                                    <option value="BCA" <% if (request.getParameter("student_branch") != null && request.getParameter("student_branch").equals("BCA")) {
                                            out.print("selected");
                                        } %>>BCA</option>
                                    <option value="BSCIT" <% if (request.getParameter("student_branch") != null && request.getParameter("student_branch").equals("BSCIT")) {
                                            out.print("selected");
                                        }%>>BSCIT</option>

                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="semester">Semester</label>
                            <div class="dropdown">
                                <select name="student_semester" class="form-select col-md-4" required>
                                    <option value="1" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("1")) {
                                            out.print("selected");
                                        } %>>1</option>
                                    <option value="2" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("2")) {
                                            out.print("selected");
                                        } %>>2</option>
                                    <option value="3" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("3")) {
                                            out.print("selected");
                                        } %>>3</option>
                                    <option value="4" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("4")) {
                                            out.print("selected");
                                        } %>>4</option>
                                    <option value="5" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("5")) {
                                            out.print("selected");
                                        } %>>5</option>
                                    <option value="6" <% if (request.getParameter("student_semester") != null && request.getParameter("student_semester").equals("6")) {
                                            out.print("selected");
                                        }%>>6</option>
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
                    <!--</form>--> 
                    <% if (request.getParameter("search_subjects") != null) {
                            String branch = request.getParameter("student_branch");
                            int semester = Integer.parseInt(request.getParameter("student_semester"));
                            List<Map<String, Object>> courseDetails = obj.get_active_course_details_by_branch_and_semester(branch, semester);
                            List<Map<String, Object>> students = obj.get_students_by_branch_and_semester(branch, semester);
                            if (courseDetails != null) {%>
                    <!--<form action="" method="post">--> 
                    <div class="row">
                        <div class="col-md-4">
                            <label for="studentid">Student ID</label>
                            <div class="dropdown">
                                <select name="student_id" class="form-control col-md-4" required>
                                    <% for (Map<String, Object> student : students) {%>
                                    <option value="<%= student.get("student_id")%>"><%= student.get("student_id")%></option>
                                    <% }%>
                                </select>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <label for="exam">Exam</label>
                            <div class="dropdown">
                                <select name="exam_type" class="form-control col-md-4" required>
                                    <option value="internal">Internal</option>
                                    <option value="external">External</option>
                                </select>
                            </div>
                        </div>

                    </div>
                    <div class="row">

                        <% for (Map<String, Object> course : courseDetails) {%>


                        <div class="col-md-4">
                            <label for="course"><%= course.get("subject_code")%> - <%= course.get("subject_name")%> - <%= course.get("subject_type")%></label>
                            <input type="number" class="form-control" name="<%= course.get("sid")%>" value="0" required>
                        </div>

                        <% }%>
                    </div>
                    <div class="row">
                        <div class="col-md-12 mt-3 text-center">
                            <input type="submit" name="add_results" class="btn btn-primary" value="Add">

                        </div>

                    </div>


                </form>
                <% }
                    }
                    if (request.getParameter("add_results") != null) {
//                        int studentId = Integer.parseInt(request.getParameter("student_id"));
                        String studentId = request.getParameter("student_id");
                        String branch = request.getParameter("student_branch");
                        int semester = Integer.parseInt(request.getParameter("student_semester").toString());
                        String examType = request.getParameter("exam_type");
                        String msg = "";
                        String exam = "";
                        List<Map<String, Object>> subjects = obj.get_active_course_details_by_branch_and_semester(branch, semester);
                        boolean status = true;
                        List<Map<String, Object>> internalRecords = obj.check_internal_records(studentId, semester);
                        if (internalRecords != null) {
                            if (examType.equals("internal")) {
                                status = false;
                                msg = "Internal marks already exist";
                            } else if (examType.equals("external")) {
                                int checkExternalRecords = obj.check_external_records(studentId, semester);
                                if (checkExternalRecords > 0) {
                                    msg = "External marks already exist";
                                } else {
                                    for (Map<String, Object> record : internalRecords) {
//                                        String subId = record.get("subject_id").toString();
                                        int subId = Integer.parseInt(record.get("subject_id").toString());
//                                        int externalMarks = request.getParameter(subId);
                                        int externalMarks = Integer.parseInt(record.get("subject_id").toString());
                                        int addExternalMarks = obj.addExternalMarks(studentId, subId, semester, exam, externalMarks);
                                        if (addExternalMarks > 0) {
                                            msg = "External marks added successfully";
                                        } else {
                                            msg = "External marks are not added";
                                            break;
                                        }
                                    }
                                }
                            }
                        } else {
                            if (examType.equals("external")) {
                                status = false;
                                msg = "Please add internal marks first.";
                            } else {
                                for (Map<String, Object> sub : subjects) {
                                    int subId = Integer.parseInt(sub.get("subject_id").toString());
//                                    int subId = sub.get("sid").toString();
//                                    String marks = request.getParameter(subId);
                                    int marks =  Integer.parseInt(sub.get("subject_id").toString());
                                    if (examType.equals("internal")) {
                                        int addMarks = obj.add_internal_marks(studentId, subId, semester, "", marks);
                                        if (addMarks>0) {
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
                    }
                %>
            </div>
        </div>
        <% } else {
                    out.println("something went wrong");
                }
            } else {
                response.sendRedirect("error.jsp");
            }
        %>
    </body>
</html>
<%@ include file="footer.jsp" %>