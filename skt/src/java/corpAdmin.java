/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author olthek
 */
@WebServlet(urlPatterns = {"/corpAdmin"})
public class corpAdmin extends HttpServlet {
        ResultSet rs;
        String error="";
        String idpro ="";
        int idusu=0;
        Conexion pal;
        Statement stmt;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
             idpro=request.getParameter("vivir");
            try {
                        Conexion cn = new Conexion();
                        Connection con = cn.getConnection();
                        Class.forName("com.mysql.jdbc.Driver");
                        pal = new Conexion();
                        con = pal.getConnection();
                        stmt = con.createStatement();
                        rs = stmt.executeQuery("select usu_id from profesor where pro_id="+idpro+"");
                        if(rs.next()){
                        idusu=rs.getInt("usu_id");
                        }
                        System.out.println(idusu);
                        if(idpro==null || idpro==""){
                        }else{
                        PreparedStatement insertStatement = con.prepareStatement("update usuario set usu_hab=1 where usu_id=?");
                        insertStatement.setInt(1, idusu);
                        insertStatement.executeUpdate();
                        }
                        response.setContentType("text/html;charset=UTF-8");
                        response.sendRedirect("admin.jsp");
                        } catch (ClassNotFoundException | SQLException ex) {
                            error = "Error al registrar/actualizar los datos: " + ex.getMessage();
                            response.setContentType("text/html;charset=UTF-8");
                            response.sendRedirect("index.html");
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
