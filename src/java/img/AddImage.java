/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package img;

import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import mca.Mail;
import mca.MainClass;

/**
 *
 * @author Divya Kumar Jain
 */
@MultipartConfig
@WebServlet("/AddImage")
public class AddImage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            if (request.getParameter("add_note_btn") != null) {
                try {
                    String notice_title = request.getParameter("notice_title");
                    String student_branch = request.getParameter("student_branch");
                    Part file = request.getPart("notice_img");
                    String notice_text = request.getParameter("notice_text");
                    String imageFileName = file.getSubmittedFileName();

                    String uploadPath = "C:/Users/divya jain/OneDrive/Documents/NetBeansProjects/mcaproject/web/image/notice/" + student_branch + "/" + imageFileName;
                    String upload = "image/notice/" + student_branch + "/" + imageFileName;
                    try {
                        FileOutputStream fos = new FileOutputStream(uploadPath);
                        InputStream is = file.getInputStream();

                        byte[] data = new byte[is.available()];
                        is.read(data);
                        fos.write(data);
                        fos.close();
                    } catch (Exception e) {
                        System.out.println(e.toString());
                    }
                    MainClass obj = new MainClass();
                    boolean notice = obj.add_notice(notice_title, notice_text, upload, student_branch);

                    if (notice) {
                        // Send an email to the branch
                        String subject = "New Notice: " + notice_title;
                        String messageBody = "A new notice has been added to your branch.\n\n"
                                + "Notice Title: " + notice_title 
                                + "\nNotice Text: " + notice_text;
                        Mail m = new Mail();
                        List<String> branchEmail = obj.getBranchEmails(student_branch); // Implement the method to get branch email
                        if (branchEmail != null && !branchEmail.isEmpty()) {
                            String branchemail = branchEmail.toString();
                            m.sendEmail(branchemail, subject, messageBody);

                            // Also, send the notice to all students in the branch
                            List<String> studentEmails = obj.getBranchEmails(student_branch); // Implement the method to get student emails in the branch

                            if (studentEmails != null && !studentEmails.isEmpty()) {
                                for (String studentEmail : studentEmails) {
                                    // Modify this part as needed to send the notice to each student
//                                    Mail m = new Mail();
                                    String recipient = studentEmail;
                                    String studentSubject = "New Notice: " + notice_title;
                                    String studentMessage
                                            = "<h3>Dear Students<b></b></h3>"
                                            + "<p style='font-size: 16px'>"
                                            + "<h2>A new notice has been added to your branch." + "</h2></br>"
                                            + "<div style='font-size: 16px'>Notice Title :  <b>" + notice_title + "</b></br></div>"
                                            + "<div style='font-size: 16px'>Notice Text: <b>" + notice_text + "</b></div>"
                                            + "</p>"
                                            + "<p style='font-size: 16px'>With Regards,<br>CHARUSAT</p>"
                                            + "<p style='font-size: 16px'><b style='color: red'>Note:</b>This is a system generated mail. Please do not reply to this mail.</p>";
                                            
                                    m.sendEmail(recipient, studentSubject, studentMessage);
                                }
                            }
                        } else {
                            out.println("<script>alert('Error: Branch email not found!');"
                                    + "window.location.href='http://localhost:8080/mcaproject/add_notice.jsp'</script>");
                            return;
                        }
                        out.println("<script>alert('Notice added scuessfully!!!');"
                                + "window.location.href='http://localhost:8080/mcaproject/dashboard.jsp'</script>");
                    } else {
                        out.println("<script>alert('Notice is not added scuessfully!!!');"
                                + "window.location.href='http://localhost:8080/mcaproject/add_notice.jsp'</script>");
                    }

                } catch (ClassNotFoundException ex) {
                    Logger.getLogger(AddImage.class.getName()).log(Level.SEVERE, null, ex);
                } catch (SQLException ex) {
                    Logger.getLogger(AddImage.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet AddImage</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet AddImage at " + request.getContextPath() + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
        }
    }

// <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
