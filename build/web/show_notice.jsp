<%@page import="java.util.HashMap"%>
<%@ include file="header.jsp" %>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="mca.MainClass"%>
<%@page session="true"%>

<%    if (session.getAttribute("current_userrole") != null) {
%>
<div class="container my-5">
    <div class="text-left ml-2">
        <h2>Show Notice</h2>
        <hr class="col-3">
    </div>
    <%        MainClass obj = new MainClass();
        if (session.getAttribute("current_userrole").equals("admin") || session.getAttribute("current_userrole").equals("faculty")) {
            %>
                <a href="add_notice.jsp" class="btn btn-dark">Add Notice</a>

            <%
            List<Map<String, Object>> notices = obj.get_notices();
            for (Map<String, Object> notice : notices) {
    %>
    <div class="row shadow-sm m-2 rounded text-justify alert-warning p-3 text-dark">
        <div class="col md-3">
            <!--<a href="faculty_dashboard.jsp" class="btn btn-dark">Back</a>-->
            <p class="h5">Branch : <span class="h6 text-capitalize"><%= notice.get("student_branch")%></span></p>
            <p class="h5">Title : <span class="h6 text-capitalize"><%= notice.get("notice_title")%></span></p>
            <p class="h5">Date : <span class="h6"><%= notice.get("notice_date")%></span></p>
            <a class="btn mt-2 btn-dark btn-sm" data-bs-toggle="collapse" href="#collapse<%= notice.get("id")%>" role="button" aria-controls="collapse<%= notice.get("id")%>">
                <span>Read More</span>
            </a>
        </div>
        <div class="col-md-9">
            <div class="collapse row" id="collapse<%= notice.get("id")%>">
            <!--<div class="collapse row" id="collapse" <%= notice.get("id")%> >-->
                <%
                    if (notice.get("notice_img") != null && !notice.get("notice_img").toString().isEmpty()) {
                %>
                <a class="col-md-3 mt-3" href="./<%= notice.get("notice_img")%>">
                    <img src="./<%= notice.get("notice_img")%>"
                         alt="Image" class="img-fluid shadow rounded" style="max-width:7rem;height:6.4rem;" 
                         >
                </a>
                <%
                    }
                    if (notice.get("notice_text") != null && !notice.get("notice_text").toString().isEmpty()) {
                %>
                <div class="col-md-9 my-3">
                    <%= notice.get("notice_text")%>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <%
        }
    } else if (session.getAttribute("current_userrole").equals("student")) {
//        out.println("Welcome " + session.getAttribute("current_userid"));
        HashMap<String, Object> current_student = obj.get_student_by_userid((String) session.getAttribute("current_userid"));
//        out.println("Welcome " + session.getAttribute("current_userid"));
//        out.println(current_student);
        if (current_student != null) {
            List<HashMap<String, Object>> notices = obj.get_notice(current_student.get("branch").toString());
//            out.println(current_student.get("student_branch"));
//            out.println(notices);
//            out.println("Welcome " + session.getAttribute("current_userid"));
            if (notices != null) {
                for (HashMap<String, Object> notice : notices) {
    %>
    <div class="row row shadow-sm m-2 rounded text-justify alert-warning p-3 text-dark">
        <div class="col-md-3">
            <p class="h5">Title : <span class="h6 text-capitalize"><%= notice.get("notice_title")%></span></p>
            <p class="h5">Date : <span class="h6"><%= notice.get("notice_date")%></span></p>
            <a class="btn my-3 btn-dark btn-sm" data-bs-toggle="collapse" href="#collapse<%= notice.get("id")%>" role="button"
               aria-controls="collapse<%= notice.get("id")%>">
                <span>Read More</span>
            </a>
        </div>
        <div class="col-md-9">
            <div class="collapse row" id="collapse<%= notice.get("id")%>">
            <!--<div class="collapse row" id="collapse" <%= notice.get("id")%>>-->
                <%
                    if (notice.get("notice_img") != null && !notice.get("notice_img").toString().isEmpty()) {
                %>
                <a class="col-md-3 mt-3" href="./<%= notice.get("notice_img")%>">
                    <img src="./<%= notice.get("notice_img")%>"
                         alt="Image" class="img-fluid shadow rounded" style="max-width:7rem;height:6.4rem;"
                         >
                </a>
                <%
                    }
                    if (notice.get("notice_text") != null && !notice.get("notice_text").toString().isEmpty()) {
                %>
                <div class="col-md-9 my-3">
                    <%= notice.get("notice_text")%>
                </div>
                <%
                    }
                %>
            </div>
        </div>
    </div>
    <%
                    }
                }
            }
        }
//        }
    %>
</div>       
<%
} else {
%>
<script>
    window.location.href = 'http://localhost:8080/mcaproject/error.jsp';
</script>
<%
    }
%>
<%@ include file="footer.jsp" %>
