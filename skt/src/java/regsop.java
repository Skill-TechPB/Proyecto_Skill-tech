/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Conexion.Soporte;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import org.json.JSONObject;
/**
 *
 * @author Hurtado
 */
@WebServlet(urlPatterns = {"/regsop"})
public class regsop extends HttpServlet {
    String error = "", correo="", desc="", tipo="";
    String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.addHeader("Access-Control-Allow-Origin","*");
          response.setContentType("text/plain;charset=UTF-8");
        
          try ( PrintWriter out = response.getWriter()) {
            
            StringBuffer jb = new StringBuffer();
            String line = null;
            String lineAP = null;
            try {
                BufferedReader reader = request.getReader();
                while ( (lineAP=reader.readLine())!=null ){
                    if (lineAP.trim() != "" ){
                        line = lineAP.trim();
                        jb.append(line.trim());
                        
                    }
                }
                 reader.close();
            } catch (Exception e) { /*report an error*/ }
        try {
            JSONObject jsonObject = new JSONObject( jb.toString() );
            Soporte cn = new Soporte();
            Connection con = cn.getConnection();
            Class.forName("com.mysql.jdbc.Driver");
            correo = jsonObject.getString("email");
            desc = jsonObject.getString("description");
            tipo = jsonObject.getString("tipo");            
            PreparedStatement insertStatement;
            insertStatement = con.prepareStatement("insert into incidencia(inc_email, inc_descripcion, inc_fch, est_id, tin_id) values(?,?,?,?,?)");
            insertStatement.setString(1, correo);
            insertStatement.setString(2, desc);
            insertStatement.setString(3, timeStamp);
            insertStatement.setInt(4, 1);
            insertStatement.setInt(5, Integer.parseInt(tipo));
            insertStatement.executeUpdate();
            insertStatement.close();
            con.close();
        } catch (ClassNotFoundException | SQLException ex) {
            error = "Error al registrar/actualizar los datos: " + ex.getMessage();
            response.setContentType("text/html;charset=UTF-8");
            response.sendRedirect("index.html");
        }
    }
}
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    processRequest(request, response);
}

}

