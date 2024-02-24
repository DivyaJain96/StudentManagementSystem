<%-- 
    Document   : download_student_result
    Created on : 7 Jun, 2023, 9:12:42 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="com.itextpdf.text.DocumentException"%>
<%@page import="java.io.IOException"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="com.itextpdf.text.Chunk"%>
<%@page import="com.itextpdf.text.Paragraph"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="com.itextpdf.text.Document"%>
<%@page import="com.itextpdf.text.Image"%>
<%@page import="com.itextpdf.text.pdf.PdfPageEventHelper"%>
<%--<%@page contentType="text/html" pageEncoding="UTF-8"%>--%>
<%@page contentType="application/pdf" pageEncoding="UTF-8"%>
<%@page session="true" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>

        <%            session = request.getSession();

            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userrole").equals("student")) {
                    if (request.getParameter("download") != null) {
                        String student_id = request.getParameter("student_id");
                        String student_name = "Student Name: " + request.getParameter("student_name");
                        String results_sem = request.getParameter("results_sem");
                        String student_branch = request.getParameter("student_branch");
                        String data = request.getParameter("downloadres");
                        String pdfFileName = student_id + "_sem" + results_sem + "_results.pdf";
                        // Set the content type to PDF
                        response.setContentType("application/pdf");
                        response.setHeader("Content-Disposition", "attachment; filename=\"" + pdfFileName + "\"");
                        // Create a new Document
                        Document document = new Document();
                        // Create a PDF writer
//                            PdfWriter.getInstance(document, new FileOutputStream(pdfFileName));
                        PdfWriter writer = PdfWriter.getInstance(document, response.getOutputStream());
                        // Open the document
                        document.open();
                        document.add(new Paragraph("CHAROTAR UNIVERSITY OF SCIENCE AND TECHNOLOGY, CHANGA - 388421"));
                        document.add(new Paragraph("SEMESTER GRADE REPORT"));
                        document.add(new Paragraph("FACULTY OF COMPUTER SCIENCE AND APPLICATIONS"));
                        document.add(new Paragraph("Student Name : " + student_name));
                        document.add(new Paragraph("Student Id : " + student_id));
                        document.add(new Paragraph("Semester : " + results_sem));
                        document.add(new Paragraph("Branch : " + student_branch));
                        document.add(new Paragraph("\n")); // Add a blank line

                        // Parse and add HTML content to the PDF (you may need to adjust this part)
                        document.add(new Paragraph("Table Data:")); // Add a label
                        document.add(new Paragraph(data));
                        document.close();
                        int i;
                        String content = "<table>"
                                + "<tr>"
                                + "<th>Id</th>"
                                + "<th>Name</th>"
                                + "</tr>"
                                + "<tr>"
                                + "<td>22MCA001</td>"
                                + "<td>Divya Jain</td>"
                                + "</tr>"
                                + "</table>";
//
//                        pdf.writeHTML(data);
//                        pdf.output(dName, "D");
//
                    } else {
                        response.sendRedirect("index.jsp");
                    }
                } else {
                    response.sendRedirect("index.jsp");
                }
            } else {
                response.sendRedirect("index.jsp");
            }
        %>

    </body>
</html>
