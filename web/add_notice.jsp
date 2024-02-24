<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="mca.MainClass"%>
<%@page import="java.io.File"%>
<%@ include file="header.jsp" %>

<%    if (session.getAttribute("current_userid") != null) {
//        out.println(session.getAttribute("current_userid"));
        if (session.getAttribute("current_userid").equals("admin") ||session.getAttribute("current_userrole").equals("faculty") || session.getAttribute("current_userid").equals("Admin"))  {
%>
<div class="container mt-5">
    <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
        <div class="text-left">
            <h2>Add Notice</h2>
            <hr class="col-3">
        </div>
        <form action="AddImage" method="post" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-12">
                    <label>Notice Title</label>
                    <input type="text" name="notice_title"  class="form-control" placeholder="Write Notice Title"
                           required>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col-md-6">
                    <label>Branch</label>
                    <select name="student_branch"  class="my-1 form-select" required>
                        <option value="" selected disabled>--Select--</option>
                        <option value="mca">MCA</option>
                        <option value="bca">BCA</option>
                        <option value="mscit">Msc.IT</option>
                        <option value="bscit">Bsc.IT</option>
                    </select>
                </div>
                <div class="col-md-6">
                    <label>Photo</label>
                    <input type="file" name="notice_img" id="photoInput" class="my-1 form-control" required>
                     <small id="photoError" style="color: red;"></small>
                </div>
            </div>
            <div class="row mt-2">
                <div class="col">
                    <textarea name="notice_text"  cols="30" rows="3" class="form-control"
                              placeholder="Write Notice Description Here " required></textarea>
                </div>
            </div>
            <div class="row my-3">
                <div class="col">
                    <input type="submit" name="add_note_btn" value="Add Notice" class="btn btn-dark">
                    <a href="dashboard.jsp" class="btn btn-dark">Back</a>
                </div>
            </div>
        </form>
    </div>
</div>
<%
        } else {
            out.println("<p class='h5 alert-danger p-5 text-center container my-5'><i class='fa fa-exclamation-triangle' aria-hidden='true'></i>    Something Went Wrong  !!</p>");
        }
    } else {
        response.sendRedirect("error.jsp");
    }
%>
<%@ include file="footer.jsp" %>
<script>
    document.getElementById('photoInput').addEventListener('change', function () {
        var photoInput = this;
        var photoError = document.getElementById('photoError');

        if (photoInput.files.length > 0) {
            var fileSize = photoInput.files[0].size; // in bytes
            var maxSize = 1 * 1024 * 1024; // 3 MB


            if (fileSize > maxSize) {
                photoError.textContent = 'File size must be less than 1 MB.';
                photoInput.value = ''; // Clear the input
            } else {
                photoError.textContent = '';
            }
        }
    });
</script>