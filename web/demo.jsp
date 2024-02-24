<%-- 
    Document   : demo
    Created on : 7 Jun, 2023, 9:11:51 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            // Set the content type and attachment header for downloading the file
//            response.setContentType("application/vnd.ms-excel");
//            response.setHeader("Content-Disposition", "attachment;filename=abc.xls");

            // Create the output string for the table
//            String output = "";
//            output += "<table>";
//            output += "<tr>";
//            output += "<td>ID</td>";
//            output += "<td>Name</td>";
//            output += "</tr>";
//            output += "<tr>";
//            output += "<td>22MCA019</td>";
//            output += "<td>Divya Jain</td>";
//            output += "</tr>";
//            output += "<tr>";
//            output += "<td>21MCA017</td>";
//            output += "<td>Yash</td>";
//            output += "</tr>";
//            output += "</table>";
//
//            // Send the output to the response
//            out.println(output);

            // Get the current date and format it
            java.util.Date date = new java.util.Date();
            java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("dd-MM-yyyy");
            String formattedDate = dateFormat.format(date);

            // Get the lowercase day name
            String lowercaseDay = formattedDate.toLowerCase();

            // Output the lowercase day name
            out.println(lowercaseDay);
        %>

    </body>
</html>
