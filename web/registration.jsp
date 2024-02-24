<%-- 
Document   : registration
Created on : 5 Jun, 2023, 8:13:05 PM
Author     : Divya Kumar Jain
--%>
<%@page import="mca.Mail"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@page import="java.util.Random"%>
<%@page import="mca.MainClass"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<jsp:include page="header.jsp" />
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>REGISTRATION</title>
    </head>
    <body>
        <div class="container mt-5">
            <div class="content card alert-warning text-dark p-5 shadow my-3 rounded">
                <h1>Student Register Here</h1>
                <hr>
                <form action="" method="post">
                    <div class="row">
                        <div class="col-md-4">
                            <label for="firstname">Firstname</label>
                            <input type="text" class="form-control" id="firstname" name="first_name" placeholder="Ex. John" required>
                        </div>
                        <div class="col-md-4">
                            <label for="middlename">Middlename</label>
                            <input type="text" class="form-control" name="middle_name" placeholder="Ex. Alexander" required>
                        </div>
                        <div class="col-md-4">
                            <label for="lastname">Lastname</label>
                            <input type="text" class="form-control" name="last_name" placeholder="Ex. Doe" required>
                        </div>
                    </div>
                    <div class="row my-2 g-2">
                        <div class="col-md-4">
                            <label for="gender">Gender</label><br>
                            <input class="form-check-input" type="radio" name="gender" id="male" value="male">
                            <label class="form-check-label" for="male">Male</label>&nbsp;
                            <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                            <label class="form-check-label" for="female">Female</label>&nbsp;
                            <input class="form-check-input" type="radio" name="gender" id="other" value="other">
                            <label class="form-check-label" for="other">Other</label>
                        </div>
                        <div class="col-md-6">
                            <label for="dob">Date of Birth</label>
                            <input type="date" class="form-control" name="dob" required>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-md-12">
                            <label for="branch">Select Course</label><br>
                            <div class="dropdown">
                                <select name="branch" class="form-control col-md-4" required>
                                    <option value="" selected disabled>---SELECT---</option>
                                    <option value="MCA">MCA</option>
                                    <option value="MSCIT">MSCIT</option>
                                    <option value="BCA">BCA</option>
                                    <option value="BSCIT">BSCIT</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-md-6">
                            <label for="email">Email</label>
                            <input type="email" class="form-control" name="email" id="emailInput" placeholder="Ex. example@gmail.com" 
                                   required oninput="checkEmailFormat()">
                            <span id="emailError" style="color: red;"></span>
                        </div>
                        <div class="col-md-6">
                            <label for="contact">Contact</label>
                            <input type="number" maxlength=10 class="form-control" name="contact_no" placeholder="Ex. 1234567890" 
                                   required oninput="validateNumber(this)" pattern="[0-9]{10}" title="Enter a 10-digit valid number only">
                            <div id="Number" style="color: red;"></div>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-md-12">
                            <label for="address">Address</label>
                            <textarea class="form-control" name="address" rows="3" cols="12" placeholder="Ex. B-123, Near stanza, Village" required></textarea>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-md-6">
                            <label for="city">City</label>
                            <input type="text" class="form-control" name="city" placeholder="Ex. Anand" required>
                        </div>
                        <div class="col-md-6">
                            <label for="state">State</label>
                            <input type="text" class="form-control" name="state" placeholder="Ex. Gujarat" required>
                        </div>
                    </div>
                    <div class="row my-2">
                        <div class="col-md-6">
                            <label for="password">Password</label>
                            <input type="password" class="form-control" name="password" placeholder="Ex. Xyz@657" required>
                        </div>
                        <div class="col-md-6">
                            <label for="cpassword">Confirm Password</label>
                            <input type="password" class="form-control" name="cpassword" placeholder="Ex. Xyz@657" required>
                        </div>
                    </div>
                    <div class="row my-3">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-dark" name="registrationbtn" id="registerButton" value="Register">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%            if (request.getParameter("registrationbtn") != null) {
                MainClass stud = new MainClass();

                String firstname = request.getParameter("first_name");
                String middlename = request.getParameter("middle_name");
                String lastname = request.getParameter("last_name");
                String gender = request.getParameter("gender");
                String dob = request.getParameter("dob");
                String branch = request.getParameter("branch");
