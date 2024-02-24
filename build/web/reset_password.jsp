<%-- 
    Document   : reset_password
    Created on : 19 Oct, 2023, 11:39:48 AM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mca.MainClass"%>
<%@page import="java.util.Map"%>
<jsp:include page="header.jsp" />

<%
// Retrieve "userEmail" from the session
    String userEmail = (String) session.getAttribute("userEmail");
    String studentId = (String) session.getAttribute("studentId");
//    out.println(studentId);
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
    </head>
    <body>

        <div class="container my-5">
            <form action="" method="post">
                <div class="card col-md-6 mx-auto alert-warning shadow">
                    <div class="card-body">
                        <h1>Reset Password</h1>
                        <!--<form action="" method="post">-->
                        <input type="hidden" class="form-control my-2" name="email" placeholder="email " required="" value="<%=session.getAttribute("userEmail")%>">
                        <input type="password" name="newPassword" required="" placeholder="Enter New Password">
                        <input type="password" name="confirmPassword" required="" placeholder="Confirm New Password">
                        <input type="submit" value="Reset Password" name="resetPasswordBtn">
                    </div>
                </div>
            </form>
        </div>

        <%
            MainClass obj = new MainClass();
            if (request.getParameter("resetPasswordBtn") != null) {
                // Handle password reset logic here
                String newPassword = request.getParameter("newPassword");
                String confirmPassword = request.getParameter("confirmPassword");
                if (newPassword.equals(confirmPassword)) {
                    // Update the user's password
                    int updatepassword = obj.updatePassword(userEmail, newPassword); // Implement your code to update the password
                    if (updatepassword > 0) {
                        int updatePasswor = obj.updatePasswor(studentId, newPassword);
                        if (updatePasswor > 0) {
                            out.println("<script>");
                            out.println("alert('Password has been reset successfully.');"); // Display a JavaScript alert
                            out.println("window.location.href = 'success_password.jsp?password_status=success';"); // Redirect to a success page
                            out.println("</script>");
                        }
                    } else {
                        out.println("<script>");
                        out.println("alert('Password update failed: Email not found.');"); // Display a JavaScript alert
                        out.println("window.location.href = 'error_page.jsp';"); // Redirect to an error page
                        out.println("</script>");
                    }
                    //                    out.println("Password has been reset successfully.");
//                    }

                } else {
                    out.println("<script>");
                    out.println("alert('Passwords do not match.');");
                    out.println("</script>");
                }
            }
        %>
    </body>
</html>

<jsp:include page="footer.jsp" />