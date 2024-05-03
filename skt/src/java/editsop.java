/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Conexion.Soporte;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Josue
 */
@WebServlet(urlPatterns = {"/editsop"})
public class editsop extends HttpServlet {
    ResultSet rs;
    Statement stmt;
    int idinc=0, idpro=0;
    String fch="",email="",desc="", tipo="", prio="",est="", pronombre="",proemail="",proapellido="", error="";
    String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            idinc = Integer.parseInt(request.getParameter("idinc"));
            idpro = Integer.parseInt(request.getParameter("programinc"));
            fch = request.getParameter("fchinc");
            email = request.getParameter("emailinc");
            desc = request.getParameter("descinc");
            tipo = request.getParameter("tipoinc");
            prio = request.getParameter("prioinc");
            est = request.getParameter("estinc");
            try {
            Soporte cn = new Soporte();
            Connection con = cn.getConnection();
            Class.forName("com.mysql.jdbc.Driver");
            stmt = con.createStatement();
            
            rs=stmt.executeQuery("select pro_nombre, pro_apellido, pro_email from programador where pro_id="+idpro+"");
            while(rs.next()){
            pronombre=rs.getString("pro_nombre");
            proapellido=rs.getString("pro_apellido");
            proemail=rs.getString("pro_email");
            }
            PreparedStatement insertStatement;
            insertStatement = con.prepareStatement("insert into pro_inc(pro_id, inc_id, pri_fche) values(?,?,?)");
            insertStatement.setInt(1, idpro);
            insertStatement.setInt(2, idinc);
            insertStatement.setString(3, timeStamp);
            insertStatement.executeUpdate();
            
            PreparedStatement updateStatement = con.prepareStatement("UPDATE incidencia SET est_id = 2 WHERE inc_id = ?");
            updateStatement.setInt(1, idinc);
            updateStatement.executeUpdate();
            
            insertStatement.close();
            updateStatement.close();
            rs.close();
            stmt.close();
            con.close();
            //correo pal programador
            enviarCorreo(proemail, "Nueva incidencia asignada", "Hola "+pronombre+" "+proapellido+"\nSe le comunica que el administrador le ha asignado una nueva incidencia con los siquientes datos\nID: "+idinc+"\nFecha: "+fch+"\nDescripcion: "+desc+"\nPrioridad: "+prio+"\nDe antemano le agradecemos por su esfuerzo\nAtentamente: Administrador de Skill-Tech");
            response.setContentType("text/html;charset=UTF-8");
            response.sendRedirect("incidencia.jsp");
            return;
            } catch (ClassNotFoundException | SQLException ex) {
            error = "Error al registrar/actualizar los datos: " + ex.getMessage();
            response.setContentType("text/html;charset=UTF-8");
            response.sendRedirect("index.html");
        }
    }
private void enviarCorreo(String destinatario, String asunto, String cuerpo) {
        final String remitente = "skilltechpg@gmail.com";
        final String clave = "hgchqkoequuisqkn";
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        Session session = Session.getInstance(props,
                new javax.mail.Authenticator() {
                    protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
                        return new javax.mail.PasswordAuthentication(remitente, clave);
                    }
                });
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(remitente));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(destinatario));
            message.setSubject(asunto);
            message.setText(cuerpo);
            Transport.send(message);
        } catch (MessagingException e) {
            throw new RuntimeException(e);
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
