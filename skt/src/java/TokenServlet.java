/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.ResultSet;

/**
 *
 * @author olthek
 */
@WebServlet(urlPatterns = {"/TokenServlet"})
public class TokenServlet extends HttpServlet {
String error, token;
        int banPO= 0;
        int banBD= 0;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws IOException, SQLException {
        HttpSession session = request.getSession(true);
        Conexion cn = new Conexion();
        ResultSet rs;
        Connection con = cn.getConnection();
        token = request.getParameter("token");
        String TOK = (String) session.getAttribute("TK");
        int idUsuario = (int) session.getAttribute("usu_id");
        String tipou = (String) session.getAttribute("tipou");
        String teken = "Select usu_tk from usuario where usu_id= ? ";
        PreparedStatement tkst = con.prepareStatement(teken);
        tkst.setInt(1,idUsuario);
        rs = tkst.executeQuery();
        
        if (rs.next()){
        String tokensito = rs.getString("usu_tk");
        if(tokensito != null){
        if (tipou.equals("1")|| (tipou.equals("2"))){
        response.sendRedirect("graficas.jsp");
        }else if(tipou.equals("0")){
            String egresadoConsulta = "select egr_bandPOO, egr_banBD from egresado where usu_id= ? ";
                PreparedStatement POOPst = con.prepareStatement(egresadoConsulta);
                 POOPst.setInt(1, idUsuario); 
                ResultSet POORs = POOPst.executeQuery();
                if(POORs.next()){
                      banPO = POORs.getInt("egr_bandPOO");
                      banBD = POORs.getInt("egr_banBD");
                }
                if(banPO == 1 && banBD == 0){
                        response.sendRedirect("FBD.jsp");
                    }else if(banPO == 0 && banBD == 0){
                        response.sendRedirect("FPOO.jsp");
                    }else if(banPO == 1 && banBD == 1){
                        response.sendRedirect("agradecimiento.jsp");
                    }else if(banPO == 0 && banBD == 1){
                        response.sendRedirect("FPOO.jsp");
                    }  
        }
        }
        }
        
        if(tipou.equals("0")){
           String anio = (String) session.getAttribute("anioegreso"); 
        }
        
        
        

        if (validarToken(token)) {
            response.sendRedirect("teken.jsp");
            return;
        }

        if (token.equals(TOK)) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                 if(tipou.equals("0")){
                    String anio = (String) session.getAttribute("anioegreso"); 
                    PreparedStatement updateStatement = con.prepareStatement("UPDATE usuario SET usu_tk = ? WHERE usu_id = ?");
                    updateStatement.setString(1, token);
                    updateStatement.setInt(2, idUsuario);
                    updateStatement.executeUpdate();
                
                
                    PreparedStatement insertStatement = con.prepareStatement("INSERT INTO egresado(usu_id,egr_fch) values(?,?)");
                    insertStatement.setInt(1, idUsuario);
                    insertStatement.setString(2, anio);
                    insertStatement.executeUpdate();
                    response.sendRedirect("FPOO.jsp");
                    return;
                }else if (tipou.equals("1")|| (tipou.equals("2"))){
                    PreparedStatement updateStatement = con.prepareStatement("UPDATE usuario SET usu_tk = ? WHERE usu_id = ?");
                    updateStatement.setString(1, token);
                    updateStatement.setInt(2, idUsuario);
                    updateStatement.executeUpdate();
                    response.sendRedirect("graficas.jsp");
                    return;
                }
                
                
                
                
                
                
            } catch (ClassNotFoundException | SQLException ex) {
                error = "Error al registrar/actualizar los datos: " + ex.getMessage();
                response.sendRedirect("teken.jsp");
                return;
            }
        } else {
            response.sendRedirect("teken.jsp");
            error = "Los token no coinciden jajaja";
            return;
        }
    }

    public static boolean validarToken(String token) {
        String patron = "^[A-Z]{5}$";
        Pattern pattern = Pattern.compile(patron);
        Matcher matcher = pattern.matcher(token);
        return !matcher.matches();
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
    try {
        processRequest(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(TokenServlet.class.getName()).log(Level.SEVERE, null, ex);
    }
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
    try {
        processRequest(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(TokenServlet.class.getName()).log(Level.SEVERE, null, ex);
    }
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
