<%-- 
    Document   : forgot
    Created on : 13 Oct, 2023, 6:11:11 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.Map"%>
<%@page import="mca.Mail"%>
<%@page import="java.util.Random"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="mca.MainClass"%>
<jsp:include page="header.jsp" />

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container my-5">
            <form action="" method="post">
                <div class="card col-md-6 mx-auto alert-warning shadow">
                    <div class="card-body">
                        <h3>Forgot Password</h3>
                        <!--<form action="" method="post">-->
                        <label>Email ID : </label>
                        <input type="email" name="email" required="" placeholder="Enter a Email Id ">
                        <input type="submit" value="ForgotPassword" name="forgotpass">
                    </div>
                </div>
            </form>
        </div>

        <%
            MainClass obj = new MainClass();
            if (request.getParameter("forgotpass") != null) {
                String email = request.getParameter("email");
//                boolean p=true;
                boolean emailExists = obj.checkEmailExists(email);
                if (emailExists) {
                    session.setAttribute("userEmail", email);
                    String studentId = obj.getStudentIdByEmail(email);
                    // Now you have the student ID in the 'studentId' variable, and you can use it as needed.
                    session.setAttribute("studentId", studentId);
                    // Delete any previous verification codes for the email
                    boolean deleteStudentVeri = obj.delete_user_verification(request.getParameter("email"));

                    // Generate a verification code
                    String verificationCode = String.format("%06d", new Random().nextInt(999999) + 1);

                    // Add the verification details
                    int result = obj.add_details_user_verification(request.getParameter("email"), verificationCode);
//                    int vericode = new Random().nextInt(1000000); // Generates a random number between 0 and 999999
//                    String formattedVericode = String.format("%06d", vericode);
//                    int res = obj.add_details_user_verification(email, formattedVericode);
                    if (result <= 0) {
                        out.println("<script>alert('Something went wrong please try after some time')</script>");
                        out.println("<script>window.location.href = 'http://localhost:8080/mcaproject/forgot.jsp'</script>");
                    } else {
                        // Send verification code via email
                        request.setAttribute("userEmai", email);
                        String userEmail = (String) request.getAttribute("userEmai");
                        out.print(userEmail);
                        if (userEmail != null) {
                            out.println("userEmail is set: " + userEmail);
                        } else {
                            out.println("userEmail is not set.");
                        }
                        Mail message = new Mail();
//                        String recipient = request.getParameter("email");
                        String recipient = email;
                        String subject = "Verification code from CHARUSAT"; // Set your subject here

                        String content = "<p style='font-size: 16px'>"
                                + "Greetings of the day from CHARUSAT. Enter <b>" + verificationCode + "</b> "
                                + "code in our portal to activate your account.</p>"
                                + "<a href='http://localhost:8080/mcaproject/register_verification.jsp' "
                                + "style='padding: 10px; text-decoration: none; background-color: #007bff; "
                                + "color: #fff; line-height: 22.5px; font-size: 16px; border-radius: 4px'>"
                                + "Click here to open the portal</a>"
                                + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
                                + "<p style='font-size: 16px'><b style='color: red'>Note:</b> "
                                + "This is a system generated mail. Please do not reply to this mail.</p>";
                        boolean emailSent = message.sendEmail(recipient, subject, content);
                        if (emailSent) {
                            // Pass the user's email to the next page
//                            request.setAttribute("userEmail", email);
//                            request.setAttribute("userEmail", recipient);
//                            response.sendRedirect("forgot_password.jsp"); // Use server-side redirection

                            out.println("<script>alert('OTP send to the registration email id');"
                                    + "window.location.href = 'http://localhost:8080/mcaproject/forgot_password.jsp'</script>");

                        } else {
                            out.println("<script>alert('Error in sending email');</script>");
                        }
                    }
//                    out.println("this page is not completed currently !!!");
                } else {
                    out.println("<script>alert('Email Id is not match to previous email ID. Please enter correct email ID.');"
                            + "window.location.href = 'http://localhost:8080/mcaproject/forgot.jsp'</script>");
                }
            }
//                response.sendRedirect("error.jsp");
//            }
%>

    </body>
</html>
<jsp:include page="footer.jsp" />