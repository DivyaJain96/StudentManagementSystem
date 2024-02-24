<%-- 
    Document   : forgotpassword_resendotp
    Created on : 19 Oct, 2023, 6:23:01 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="mca.Mail"%>
<%@page import="java.util.Random"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body><%    // Import the required Java classes
            // Include the header
            // Create an instance of MainClass
            MainClass obj = new MainClass();

            // Delete the user verification record
            boolean deleteStudentVeri = obj.delete_user_verification((String) session.getAttribute("stud_email"));

            // Generate a verification code
            String verificationCode = String.format("%06d", new Random().nextInt(999999) + 1);

            // Add the verification details
            int result = obj.add_details_user_verification((String) session.getAttribute("stud_email"), verificationCode);

            if (result <= 0) {
                out.println("<script>alert('Something went wrong please try after some time')</script>");
                out.println("<script>window.location.href = 'http://localhost:8080/mcaproject/forgot_password.jsp'</script>");
            } else {
                // Send verification code via email
                Mail message = new Mail();
                String recipient = session.getAttribute("stud_email").toString();
                String subject = "Verification code from CHARUSAT"; // Set your subject here

                String content = "<p style='font-size: 16px'>"
                        + "Greetings of the day from CHARUSAT. Enter <b>" + verificationCode + "</b> "
                        + "code in our portal to activate your account.</p>"
//                        + "<a href='http://localhost:8080/mcaproject/register_verification.jsp' "
//                        + "style='padding: 10px; text-decoration: none; background-color: #007bff; "
//                        + "color: #fff; line-height: 22.5px; font-size: 16px; border-radius: 4px'>"
//                        + "Click here to open the portal</a>"
                        + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
                        + "<p style='font-size: 16px'><b style='color: red'>Note:</b> "
                        + "This is a system generated mail. Please do not reply to this mail.</p>";
                boolean emailSent = message.sendEmail(recipient, subject, content);
                if (emailSent) {
                    out.println("<script>alert('Verification code has been successfully sent to your registered email');</script>");
                    out.println("<script>window.location.href = 'http://localhost:8080/mcaproject/forgot_password.jsp'</script>");
                } else {
                    out.println("<script>alert('Error in sending email');</script>");
                }
            }
        %>

    </body>
</html>
<jsp:include page="footer.jsp" />
