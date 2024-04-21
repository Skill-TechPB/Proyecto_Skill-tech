/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import javax.servlet.http.HttpSession;

/**
 *
 * @author olthek
 */
@WebServlet(urlPatterns = {"/resb"})
public class resb extends HttpServlet {
String resp[] = {"1","1","1","1","1","1","1","1","1","1"};
int [] lent = {1,1,1,1,1,1,1,1,1,1};
int [] lentv = new int[10];
String[] res = new  String[10];
String[] res2 = new  String[10];
String error="",niv;
String resfin;
int contador;
int banda;
int idegr;
boolean continar;
String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
Statement stmt;
ResultSet rs;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        res[0] = request.getParameter("p1");
        res[1] = request.getParameter("p2");
        res[2] = request.getParameter("p3");
        res[3] = request.getParameter("p4");
        res[4] = request.getParameter("p5");
        res[5] = request.getParameter("p6");
        res[6] = request.getParameter("p7");
        res[7] = request.getParameter("p8");
        res[8] = request.getParameter("p9");
        res[9] = request.getParameter("p10");
            //anillo de seguridad conpacto
        for (int d = 0; d < 10; d++) {
            if (res[d] == null || !res[d].matches("^[0-1]*$")) {
                response.sendRedirect("FBD.jsp?msg=nomuin"+res[d]);
                return; 
            }
            lentv [0]=res[0].length();
            lentv [1]=res[1].length();
            lentv [2]=res[2].length();
            lentv [3]=res[3].length();
            lentv [4]=res[4].length();
            lentv [5]=res[5].length();
            lentv [6]=res[6].length();
            lentv [7]=res[7].length();
            lentv [8]=res[8].length();
            lentv [9]=res[9].length();
            if(lentv[d]!=lent[d]){
                response.sendRedirect("FBD.jsp?msg=maslog");
            return; 
            }
            if(lentv[d]==lent[d] && res[d] != null && res[d].matches("^[0-1]*$")){
                resfin = String.join(" ",res);
                session.setAttribute("ResultPO",resfin);
                contador=0;
                for(int x=0;x<10;x++) {
                    if(res[x].equals(resp[x])){
                        res2[x]="Correcto";
                        contador++;
                    }else{
                        res2[x]="Mal";
                    }
                }
                if(contador<=4){
                    niv="0";
                }
                if(contador<=6 && 4<contador){
                    niv="1";
                }
                if(contador<=8 && 6<contador){
                    niv="2";
                    }
                if(contador<=10 && 8<contador){
                    niv="3";
                }
        }
            }
                try {
                    Conexion cn = new Conexion();
                    int idUsuario = (int) session.getAttribute("usu_id");
                    
                    Connection con = cn.getConnection();
                    Class.forName("com.mysql.jdbc.Driver");
                    
                    
                    String xd ="select count(*) as Bandbd from resultadobd inner join egresado on egresado.egr_id = resultadobd.egr_id inner join usuario on usuario.usu_id=egresado.usu_id where usuario.usu_id=?";
                    PreparedStatement consulta = con.prepareStatement(xd);
                    consulta.setInt(1,idUsuario);
                    rs = consulta.executeQuery();
                    if(rs.next()){
                    banda = rs.getInt("Bandbd");
                        if(banda == 1 ){
                        error = "Te crees muy chistoso bro?";
                        response.setContentType("text/html;charset=UTF-8");
                        response.sendRedirect("agradecimiento.jsp?msg="+error+"");
                        return;
                        }
                    }
                    
                    PreparedStatement insertStatement = con.prepareStatement("UPDATE egresado set egr_banBD=1 where usu_id=?");
                    insertStatement.setInt(1, idUsuario);
                    insertStatement.executeUpdate();
                    
                    session.setAttribute("banderaBD",1);
                    stmt = con.createStatement();
                    rs = stmt.executeQuery("select egr_id from egresado where usu_id="+idUsuario+"");
                    if(rs.next()){
                    idegr=rs.getInt("egr_id");
                        }
                    PreparedStatement insertStatement2 = con.prepareStatement("INSERT INTO resultadobd(rbd_fchrec, rbd_resp, rbd_calif, rbd_niv, egr_id) values(?,?,?,?,?)");
                    insertStatement2.setString(1, timeStamp);
                    insertStatement2.setString(2, resfin);
                    insertStatement2.setInt(3, contador);
                    insertStatement2.setString(4, niv);
                    insertStatement2.setInt(5, idegr);
                    insertStatement2.executeUpdate();
                    con.close();
                    stmt.close();
                    rs.close();
                    } catch (ClassNotFoundException | SQLException ex) {
                        error = "Error al registrar/actualizar los datos: " + ex.getMessage();
                        response.setContentType("text/html;charset=UTF-8");
                        response.sendRedirect("FBD.jsp?msg="+error);
                    }
                resfin="0";
                res[0] = "0";
                res[1] = "0";
                res[2] = "0";
                res[3] = "0";
                res[4] = "0";
                res[5] = "0";
                res[6] = "0";
                res[7] = "0";
                res[8] = "0";
                res[9] = "0";
                contador=0;
                idegr=0;
                response.setContentType("text/html;charset=UTF-8");
                response.sendRedirect("agradecimiento.jsp");
                return;
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
