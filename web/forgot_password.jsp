

<%@page import="mca.MainClass"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />



<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        // Retrieve "userEmail" from the session
            String userEmail = (String) session.getAttribute("userEmail");
            String studentId = (String) session.getAttribute("studentId");
//            out.println(studentId);
        %>

        <div class="container my-5">
            <form action="" method="post">
                <div class="card col-md-6 mx-auto alert-warning shadow">
                    <div class="card-body">
                        <!--<form action="" method="post">-->
                        <label>Enter OTP</label>
                        <input type="hidden" class="form-control my-2" name="email" placeholder="email " required="" value="<%=session.getAttribute("userEmail")%>">
                        <input type="number" class="form-control my-2" name="verification_code" placeholder="Enter OTP Here" required="">
                        <div class="text-center my-3">
                            <input type="submit" value="Verify" name="verifybtn" class="btn btn-dark">
                        </div>
                        <div class="text-right">
                            <a href="forgotpassword_resendotp.jsp" class="btn btn-light">Resend Otp</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>

        <%
            if (request.getParameter("verifybtn") != null) {
                // Import the required Java classes
                // Create an instance of MainClass
                MainClass obj = new MainClass();
        //        String studEmail = (String) session.getAttribute("email");
        //        String email = request.getParameter("email");
        //                out.println(studEmail);
                // Get the verification code from the form
                String vericode = request.getParameter("verification_code");
        //                out.println(vericode);
                // Call the check_user_verify_code method
                Map<String, Object> checkVerification = obj.checkUserVerifyCode((String) session.getAttribute("userEmail"), vericode);
                out.println(checkVerification);
        //                out.print(checkVerification.get("veri_code").toString());
                if (checkVerification != null) {
                    // Assuming that the verification code is stored in the database column "veri_code"
                    String databaseVericode = (String) checkVerification.get("veri_code");
                    String databaseemail = (String) checkVerification.get("user_email");
        //                    out.print(databaseVericode);
        //                    out.print(databaseemail);
                    if (databaseVericode != null && databaseVericode.equals(vericode)) {
                        out.println("<script>");
                        out.println("alert('Verification code  has been matched successfully.');"); // Display a JavaScript alert
                        out.println("window.location.href = 'reset_password.jsp';"); // Redirect to a success page
                        out.println("</script>");
                    } else {
                        out.println("<script>");
                        out.println("alert('Verification code  has been not matched successfully.');"); // Display a JavaScript alert
                        out.println("window.location.href = 'forgot_password.jsp';"); // Redirect to a success page
                        out.println("</script>");
                    }
                }
            }
        %>
    </body>
</html>
<jsp:include page="footer.jsp" />
