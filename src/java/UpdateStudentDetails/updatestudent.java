package UpdateStudentDetails;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import mca.MainClass;

/**
 *
 * @author Divya Kumar Jain
 */
@MultipartConfig
public class updatestudent extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            HttpSession session = request.getSession();
            String u_id = session.getAttribute("current_userid").toString();
            MainClass obj = new MainClass();

            if (request.getParameter("updateregistrationbtn") != null) {
                String profile_img_path = handleImageUpload(request.getPart("profile"), u_id, "profile_pic");
                String tenth_img_path = handleImageUpload(request.getPart("10th_marksheet"), u_id, "10th_marksheet");
                String twelve_img_path = handleImageUpload(request.getPart("12th_marksheet"), u_id, "12th_marksheet");
                String degree_img_path = handleImageUpload(request.getPart("bachelor_degree"), u_id, "bachelor_degree");

                // Get other form parameters
                String blood_group = request.getParameter("blood_group");
                String tenthschool = request.getParameter("10th_school");
                String tenth_board = request.getParameter("10th_board");
                int tenthtotalmarks = Integer.parseInt(request.getParameter("10th_total_marks"));
                int tenthobtainedmarks = Integer.parseInt(request.getParameter("10th_obtained_marks"));
                String twelvestream = request.getParameter("12th_stream");
                String twelveschool = request.getParameter("12th_school");
                String twelveboard = request.getParameter("12th_board");
                int twelvetotalmarks = Integer.parseInt(request.getParameter("12th_total_marks"));
                int twelveobtainedmarks = Integer.parseInt(request.getParameter("12th_obtained_marks"));
                String bachelor_stream = request.getParameter("bachelor_stream");
                String bachelor_college = request.getParameter("bachelor_college");
                String bachelor_university = request.getParameter("bachelor_university");
                int bachelor_total_cgpa = Integer.parseInt(request.getParameter("bachelor_total_cgpa"));
                int bachelor_obtained_cgpa = Integer.parseInt(request.getParameter("bachelor_obtained_cgpa"));

                // Update student details in the database
                boolean updateResult = obj.updateStudentDetails(
                        u_id, profile_img_path, blood_group, tenthschool, tenth_board, tenthtotalmarks, tenthobtainedmarks,
                        tenth_img_path, twelvestream, twelveschool, twelveboard,
                        twelvetotalmarks, twelveobtainedmarks, twelve_img_path, bachelor_stream, bachelor_college,
                        bachelor_university,
                        bachelor_total_cgpa, bachelor_obtained_cgpa, degree_img_path);

                if (updateResult) {
                    // Display a success message using JavaScript alert
                    out.println("<script>alert('Details Updated Successfully');"
                            + "window.location.href='http://localhost:8080/mcaproject/student_details.jsp'</script>");
                    return; // Exit the method after successful update
                } else {
                    out.println("<script>alert('Failed to update details');"
                            + "window.location.href='http://localhost:8080/mcaproject/student_details.jsp'</script>");
                }

            }
//

            if (request.getParameter("profile_clear") != null) {
                obj.clear_image(u_id, "profile_pic");
            }
            if (request.getParameter("10th_marksheet_clear") != null) {
                obj.clear_image(u_id, "10th_marksheet");
            }
            if (request.getParameter("12_marksheet_clear") != null) {
                obj.clear_image(u_id, "12th_marksheet");
            }
            if (request.getParameter("degree_clear") != null) {
                obj.clear_image(u_id, "bachelor_degree");
            }
            response.sendRedirect("http://localhost:8080/mcaproject/student_details.jsp");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(updatestudent.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(updatestudent.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        processRequest(request, response);
    }

    private String handleImageUpload(Part filePart, String userId, String folderName) throws IOException {
        if (filePart == null || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
            try {
                // No file was uploaded, use the existing path
                MainClass obj = new MainClass();
                 return obj.get_student_details(userId).get(folderName).toString();
//                Object existingPath = obj.get_student_details(userId).get(folderName);
//                if (existingPath != null) {
//                    return existingPath.toString();
//                }
            } catch (ClassNotFoundException ex) {
                Logger.getLogger(updatestudent.class
                        .getName()).log(Level.SEVERE, null, ex);
            }
            // If there was no existing path and no file uploaded, return an empty string or handle as needed
//            return "";
        }

        String directoryPath = "C:/Users/divya jain/OneDrive/Documents/NetBeansProjects/mcaproject/web/image/" + userId;
        File directory = new File(directoryPath);
        directory.mkdirs();

        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        String filePath = directoryPath + File.separator + fileName;

        try (InputStream fileContent = filePart.getInputStream();
                FileOutputStream fileOutputStream = new FileOutputStream(filePath)) {
            int read;
            final byte[] bytes = new byte[1024];
            while ((read = fileContent.read(bytes)) != -1) {
                fileOutputStream.write(bytes, 0, read);
            }
        }

        return "image/" + userId + "/" + fileName;
    }
//

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
