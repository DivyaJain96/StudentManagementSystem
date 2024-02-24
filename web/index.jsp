<%-- 
    Document   : index
    Created on : 5 Jun, 2023, 8:48:16 PM
    Author     : Divya Kumar Jain
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<%@page session="true"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Index_Page</title>
    </head>
    <body>

        <div class="container my-3">
            <div id="carouselExampleControls" class="carousel slide shadow" data-bs-ride="carousel">
                <div class="carousel-inner">
                    <div class="carousel-item active">
                        <img src="site_img/bg3.jpg" class="d-block w-100" alt="bg2"  style="max-height:70vh;object-fit:cover;">
                    </div>
                    <div class="carousel-item">
                        <img src="site_img/bg1.jpg" class="d-block w-100" alt="bg2" style="max-height:70vh;object-fit:cover;">
                    </div>
                    <div class="carousel-item">
                        <img src="site_img/bg4.jpg" class="d-block w-100" alt="bg2" style="max-height:70vh;object-fit:cover;">
                    </div>
                </div>
                <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Previous</span>
                </button>
                <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleControls" data-bs-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="visually-hidden">Next</span>
                </button>
            </div>
        </div>

        <%  if (session.getAttribute("current_userid") != null) {
                out.println("Welcome " + session.getAttribute("current_userid"));
                out.println(session.getAttribute("current_userrole"));
                out.println("Welcome " + session.getAttribute("current_userrole"));
            }
        %>


    </body>
</html>
<%@ include file="footer.jsp" %>

