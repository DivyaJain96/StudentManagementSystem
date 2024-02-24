<%-- 
    Document   : register_verification
    Created on : 7 Jun, 2023, 9:14:58 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="java.util.Map"%>
<%@page import="mca.Mail"%>
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
                        <%
                            String userid = (String) session.getAttribute("userid");
                            String firstname = (String) session.getAttribute("firstname");
                            String middlename = (String) session.getAttribute("middlename");
                            String lastname = (String) session.getAttribute("lastname");
                            String gender = (String) session.getAttribute("gender");
                            String dob = (String) session.getAttribute("dob");
                            String branch = (String) session.getAttribute("branch");
                            String email = (String) session.getAttribute("stud_email");
                            String contact = (String) session.getAttribute("contact");
                            String city = (String) session.getAttribute("city");
                            String state = (String) session.getAttribute("state");
                            String address = (String) session.getAttribute("address");
                            String pass = (String) session.getAttribute("pass");
                            String year = (String) session.getAttribute("year");
//                              
                        %>
                        <% //                            if (request.getParameter("registration_status") != null) {
//                                String registrationStatus = request.getParameter("registration_status");
//                                if (registrationStatus.equals("success")) {
                        %>
                        <!--<div class="alert alert-success" role="alert">-->
                        <!--Registration Successfully check email for student id!!<br>-->
                        <!--if you want to login <a href="index.jsp">Click here</a>-->
                        <!--</div>-->
                        <%
//                        } else if (registrationStatus.equals("failed")) {
                        %>
                        <!--<div class="alert alert-danger" role="alert">-->
                        <!--Registration Failed !!-->
                        <!--</div>-->
                        <%//                                }
//                            }
                        %>
                        <label>Enter OTP</label>
                        <input type="number" class="form-control my-2" name="verification_code" placeholder="Enter OTP Here" required="">
                        <div class="text-center my-3">
                            <input type="submit" value="Verify" name="verifybtn" class="btn btn-dark">
                        </div>
                        <div class="text-right">
                            <a href="resend_otp.jsp">Resend Otp</a>
                        </div>
                    </div>
                </div>
            </form>
        </div>
        <%            if (request.getParameter("verifybtn") != null) {
                // Import the required Java classes
                // Create an instance of MainClass
                MainClass obj = new MainClass();
                String studEmail = (String) session.getAttribute("stud_email");
//                out.println(studEmail);
                // Get the verification code from the form
                String vericode = request.getParameter("verification_code");
//                out.println(vericode);
                // Call the check_user_verify_code method
                Map<String, Object> checkVerification = obj.checkUserVerifyCode(studEmail, vericode);
//                out.println(checkVerification);
//                out.print(checkVerification.get("veri_code").toString());
                if (checkVerification != null && !checkVerification.isEmpty()) {
                    // Assuming that the verification code is stored in the database column "veri_code"
                    String databaseVericode = (String) checkVerification.get("veri_code");
                    String databaseemail = (String) checkVerification.get("user_email");
                    out.print(databaseVericode);
                    out.print(databaseemail);
                    if (databaseVericode != null && databaseVericode.equals(vericode)) {
//                        if (session.getAttribute("stud_insert_qry") != null && !s.isEmpty()) {
//                            String studInsertQuery = (String) session.getAttribute("stud_insert_qry");
                        // Call the Java function to insert the student using the SQL query
//                            out.println(studInsertQuery);
//                            int result = obj.insertStudent(studInsertQuery);
//                            int resul = obj.register_student();
                        String reg_qry = obj.register_student(userid, firstname, middlename, lastname, gender, dob,
                                branch, contact, email, city, state, address, pass, year);

                        out.print(reg_qry);
                        if (reg_qry.equals("true")) {
                            // Get the student details
                            Map<String, Object> student = obj.get_student_by_email((String) session.getAttribute("stud_email"));
                            String studentId = student.get("student_id").toString();
                            String first_name = student.get("first_name").toString();
                            String middle_name = student.get("middle_name").toString();
                            String last_name = student.get("last_name").toString();
                            String password = student.get("password").toString();
////                            out.print(studentId);
////                            out.print(student);
//                                // Insert student information and user data
                            boolean insertUserInfo = obj.insertUserData(studentId, (String) student.get("password"), "student");
                            boolean insertStudentInfo = obj.insertStudentInfo(studentId);
                            if (insertStudentInfo && insertUserInfo) {
                                // Send email notification
                                Mail message = new Mail();
                                String recipient = session.getAttribute("stud_email").toString();
                                String subject = "Student Id from CHARUSAT"; // Set your subject here
                                String name = first_name + " " + middle_name + " " + last_name;
                                String content = "<h3>Dear " + studentId + " " + name + "</h3>"
                                        + "<p style='font-size: 16px'>Welcome to the CHARUSAT,</p>"
                                        + "<p style='font-size: 16px'>Your Student id is: " + studentId + "</p>"
                                        + "<p style='font-size: 16px'>Your Password is: " + password + "</p>"
                                        + "<a href='http://localhost:8080/mcaproject/login.jsp' style='padding: 10px; text-decoration: none; background-color: #007bff; color: #fff; line-height: 22.5px; font-size: 16px; border-radius: 4px'>Click here to open the portal</a>"
                                        + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
                                        + "<p style='font-size: 16px'><b style='color: red'>Note:</b> This is a system generated mail. Please do not reply to this mail.</p>";
                                boolean emailSent = message.sendEmail(recipient, subject, content);
                                if (emailSent) {
                                    out.println("<script>alert('Registration has been suceesfully!!!');</script>");
                                    out.println("<script>window.location.href='http://localhost:8080/mcaproject/success_password.jsp?registration_status=success';</script>");
//                                    out.println("<script>window.location.href='http://localhost:8080/mcaproject/login.jsp';</script>");
                                } else {
                                    out.println("<script>alert('Error in sending email');</script>");
                                }
                            } else {
//                                 Delete the student information and user
                                    boolean deleteStudentInfo = obj.delete_student_info(studentId);
                                    boolean deleteUser = obj.delete_user(studentId);
                                    boolean deletePreStudentInfo = obj.delete_pre_student_register(studentId);
//                                    // Delete the user verification record
                                boolean deleteStudentVeri = obj.delete_user_verification((String) session.getAttribute("stud_email"));
                                // Redirect to the failed page
                                response.sendRedirect("http://localhost:8080/mcaproject/register_verification.jsp?registration_status=failed");
                            }
                        } else {
                            out.println("<script>alert('Student is not registered please try again later')</script>");
                        }
//                        } else {
//                            out.println("<script>alert('Something went wrong')</script>");
//                            out.println("<script>alert('Student is not registered please try again later')</script>");
//                        }
                    } else {
                        out.println("<script>alert('Invalid verification code please try again')</script>");
                    }
//                } else {
//                    
                }
            }
//            } else {
//                out.println("<script>alert('check verifybtn button is taka null values a null code')</script>");
//            }
        %>

    </body>
</html>
<jsp:include page="footer.jsp" />
