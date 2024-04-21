/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Josue
 */
@WebServlet(urlPatterns = {"/resprop"})
public class resprop extends HttpServlet {
    Statement stmt;
    String error = "";
    int idpro = 0, idegr=0;
    ResultSet rs;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        idpro= Integer.parseInt(request.getParameter("profe"));
        try {
        int idUsuario = (int) session.getAttribute("usu_id");
        Conexion cn = new Conexion();
        Connection con = cn.getConnection();
        Class.forName("com.mysql.jdbc.Driver");
        stmt = con.createStatement();
        
        rs=stmt.executeQuery("select egr_id from egresado where usu_id="+idUsuario+"");
        if(rs.next()){
        idegr=rs.getInt("egr_id");
        }
        PreparedStatement insertStatement;
        insertStatement = con.prepareStatement("insert into egr_pro(egr_id, pro_id) values(?,?)");
        insertStatement.setInt(1, idegr);
        insertStatement.setInt(2, idpro);
        insertStatement.executeUpdate();
        con.close();
        stmt.close();
        rs.close();
        } catch (ClassNotFoundException | SQLException ex) {
        error = "Error al registrar/actualizar los datos: " + ex.getMessage();
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("index.html");
        }
        //Nota: todo esto se aplica tambien para bd y cuando termina tambien lo reedirige a fpoo, pero gracias a las validaciones del diego lo reedirige a agradecimientos
        response.sendRedirect("FPOO.jsp");
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
