<%-- 
    Document   : edit_time_table
    Created on : 23 Nov, 2023, 8:34:22 PM
    Author     : Divya Kumar Jain
--%>
<%@ include file="header.jsp" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%    // Retrieve parameters
    String branch = request.getParameter("branch");
//    out.print(branch);
    String subject_nam = request.getParameter("subject_name");
//    out.print(subject_nam);
    int semester = Integer.parseInt(request.getParameter("semester"));
    int timeTableId = Integer.parseInt(request.getParameter("timeTableId"));
//    out.println(branch + "" + semester + "" + timeTableId);
    // Use the parameters to fetch the timetable entry from the database
    MainClass obj = new MainClass();
    List<Map<String, Object>> course_details = obj.get_active_course_details_by_branch_and_semester(branch, semester);
    Map<String, Object> tt = obj.getTimetableEntryById(timeTableId);
    //    out.println(tt);
%>
<div class="container">
    <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
        <h1>Edit Timetable Details</h1>
        <hr>
        <form action="update_time_table.jsp" method="post">
            <input type="hidden" name="timeTableId" value="<%=timeTableId%>">
            <label>Day</label>
            <select name="day" id="day" class="form-select" required>
                <option value="monday" <%= tt.get("day").equals("monday") ? "selected" : ""%>>Monday</option>
                <option value="tuesday" <%= tt.get("day").equals("tuesday") ? "selected" : ""%>>Tuesday</option>
                <option value="wednesday" <%= tt.get("day").equals("wednesday") ? "selected" : ""%>>Wednesday</option>
                <option value="thursday" <%= tt.get("day").equals("thursday") ? "selected" : ""%>>Thursday</option>
                <option value="friday" <%= tt.get("day").equals("friday") ? "selected" : ""%>>Friday</option>
                <option value="saturday" <%= tt.get("day").equals("saturday") ? "selected" : ""%>>Saturday</option>
                <option value="sunday" <%= tt.get("day").equals("sunday") ? "selected" : ""%>>Sunday</option>
            </select>
            <div class="my-2">
                <label class="">Time Start</label>
                <input type="time" name="timestart" class="form-control" required value="<%= tt.get("time_start")%>">
            </div>
            <div class="my-2">
                <label class="">Time End</label>
                <input type="time" name="timeend" class="form-control" value="<%= tt.get("time_start")%>" required>
            </div>
            <div class="my-2">
                <label for="branch">Branch</label>
                <select name="branch" id="branch" class="form-control" required disabled="">
                    <option value="bca" <%= tt.get("branch").equals("bca") ? "selected" : ""%>>BCA</option>
                    <option value="bscit" <%= tt.get("branch").equals("bscit") ? "selected" : ""%>>BSCIT</option>
                    <option value="mca" <%= tt.get("branch").equals("mca") ? "selected" : ""%>>MCA</option>
                    <option value="mscit" <%= tt.get("branch").equals("mscit") ? "selected" : ""%>>MSCIT</option>
                </select>
            </div>
            <label>Subject</label>
            <%--<c:out value="Debug: subject_name = ${param.subject_name}" />--%>
            <select name="subject" id="subjectDropdown" class="form-select" required="">
                <% for (Map<String, Object> subject : course_details) {%>
                <% out.println("Debug: subject_name = " + subject_nam); %>
                <% out.println("Debug: subject.get('subject_name') = " + subject.get("subject_name"));%>
                <option value="<%= subject.get("sid")%>" <%= subject_nam != null && subject_nam.equals(subject.get("subject_name")) ? "selected" : ""%>>
                    <%= subject.get("subject_name") + "-" + subject.get("subject_type")%>
                </option>
                <% }%>
            </select>
            <div class="my-2">
                <label class="semester">Semester</label>
                <select name="semester" id="select1" class="my-1 form-control" required>
                    <option value="1" <% if (tt.get("semester") != null && tt.get("semester").equals("1")) { %>selected<% } %>>1</option>
                    <option value="2" <% if (tt.get("semester") != null && tt.get("semester").equals("2")) { %>selected<% } %>>2</option>
                    <option value="3" <% if (tt.get("semester") != null && tt.get("semester").equals("3")) { %>selected<% } %>>3</option>
                    <option value="4" <% if (tt.get("semester") != null && tt.get("semester").equals("4")) { %>selected<% } %>>4</option>
                    <option value="5" <% if (tt.get("semester") != null && tt.get("semester").equals("5")) { %>selected<% } %>>5</option>
                    <option value="6" <% if (tt.get("semester") != null && tt.get("semester").equals("6")) { %>selected<% }%>>6</option>
                </select>
            </div>
            <label class="venue">Venue</label>
            <input type="text" placeholder="Venue" name="venue" class="form-control" value="<%= tt.get("venue")%>" required="">
            <div class="text-left my-3">
                <input type="submit" name="update_timetable" value="Update Timetable" class="btn btn-dark">
                <a href="add_time_table.jsp" class="btn btn-dark">Back</a>
            </div>
        </form>
    </div>
</div>
<%@ include file="footer.jsp" %>