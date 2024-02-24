<%-- 
    Document   : add_tt
    Created on : 8 Jun, 2023, 6:12:48 PM
    Author     : Divya Kumar Jain
--%>

<%@ page import="mca.MainClass"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%    if (session.getAttribute("current_userid") != null) {
                String current_userrole = (String) session.getAttribute("current_userrole");
                if ("admin".equals(current_userrole)) {
                    MainClass obj = new MainClass();
                    String branc = request.getParameter("branch");
                    int semeste = Integer.parseInt(request.getParameter("semester"));
                    List<Map<String, Object>> course_details = obj.get_active_course_details_by_branch_and_semester(branc, semeste);
        %>
        <div class="container">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
                <h1>Add Timetable Details</h1>
                <hr>
                <form action="" method="post">
                    <label>Day</label>
                    <select name="day" id="day" class="form-select" required>
                        <option value="" disabled selected>-- Choose Day --</option>
                        <option value="monday">Monday</option>
                        <option value="tuesday">Tuesday</option>
                        <option value="wednesday">Wednesday</option>
                        <option value="thursday">Thursday</option>
                        <option value="friday">Friday</option>
                        <option value="saturday">Saturday</option>
                        <option value="sunday">Sunday</option>
                    </select>
                    <div class="my-2">
                        <label class="">Time Start</label>
                        <input type="time" name="timestart" class="form-control" required>
                    </div>
                    <div class="my-2">
                        <label class="">Time End</label>
                        <input type="time" name="timeend" class="form-control" required>
                    </div>
                    <div class="my-2">
                        <label class="my-3">Branch</label>
                        <input type="text" value="<%= branc%>" placeholder="Branch" name="branch" class="form-control" readonly>
                    </div>
                    <label>Subject</label>
                    <select name="subject" id="subject" class="form-select" required="">
                        <option value="" disabled selected>-- Choose Subject --</option>
                        <% for (Map<String, Object> subject : course_details) {%>
                        <option value="<%= subject.get("sid")%>">
                            <%= subject.get("subject_name") + "-" + subject.get("subject_type")%>
                        </option>
                        <% }%>
                    </select>

                    <div class="my-2">
                        <label class="my-3">Semester</label>
                        <input type="text" class="form-control" name="semester" value="<%= semeste%>" readonly>
                    </div>
                    <label class="my-3">Venue</label>
                    <input type="text" placeholder="Venue" name="venue" class="form-control" required="">
                    <div class="text-left my-3">
                        <input type="submit" name="add_tt_btn" value="Add Timetable" class="btn btn-dark">
                        <a href="add_time_table.jsp" class="btn btn-dark">Back</a>
                    </div>
                </form>
                <% if (request.getParameter("add_tt_btn") != null) {
                        String day = request.getParameter("day");
                        String timestart = request.getParameter("timestart");
                        String timeend = request.getParameter("timeend");
                        String venue = request.getParameter("venue");
                        String branch = request.getParameter("branch");
                        int semester = Integer.parseInt(request.getParameter("semester"));
                        int subject = Integer.parseInt(request.getParameter("subject"));

                        // Check for timetable conflicts
                        boolean hasConflict = obj.hasTimetableConflict(day, timestart, timeend, branch, semester);
                        if (hasConflict) {%>
                <div class="alert alert-danger" role="alert">
                    <script>alert("Timetable Conflict: A lecture is already scheduled at this time. Please choose a different time slot.");</script>
                </div>
                <%} else {
                    boolean add_class_time_table = obj.add_class_time_table(day, timestart, timeend, subject, branch, semester, venue);
                    if (add_class_time_table) {%>
            <div class="alert alert-success" role="alert">
                <script>alert("Timetable added successfully");
                                            window.location.href = "time_tables.jsp";
                
                </script>
            </div>
            <% }else {%>
            <div class="alert alert-danger" role="alert">
                <%
                    out.println("Oops! Something went wrong. Please try again later.");
                %>
            </div>
            <%
                    }
                }
                } %>
                
            <%}
                } else {
                    out.println("<script>location.href='error.jsp'</script>");
                }
            %>
        </div>
    </div>
</body>
</html>
<%@ include file="footer.jsp" %>
