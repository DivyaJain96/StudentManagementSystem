/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package PDF;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Image;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import mca.MainClass;

/**
 *
 * @author Divya Kumar Jain
 */
public class DownloadPDF1 extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            MainClass obj = new MainClass();
            if (session.getAttribute("current_userid") != null) {
                if (session.getAttribute("current_userrole").equals("student")) {
                    if (request.getParameter("download") != null) {
                        String currentUserId = (String) session.getAttribute("current_userid");
                        String student_id = request.getParameter("student_id");
                        String student_name = "Student Name: " + request.getParameter("student_name");
                        String results_sem = request.getParameter("results_sem");
                        String student_branch = request.getParameter("student_branch");
                        String data = request.getParameter("downloadres");
                        String pdfFileName = student_id + "_sem" + results_sem + "_results.pdf";
                        int semester = Integer.parseInt(request.getParameter("results_sem"));
                        try {
                            response.setContentType("application/pdf");
                            response.setHeader("Content-Disposition", "attachment; filename=\"" + pdfFileName + "\"");
                            // Create a Document
                            Document document = new Document(PageSize.A4);
                            // Create a PdfWriter instance
                            OutputStream out = response.getOutputStream();
                            PdfWriter writer = PdfWriter.getInstance(document, out);
                            // Create a custom PageEvent for header and footer (you can define this separately)
//                            MyHeaderFooter event = new MyHeaderFooter();
//                            writer.setPageEvent(event);
                            document.open();
                            // Add your content here
//                            document.addTitle("Student Results");
//                            document.addSubject("Results for " + student_name);
//                            document.addAuthor("Divya Jain"); // Set the author's name

                            // Add header content
                            Image logo = Image.getInstance(getServletContext().getRealPath("/site_img/cmpica-logo.jpg"));
                            logo.scaleToFit(100, 100);
                            logo.setAlignment(Element.ALIGN_LEFT);
                            document.add(logo);

                            // Define the fonts
                            BaseFont bf = BaseFont.createFont(BaseFont.TIMES_ROMAN, BaseFont.CP1252, BaseFont.NOT_EMBEDDED);
                            Font titleFont = new Font(bf, 15, Font.BOLD);
                            Font headerFont = new Font(bf, 12, Font.BOLD);
                            Font normalFont = new Font(bf, 12);

                            // Add the rest of the header content
                            Paragraph title = new Paragraph("CHAROTAR UNIVERSITY OF SCIENCE AND TECHNOLOGY, CHANGA - 388421", titleFont);
                            title.setAlignment(Element.ALIGN_CENTER);

                            // Add header content
                            document.add(title);
                            document.add(new Paragraph("SEMESTER GRADE REPORT", titleFont));
                            document.add(new Paragraph("FACULTY OF COMPUTER SCIENCE AND APPLICATIONS", titleFont));
                            document.add(new Paragraph(student_name, headerFont));
                            document.add(new Paragraph("Student Id: " + student_id, headerFont));
                            document.add(new Paragraph("Semester: " + results_sem, headerFont));
                            document.add(new Paragraph("Branch: " + student_branch, headerFont));

                            // Add a blank line
                            document.add(Chunk.NEWLINE);

                            //Create a table for results
                            //Create a PdfPTable with 6 columns (one for each column name)
                            PdfPTable table = new PdfPTable(6);
                            table.setWidthPercentage(100);
                            table.setWidths(new int[]{2, 3, 2, 2, 3, 2});

                            List<Map<String, Object>> getResults = obj.getStudentResults(currentUserId, semester);

                            // Define the column names
                            String[] columnNames = {
                                "Subject Code", "Subject Name", "Subject Type",
                                "Total Marks", "Obtained Marks", "Grade"
                            };

                            PdfPCell cell;
                            // Add the column names to the table
                            for (String columnName : columnNames) {
                                cell = new PdfPCell(new Phrase(columnName, headerFont));
                                cell.setVerticalAlignment(Element.ALIGN_CENTER);
                                cell.setBackgroundColor(new BaseColor(192, 192, 192)); // Gray background
                                table.addCell(cell);
                            }

                            int totalSubjectMarks = 0; // Initialize variable for total subject marks
                            int totalObtainedMarks = 0; // Initialize variable for total obtained marks

                            for (Map<String, Object> subject : getResults) {
                                String subjectCode = subject.get("subject_code").toString();
                                String subjectName = subject.get("subject_name").toString();
                                String subjectType = subject.get("subject_type").toString();
                                int externalMarks = Integer.parseInt(subject.get("subject_external_marks").toString());
                                int internalMarks = Integer.parseInt(subject.get("subject_internal_marks").toString());
                                int externalObtained = Integer.parseInt(subject.get("external_obtained_marks").toString());
                                int internalObtained = Integer.parseInt(subject.get("internal_obtained_marks").toString());
                                String status = subject.get("status").toString();
                                // Calculate total marks for the subject
                                int totalMarks = externalMarks + internalMarks;
                                // Calculate total obtained marks for the subject
                                int totalObtained = externalObtained + internalObtained;
                                // Add the data for the subject to the table
                                // Add subject details to the table
                                table.addCell(new Phrase(subjectCode, normalFont));
                                table.addCell(new Phrase(subjectName, normalFont));
                                table.addCell(new Phrase(subjectType, normalFont));
                                table.addCell(new Phrase(String.valueOf(totalMarks), normalFont));
                                table.addCell(new Phrase(String.valueOf(totalObtained), normalFont));
                                table.addCell(new Phrase(status, normalFont));
                                // Update the total subject marks and total obtained marks
                                totalSubjectMarks += totalMarks;
                                totalObtainedMarks += totalObtained;
                            }
                            // Calculate CGPA for all subjects
                            double cgpa = ((double) totalObtainedMarks / totalSubjectMarks) * 10;

                            // Add the table to the document
                            document.add(table);
                            // Add CGPA to the document
                            document.add(new Paragraph("CGPA: " + String.format("%.2f", cgpa),
                                    new Font(Font.FontFamily.TIMES_ROMAN, 12, Font.BOLD)));
                            document.close();
                        } catch (DocumentException ex) {
                            Logger.getLogger(DownloadPDF1.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
            }
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(DownloadPDF1.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    // Define your MyHeaderFooter class here as shown in the previous example
//
//    private class MyHeaderFooter extends PdfPageEventHelper {
//        // Implement the header and footer logic here
//        // Refer to the previous example for details
//        // ...
//
//    }

}
