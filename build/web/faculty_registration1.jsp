<%-- 
    Document   : faculty_registration1
    Created on : 30 Sep, 2023, 9:19:02 AM
    Author     : Divya Kumar Jain
--%>
<%@page import="mca.Mail"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="mca.MainClass" %>
<%@include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container my-5">
            <div class="content alert-warning card text-dark p-5 shadow my-3 rounded">
                <h1>Faculty Register</h1>
                <hr>
                <form action="#" method="post">
                    <div class="row">
                        <div class="col-md-4">
                            <label>Firstname</label>
                            <input type="text" class="form-control"
                                   name="firstname" placeholder="Ex. John" required></div>
                        <div class="col-md-4">
                            <label>Middlename</label>
                            <input type="text" class="form-control"
                                   name="middlename" placeholder="Ex. Alexander" required></div>
                        <div class="col-md-4">
                            <label >Lastname</label>
                            <input type="text" class="form-control"
                                   name="lastname" placeholder="Ex. Doe" required></div>
                    </div>
                    <div class="row my-2 g-2">
                        <div class="col-md-4">
                            <label>Gender</label><br>
                            <input class="form-check-input" type="radio" name="gender" id="male" value="male" checked>
                            <span>Male&nbsp;
                            </span>
                            <input class="form-check-input" type="radio" name="gender" id="female" value="female">
                            <span>Female&nbsp;
                            </span>
                            <input class="form-check-input" type="radio" name="gender" id="other" value="other">
                            <span>
                                Other
                            </span>
                        </div>
                        <div class="col-md-6">
                            <label>Date of Birth</label>
                            <input type="date" class="form-control" name="dob" required>
                        </div>
                    </div>


                    <div class="row my-2">
                        <div class="col-md-12">
                            <label>Qualification</label><br>
                            <input type="text" class="form-control" name="qualification" placeholder="Ex. MCA, P.hd, M.Tech"
                                   required>
                        </div>
                    </div>

                    <div class="row my-2">
                        <div class="col-md-6">
                            <label>Email</label>
                            <input type="email" class="form-control" name="email" placeholder="Ex. example@gmail.com" required>
                        </div>
                        <div class="col-md-6">
                            <label>Contact</label>
                            <input type="text" class="form-control" name="contact" placeholder="Ex. 1234567890" maxlength="10" required>
                        </div>
                    </div>

                    <div class="row my-2">
                        <div class="col-md-12">
                            <label>Address</label>
                            <textarea class="form-control" name="address" rows="3" cols="12"
                                      placeholder="B-123, Near stanza, Village" required></textarea>
                        </div>
                    </div>

                    <div class="row my-2">
                        <div class="col-md-6">
                            <label>City</label>
                            <input type="text" class="form-control" name="city" placeholder="Ex. Nadiad" required>
                        </div>
                        <div class="col-md-6">
                            <label>State</label>
                            <input type="text" class="form-control" name="state" placeholder="Ex. Gujarat" required>
                        </div>
                    </div>

                    <!-- <div class="row my-2">
                    <div class="col-md-6">
                        <label for="">Password</label>
                        <input type="password" class="form-control" name="password" value="123">
                    </div>
                    <div class="col-md-6">
                        <label for="">Confirm Password</label>
                        <input type="password" class="form-control" name="cpassword" value="123">
                    </div>
                </div> -->

                    <div class="row my-3">
                        <div class="col-md-12">
                            <input type="submit" class="btn btn-dark" name="registrationbtn" value="Register">
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <%            if (request.getParameter("registrationbtn") != null) {
                String email = request.getParameter("email");

                // Include the MainClass file
                // Create an instance of MainClass
                MainClass obj = new MainClass();

                // Check if the email already exists
                int usersByEmailCount = obj.get_faculty_by_email_count(email);
                if (usersByEmailCount > 0) {
                    out.println("<script>alert('This email already exists. Please use another email.');</script>");
                } else {
                    // Get data from the form
                    String firstname = request.getParameter("firstname");
                    String middlename = request.getParameter("middlename");
                    String lastname = request.getParameter("lastname");
                    String gender = request.getParameter("gender");
                    String qualification = request.getParameter("qualification");
                    String dob = request.getParameter("dob");
                    String contact = request.getParameter("contact");
                    String address = request.getParameter("address");
                    String city = request.getParameter("city");
                    String state = request.getParameter("state");

                    int countFaculty = obj.count_faculty();

                    // Generate faculty Id
                    String userid = "";
                    if (countFaculty >= 0 && countFaculty <= 9) {
                        int count = countFaculty + 1;
                        userid = "FID00" + count;
                    } else if (countFaculty >= 10 && countFaculty <= 99) {
                        int count = countFaculty + 1;
                        userid = "FID0" + count;
                    } else if (countFaculty >= 100 && countFaculty <= 999) {
                        int count = countFaculty + 1;
                        userid = Integer.toString(count);
                    }

                    String[] orderdate = dob.split("-");
                    String month = orderdate[1];
                    String day = orderdate[2];
                    String year = orderdate[0];

                    String facultyPassword = day + month + year.substring(2);

                    boolean insertFaculty = obj.insertFaculty(userid, firstname, middlename, lastname, qualification, gender, dob, email, contact, address, city, state, facultyPassword);
                    if (insertFaculty) {
                        boolean insertUserInfo = obj.insertUserData(userid, facultyPassword, "faculty");
                        if (insertUserInfo) {
//                            out.println("<div><a href='http://localhost:8080/mcaproject/dashboard.jsp></a></div>");

        %>
        <div class="alert alert-success" role="alert">

            <%                // Send registration confirmation email
                Mail m = new Mail();
                String fullname = firstname + " " + middlename + " " + lastname;
                String recipient = email;
                String subject = "Your Registration Successfully"; // Set your subject here
                String content = "<h3>Dear <b>" + fullname + "</b></h3>"
                        + "<h2>This is Login Credentials For " + "</h2></br>"
                        + "<p style='font-size: 16px'>"
                        + "Your Login Id is : <b>" + userid + "</b></br>"
                        + "password is :<b>" + facultyPassword + "</b>"
                        + "</p>"
                        + "<a href='http://localhost:8080/mcaproject/'"
                        + "style='padding: 10px; text-decoration: none; background-color: #007bff; color: #fff; line-height: 22.5px; font-size: 16px; border-radius: 4px'>"
                        + " Click here to open the portal"
                        + "</a>"
                        + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
                        + "<p style='font-size: 16px'><b style='color: red'>Note:</b>This is a system generated mail. Please do not reply to this mail.</p>";

                boolean emailSent = m.sendEmail(recipient, subject, content);
                if (emailSent) {
//                    out.println("<div class='alert alert-success' role='alert'>Faculty Registration Successfully</div>");
            %>
            <script>
                alert("Faculty Registration Successfully");
                window.location.href = "http://localhost:8080/mcaproject/dashboard.jsp";
            </script>
            <%
            } else {
            %>
            <div class="alert alert-danger" role="alert">
                Error in sending email
                <script>
                    alert("Error in sending email");
                    window.location.href = "http://localhost:8080/mcaproject/faculty_registration1.jsp";
                </script>
            </div>
            <%
                }
            %>
        </div>
        <%
            }
        } else {
        %>
        <div class="alert alert-danger" role="alert">
            <%= "Something Went wrong"%>
        </div>
        <%
                    }
                }
            }
        %>
    </body>
</html>
<%@include file="footer.jsp" %>