//                String emai = request.getParameter("email");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact_no");
//                String contactno = request.getParameter("contact_no");
                String city = request.getParameter("city");
                String state = request.getParameter("state");
                String address = request.getParameter("address");
                String pass = request.getParameter("password");
                Calendar calendar = Calendar.getInstance();
                int years = calendar.get(Calendar.YEAR);
                String year = String.valueOf(years);
                String curr_year = String.valueOf(year).substring(2, 4);
                int users = stud.get_student_by_branch(branch, year);
                String userid = "";
                if (users >= 0 && users < 9) {
                    int count = users + 1;
                    userid = curr_year + branch + "00" + count;
                } else if (users >= 9 && users < 99) {
                    int count = users + 1;
                    userid = curr_year + branch + "0" + count;
                } else if (users >= 99 && users < 999) {
                    int count = users + 1;
                    userid = curr_year + branch + count;
                }
                Pattern contactPattern = Pattern.compile("^[0-9]{10}$");
                Matcher matcher = contactPattern.matcher(String.valueOf(contact));
                if (matcher.matches()) {
                    // Valid mobile number
//                    String phone = request.getParameter("contact");
//                    int vericode = new Random().nextInt(1000000);
//                    String formattedVericode = String.format("%06d", vericode);

                    if (!request.getParameter("password").equals(request.getParameter("cpassword"))) {
                        out.println("<script>alert('Passwords do not match. Please enter matching passwords.')</script>");
                    } else {
                        // Import necessary Java classes
                        // Instantiate the MainClass

                        // Perform necessary database operations and logic
                        int usersByEmail = stud.get_student_by_email_count(email);
                        if (usersByEmail > 0) {
                            out.println("<script>alert('This email already exists, please use another email')</script>");
                        } else {
//                        int vericode = String.format("%06d", (int) (Math.random() * 999999));
//                            int vericode = new Random().nextInt(1000000); // Generates a random number between 0 and 999999

                            int vericode = new Random().nextInt(900000) + 100000;
                            out.print(vericode);
                            String formattedVericode = String.format("%06d", vericode);

                            int res = stud.add_details_user_verification(email, formattedVericode);
                            if (res < 0) {
                                out.println("<script>alert('Something went wrong, please try again later')</script>");
                            } else {
                                // Perform registration and other operations
//                                session.setAttribute("stud_insert_qry",
//                                        stud.registerStudent(
//                                                userid,
//                                                firstname,
//                                                middlename,
//                                                lastname,
//                                                gender,
//                                                dob,
//                                                branch,
//                                                email,
//                                                contact,
//                                                city,
//                                                state,
//                                                address,
//                                                pass,
//                                                year
//                                        ));
//                                session.setAttribute("stud_insert_qry", reg_qry);
                                session.setAttribute("userid", userid);
                                session.setAttribute("firstname", firstname);
                                session.setAttribute("middlename", middlename);
                                session.setAttribute("lastname", lastname);
                                session.setAttribute("gender", gender);
                                session.setAttribute("dob", dob);
                                session.setAttribute("branch", branch);
                                session.setAttribute("stud_email", email);
                                session.setAttribute("contact", contact);
                                session.setAttribute("city", city);
                                session.setAttribute("state", state);
                                session.setAttribute("address", address);
                                session.setAttribute("pass", pass);
                                session.setAttribute("year", year);
//                                        //                            String firstname = 
//                                        request.getParameter("first_name"),
//                                        //                            String middlename = 
//                                        request.getParameter("middle_name"),
//                                        //                            String lastname = 
//                                        request.getParameter("last_name"),
//                                        //                            String gender = 
//                                        request.getParameter("gender"),
//                                        //                            String dob =
//                                        request.getParameter("dob"),
//                                        //                            String branch = 
//                                        request.getParameter("branch"),
//                                        //                                    String emai = 
//                                        request.getParameter("email"),
//                                        //                            String contactno = 
//                                        request.getParameter("contact_no"),
//                                        //                            
//                                        //                            String city = 
//                                        request.getParameter("city"),
//                                        //                            String state =
//                                        request.getParameter("state"),
//                                        //                            String address = 
//                                        request.getParameter("address"),
//                                        //                            String pass = 
//                                        request.getParameter("password")
//                                );
//
//                            Calendar calendar = Calendar.getInstance();
//                            int years = calendar.get(Calendar.YEAR);
//                            String year = String.valueOf(years);
//                            String curr_year = String.valueOf(year).substring(2, 4);
//                            int users = stud.get_student_by_branch(branch, year);
//                            String userid = "";
//                            if (users >= 0 && users < 9) {
//                                int count = users + 1;
//                                userid = curr_year + branch + "00" + count;
//                            } else if (users >= 9 && users < 99) {
//                                int count = users + 1;
//                                userid = curr_year + branch + "0" + count;
//                            } else if (users >= 99 && users < 999) {
//                                int count = users + 1;
//                                userid = curr_year + branch + count;
//                            }
////                            boolean Registerstudent = stud.register_student(userid, firstname, middlename, lastname, gender, dob, branch, contactno, emai, city, state, address, pass, year);
//                            String reg_qry = stud.register_student(
//                                    userid, firstname, middlename, lastname, gender, dob, branch, contactno, emai, 
//                                    city, state, address, pass, year);
                                // Set session variables
                                // Store registration query result and email in session
//                                session.setAttribute("stud_insert_qry", reg_qry);
//                                session.setAttribute("stud_email", email);

//                                String s = (String) request.getAttribute("stud_insert_qry");
//                                out.print(s);
                                Mail message = new Mail();

                                String recipient = email;
                                String subject = "Your Registration Successfully"; // Set your subject here
//                            String fullname = firstname + " " + middlename + " " + lastname;
                                String fullname = request.getParameter("first_name") + " "
                                        + request.getParameter("middle_name") + " "
                                        + request.getParameter("last_name");
                                String content = "<h3>Dear " + fullname + "</h3>"
                                        + "<p style='font-size: 16px'>Greetings of the day from CHARUSAT. Enter <b>" + vericode + "</b> code in our portal to activate your account.</p>"
                                        + "<a href='http://localhost:8080/mcaproject/register_verification.jsp' style='padding: 10px; text-decoration: none; background-color: #007bff; color: #fff; line-height: 22.5px; font-size: 16px; border-radius: 4px'>Click here to open the portal</a>"
                                        + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
                                        + "<p style='font-size: 16px'><b style='color: red'>Note:</b>This is a system-generated mail. Please do not reply to this mail.</p>";
                                boolean emailSent = message.sendEmail(recipient, subject, content);
                                if (emailSent) {
                                    out.println("<script>alert('Verification code has been successfully sent to your registered email');</script>");
                                    out.println("<script>window.location.href='http://localhost:8080/mcaproject/register_verification.jsp';</script>");
                                } else {
                                    out.println("<script>alert('Email sending error. Please try again.');</script>");
                                }
                            }

        %>

        <%                      }
                    }
                } else {
                    out.println("<script>alert('Invalid Mobile number. Please enter a 10-digit mobile number.')</script>");
                    out.println("<script>window.location.href='http://localhost:8080/mcaproject/registration.jsp';</script>");
                }
