<%@page import="java.util.Map"%>
<%@ page import="mca.MainClass"%>
<%@ page import="java.util.List" %>
<%@ include file="header.jsp" %>

<%    MainClass obj = new MainClass();

    if (session.getAttribute("current_userid") != null) {
        if (session.getAttribute("current_userid").equals("admin")) {
%>
<table class="container text-capitalize shadow text-center my-5 table table-bordered table-hover">
    <tr class="alert-primary">
        <th>Subject Code</th>
        <th>Subject Name</th>
        <th>Subject Type</th>
        <th>Subject Internal Marks</th>
        <th>Subject External Marks</th>
        <th>Branch</th>
        <th>Semester</th>
        <th>Faculty</th>
        <th>Active</th>
        <th colspan="2">
            <a href="add_course_details.jsp" class="btn btn-dark">Add Course</a>
    <form action="" method="post" class="row mx-auto p-3">
        <div class="col-md-9 px-1">
            <input type="search" name="branch" placeholder="Branch" class="form-control">
        </div>
        <button type="submit" class="col-md-3 btn btn-dark btn-sm my-1" name="branch_search_btn">
            <i class="fas fa-search"></i>
        </button>
    </form>
</th>
</tr>
<%
    List<Map<String, Object>> subjectsList;

    if (request.getParameter("branch_search_btn") != null) {
        String branch = request.getParameter("branch");
        subjectsList = obj.getSubjectsListByBranch(branch);
    } else {
        subjectsList = obj.get_subjects_list();
    }

    if (subjectsList != null && !subjectsList.isEmpty()) {
        for (Map<String, Object> subject : subjectsList) {
            Map<String, Object> faculty = obj.get_faculty((String) subject.get("faculty_id"));
//            Map<String, Object> faculty = obj.get_faculty(subject.get("faculty_id"));
//            Map<String, Object> faculty = obj.get_faculty(String.valueOf(subject.get("faculty_id")));

%>

<tr class="alert-warning">
    <td><%= subject.get("subject_code")%></td>
    <td><%= subject.get("subject_name")%></td>
    <td><%= subject.get("subject_type")%></td>
    <td><%= subject.get("subject_internal_marks")%></td>
    <td><%= subject.get("subject_external_marks")%></td>
    <td class="text-uppercase"><%= subject.get("branch")%></td>
    <td><%= subject.get("semester")%></td>
    <td><%= faculty != null ? (faculty.get("faculty_nam") + " " + faculty.get("faculty_na") + " " + faculty.get("faculty_name")) : "-----"%></td>
    <td>
        <% if (subject.get("active").equals("yes")) { %>
        <i class="fa fa-check" style="font-size:36px;color:green"></i>
        <% } else if (subject.get("active").equals("no")) { %>
        <i class="fa fa-close" style="font-size:36px;color:red"></i>
        <% }%>
    </td>
    <td><a class="btn-sm btn btn-success" href="subject_details.jsp?sid=<%= subject.get("sid")%>">Update</a></td>
    <td><a class="btn-sm btn btn-danger" href="subject_delete.jsp?sid=<%= subject.get("sid")%>">Delete</a></td>
</tr>
<%
    }
} else {
%>
<tr>
    <td colspan="8" class="text-center text-danger">Data is not found</td>
</tr>
<%
    }
%>
</table>
<%
        } else {
//            out.println("<p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i> Something Went Wrong  !!</p>");
        out.println("<p class='h5 alert-danger p-5 text-center container my-5'>Oops! Something went wrong. Please try again later.</p>");
        }
    } else {
        response.sendRedirect("error.jsp");
    }
%>
<%@ include file="footer.jsp" %>
