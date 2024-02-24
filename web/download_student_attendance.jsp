<%-- 
    Document   : download_student_attendance
    Created on : 5 Jun, 2023, 8:43:10 PM
    Author     : Divya Kumar Jain
--%>

<%@page import="org.apache.poi.xssf.usermodel.XSSFRow"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFCell"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFSheet"%>
<%@page import="org.apache.poi.xssf.usermodel.XSSFWorkbook"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="mca.MainClass" %>
<%@ include file="header.jsp" %>

<!DOCTYPE html>
<html>
    <head>
        <title>JSP Page</title>
    </head>
    <body>

        <%            String attendanceIdParam = request.getParameter("attendance_id").trim(); // Trim leading and trailing spaces
//            out.print(attendanceIdParam);
            try {
                int attendance_id = Integer.parseInt(attendanceIdParam);
//                out.println(attendance_id);
//            int attendance_id = Integer.parseInt(request.getParameter("attendance_id"));
//            out.println(attendance_id);
                MainClass obj = new MainClass();
                if (request.getParameter("download_attendanc") != null) {
//                int attendance_id = Integer.parseInt(request.getParameter("attendance_id"));
////                out.println(attendance_id);

                    XSSFWorkbook workbook = new XSSFWorkbook();
                    XSSFSheet sheet = workbook.createSheet("Attendance");
                    Map<String, Object> attendance = obj.getAttendanceByAttendanceId(attendance_id);
                    out.print(attendance);
                    if (attendance != null && !attendance.isEmpty()) {
                        String filename
                                = attendance.get("lecture_date") + "_" + attendance.get("branch")
                                + "_" + attendance.get("semester") + "_" + attendance.get("subject_code")
                                + "_" + attendance.get("subject_type") + "_attendance.xlsx";
                        List<String> student_list = Arrays.asList(((String) attendance.get("present_student_list")).split(","));

                        int rownum = 0;

                        // Create headers
                        XSSFRow headerRow = sheet.createRow(rownum++);
                        headerRow.createCell(0).setCellValue("Branch");
                        headerRow.createCell(1).setCellValue("Semester");
                        headerRow.createCell(2).setCellValue("Subject Code");
                        headerRow.createCell(3).setCellValue("Subject Name");
                        headerRow.createCell(4).setCellValue("Lecture Type");
                        headerRow.createCell(5).setCellValue("Lecture Time ");

                        // Populate data
                        int count = 1;

                        XSSFRow dataRow = sheet.createRow(rownum++);

                        dataRow.createCell(0).setCellValue(attendance.get("branch").toString());
                        dataRow.createCell(1).setCellValue(attendance.get("semester").toString());
                        dataRow.createCell(2).setCellValue(attendance.get("subject_code").toString());
                        dataRow.createCell(3).setCellValue(attendance.get("subject_name").toString());
                        dataRow.createCell(4).setCellValue(attendance.get("subject_type").toString());
                        dataRow.createCell(5).setCellValue(attendance.get("time_start") + "-" + attendance.get("time_end"));

                        // Create a new row for "ID" and "Student ID" columns
                        XSSFRow idRow = sheet.createRow(rownum++);
                        idRow.createCell(0).setCellValue("Sr.No.");
                        idRow.createCell(1).setCellValue("Student ID");

                        for (String student : student_list) {
                            XSSFRow row = sheet.createRow(rownum++);
                            row.createCell(0).setCellValue(count++);
                            row.createCell(1).setCellValue(student);
                        }
                        // Set response headers for download
                        response.setHeader("Content-Disposition", "attachment; filename=" + filename);

                        // Set content type
                        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");

                        // Write the Excel workbook to the response output stream
                        workbook.write(response.getOutputStream());
                        workbook.close();

                    } else {
                        out.println("Data not found");
                    }

                }
            } catch (NumberFormatException e) {
                out.println("Invalid attendance ID");
            }
        %>
    </body>
</html>
<%@ include file="footer.jsp" %>