//                    }
            }
//            }

        %>
    </body>
</html>
<jsp:include page="footer.jsp" />
<script>

    function validateNumber(input) {
    const value = input.value;
            const errorElement = input.nextElementSibling;
            var registerButton = document.getElementById("registerButton");
            if (!/^\d{10}$/.test(value)) {
    if (value.length < 10) {
    input.value = value.slice(0, 10);
//                    errorElement.textContent = "Enter a 10-digit number, not less than 10 digits. Register Button disabled.";
            errorElement.textContent = "Enter at least 10 digits. Register Button disabled.";
            // Enable the button
            registerButton.disabled = true;
    } else {
    input.value = value.slice(0, 10);
            errorElement.textContent = "Number should be 10 digits only. Register Button disabled.";
            // Enable the button
            registerButton.disabled = true;
    }
    } else {
    errorElement.textContent = "";
            // Enable the button
            registerButton.disabled = false;
    }
    }
</script>
<script>
    function checkEmailFormat() {
    var emailInput = document.getElementById("emailInput");
            var emailError = document.getElementById("emailError");
            var registerButton = document.getElementById("registerButton");
            var emailValue = emailInput.value;
            var emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
            if (emailValue.match(emailRegex)) {
    // Email is in the correct format, clear error message
    emailError.textContent = "";
            // Enable the button
            registerButton.disabled = false;
    } else {
    // Email format is incorrect, show error message
    emailError.textContent = "Email is not in the correct format. Register Button disabled.";
            // Disable the button
            registerButton.disabled = true;
    }
    }
</script>
