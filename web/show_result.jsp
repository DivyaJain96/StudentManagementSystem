<%-- 
    Document   : show_result
    Created on : 17 Oct, 2023, 7:48:56 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
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
                if (session.getAttribute("current_userrole").equals("admin")) {
//                    int student_semester = Integer.parseInt(request.getParameter("student_semester"));
                    MainClass obj = new MainClass();

        %>
        <div class="container my-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded" >
                <div class="row">
                    <div class="col-md-4">
                        <label for="branch">StudentId</label>
                        <form action="" method="post">
                            <input type="text" name="studentid" required="" placeholder="Enter a Student Id">
                            <!--                            <label></label>
                                                        <button type="submit" class="btn btn-dark mt-4" name="search_result">
                                                            <i class="fas fa-search"></i>
                                                        </button>
                                                    </form>-->
                            </div>
                            <!--<div class="row my-3">-->
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
                            <!--</div>-->
                            <div class="col-md-12">
                                <label for="sem">Select Semester</label><br>
                                <div class="dropdown">
                                    <select name="sem" id="sem" class="form-control" required>
                                        <option value="" selected disabled>---SELECT---</option>
                                        <!--<option value="MCA">MCA</option>-->
                                        <!--<option value="MSCIT">MSCIT</option>-->
                                        <!--<option value="BCA">BCA</option>-->
                                        <!--<option value="BSCIT">BSCIT</option>-->
                                    </select>
                                </div>
                            </div>
                            <label></label>
                            <button type="submit" class="btn btn-dark mt-4" name="search_result">
                                <i class="fas fa-search"></i>
                            </button>
                            <!--<a href="dashboard.jsp" class="btn btn-dark">Back</a>-->
                        </form>
                    </div>
                </div>
            </div>
            <%                if (request.getParameter("search_result") != null) {
                    String studentid = request.getParameter("studentid");
                    String branch = request.getParameter("branch");
                    int sem = Integer.parseInt(request.getParameter("sem"));
                    // Step 1: Check if the student ID exists
                    boolean checkIdExists = obj.checkIdExists(studentid);
                    if (checkIdExists) {
                        // Step 2: Check if the branch is valid
                        boolean branchIsValid = obj.checkBranchExists(studentid, branch);
                        if (branchIsValid) {
                            // Step 3: Check if results for the specified semester exist
                            boolean resultsExist = obj.checkResultsExist(studentid, sem);
                            if (resultsExist) {
                                // If all conditions are met, proceed to fetch and display results
                                HashMap<String, Object> currentStudent = obj.get_student_by_userid(studentid);
                                List<Map<String, Object>> getResults = obj.getStudentResults(studentid, sem);
                                int resultCount = getResults.size();
                                int totalMarks = 0;
                                int obtainedMarks = 0;
                                // Calculate CGPA
                                double cgpa = 0.0; // Initialize CGPA to 0.0
                                if (totalMarks > 0) {
                                    cgpa = ((double) obtainedMarks / totalMarks) * 10;
                                }%>

            <table class="table alert-info my-4">
                <tr>
                    <td class="text-end"><label for="name">Name</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%= currentStudent.get("first_name") + " " + currentStudent.get("middle_name") + ". " + currentStudent.get("last_name")%></td>
                    <td class="text-end">
                        <label>Stud. ID</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%= currentStudent.get("student_id")%></td>
                </tr>
                <tr>
                    <td class="text-end">
                        <label>Program</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%=currentStudent.get("branch")%></td>
                    <td class="text-end">
                        <label>Semester</label></td>
                    <td>:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <%= sem%>
                    </td>

                </tr>
            </table>
            <table class="table alert-warning table-borderless mt-3">
                <tr style="color:red;">
                    <th style="font-weight:bold">Subject Code</th>
                    <th style="font-weight:bold">Subject Name</th>
                    <th style="font-weight:bold">Subject Type</th>
                    <th style="font-weight:bold">Subject Total Marks</th>
                    <th style="font-weight:bold">Subject Internal Marks</th>
                    <th style="font-weight:bold">Subject External Marks</th>
                    <th style="font-weight:bold">Grade</th>


                </tr>
                <%
                    for (int i = 0; i < resultCount; i++) {
                        Map<String, Object> result = getResults.get(i);
                %>

                <tr>
                    <td><%= result.get("subject_code")%></td>
                    <td><%= result.get("subject_name")%></td>
                    <td><%= result.get("subject_type")%></td>
                        <td><%= (Integer.parseInt(result.get("subject_external_marks").toString())
                            + Integer.parseInt(result.get("subject_internal_marks").toString()))%></td>
                    <td><%= (Integer.parseInt(result.get("internal_obtained_marks").toString()))%></td>
                    <td><%= (Integer.parseInt(result.get("external_obtained_marks").toString()))%></td>
                    <td><%=result.get("status")%></td>
                    <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <a class="btn-sm btn btn-success" href="update_result.jsp?student_id=<%= currentStudent.get("student_id")%>&sem=<%= sem%>&branch=<%= branch%>
                           &subjectcode=<%=result.get("subject_code")%>&subjectname=<%=result.get("subject_name")%>
                           &subjecttype=<%= result.get("subject_type")%>
                           &internalmark=<%=Integer.parseInt(result.get("internal_obtained_marks").toString())%>
                           &externalmark=<%=Integer.parseInt(result.get("external_obtained_marks").toString())%>
                           ">Edit Marks</a>
                    </td>
                </tr>
                <%
                        totalMarks += (Integer.parseInt(result.get("subject_external_marks").toString()) + Integer.parseInt(result.get("subject_internal_marks").toString()));
                        obtainedMarks += (Integer.parseInt(result.get("internal_obtained_marks").toString())
                                + Integer.parseInt(result.get("external_obtained_marks").toString()));
                        // Calculate CGPA
                        if (totalMarks > 0) {
                            cgpa = ((double) obtainedMarks / totalMarks) * 10;
                        }
                    }
                    String formattedCGPA = String.format("%.2f", cgpa); // Formats to 2 decimal places
%>
                <tr class="mt-5">
                    <td colspan="6" style="text-align: right;color:red"><b>
                            GRAND TOTAL : <%= obtainedMarks%> / <%= totalMarks%>
                        </b></td>
                </tr>
                <tr class="mt-5">
                    <td colspan="6" style="text-align: right;color:red"><b>
                            GRAND CGPA  : <%= formattedCGPA%>
                        </b></td>
                </tr> 
            </table>

            <%
            } else {
                // If results for the specified semester do not exist, display a message
            %>
            <p class="alert-danger">Results for this semester are pending.</p>
            <%
                }
            } else {
                // If the branch is not valid, display a message
            %>
            <p class="alert-danger">Invalid branch selected. For this Student Id</p>
            <%
                }
            } else {
                // If the student ID does not exist, display a message
            %>
            <p class="alert-danger">Student does not exist.</p>
            <%
                    }
//                    else {
//                        out.println("<script>alert('Id is not exists'); "
//                                                + "window.location.href = 'http://localhost:8080/mcaproject/show_result.jsp'</script>");
//                        }
                }

            %>
            <script>
                const branch = document.getElementById('branch');
                        const sem = document.getElementById('sem');
                        branch.addEventListener('change', () => {
                        if (branch.value == 'mca' || branch.value == 'mscit' || branch.value == 'MCA' || branch.value == 'MSCIT') {
                        sem.innerHTML = "";
                                //select2.innerHTML = "";
                                for (var i = 1; i <= 4; i++) {
                        op = document.createElement('option');
                                op.value = i;
                                op.innerHTML = i;
                                sem.appendChild(op);
                        }

                        } else {
                        sem.innerHTML = "";
                                // select2.innerHTML = "";
                                for (var i = 1; i <= 6; i++) {
                        op = document.createElement('option');
                                op.value = i;
                                op.innerHTML = i;
                                sem.appendChild(op);
                        }

                        }

                        }
                        );
            </script>
            <%            } else { %>
            <p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle'
                                                                         aria-hidden='true'></i>&nbsp;Access Denied!</p>
                <%
                        }

                    }

                %>
    </body>
</html>
<%@ include file="footer.jsp" %>
