/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Base64;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
/**
 *
 * @author Josue
 */
@WebServlet(urlPatterns = {"/regAdmin"})
public class regAdmin extends HttpServlet {
    ResultSet rs, rs2;
    String error="";
    String secretKey = "vedZ3oXi";
    String nameprof="",email="",passw="", asignatura="";
    int tpu =0,idusu=0, idpro=0;
    Conexion pal;
    Connection con;
    Statement stmt;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
            nameprof=request.getParameter("nombrepr");
            passw=request.getParameter("pasword");
            email=request.getParameter("email");
            asignatura=request.getParameter("check");
            tpu=Integer.parseInt(request.getParameter("tipou"));
            String encryptedPassword = encryptDES(passw, secretKey);
            if (validarNombreProfesor(nameprof)) {
            response.sendRedirect("admin.jsp?msg=nombreprofe");
        }
            if (validarEmail(email)) {
            response.sendRedirect("admin.jsp?msg=mail");
        }
             if (validarTipoUsuario(tpu)) {
            response.sendRedirect("admin.jsp?msg=usu");
        }
            try {
                        Conexion cn = new Conexion();
                        Connection con = cn.getConnection();
                        Class.forName("com.mysql.jdbc.Driver");
                        
                        PreparedStatement insertStatement = con.prepareStatement("INSERT INTO usuario(tpu_id,usu_password, usu_email) values(?,?,?)");
                        insertStatement.setInt(1, tpu);
                        insertStatement.setString(2, encryptedPassword);
                        insertStatement.setString(3,email);
                        insertStatement.executeUpdate();
                        pal = new Conexion();
                        con = pal.getConnection();
                        stmt = con.createStatement();
                        rs = stmt.executeQuery("select usu_id from usuario where usu_password='"+encryptedPassword+"' and usu_email='"+email+"'");
                        if(rs.next()){
                        idusu=rs.getInt("usu_id");
                        }
                        PreparedStatement insertStatement3 = con.prepareStatement("INSERT INTO profesor(usu_id, pro_nombre) values(?,?)");
                        insertStatement3.setInt(1, idusu);
                        insertStatement3.setString(2, nameprof);
                        insertStatement3.executeUpdate();
                        
                        
                        rs2 = stmt.executeQuery("select pro_id from profesor where usu_id="+idusu+"");
                        if(rs2.next()){
                        idpro=rs2.getInt("pro_id");
                        }
                        if(asignatura.equals("0")){
                        PreparedStatement insertStatement2 = con.prepareStatement("INSERT INTO pro_asi(pro_id,asi_id) values(?,?)");
                        insertStatement2.setInt(1, idpro);
                        insertStatement2.setInt(2, 0);
                        insertStatement2.executeUpdate();    
                        }else if(asignatura.equals("1")){
                        PreparedStatement insertStatement2 = con.prepareStatement("INSERT INTO pro_asi(pro_id,asi_id) values(?,?)");
                        insertStatement2.setInt(1, idpro);
                        insertStatement2.setInt(2, 1);
                        insertStatement2.executeUpdate(); 
                        }else if(asignatura.equals("2")){
                        PreparedStatement insertStatement2 = con.prepareStatement("INSERT INTO pro_asi(pro_id,asi_id) values(?,?),(?,?)");
                        insertStatement2.setInt(1, idpro);
                        insertStatement2.setInt(2, 0);
                        insertStatement2.setInt(3, idpro);
                        insertStatement2.setInt(4, 1);
                        insertStatement2.executeUpdate();
                        
                        }
                        enviarCorreo(email, "Ingreso a Skilltech", "Hola "+nameprof+" se te ha registrado en Skill-tech con el siguiente correo "+email+" y con la contraseña "+passw);
                        response.sendRedirect("admin.jsp");
                        } catch (ClassNotFoundException | SQLException ex) {
                            error = "Error al registrar/actualizar los datos: " + ex.getMessage();
                            response.setContentType("text/html;charset=UTF-8");
                            response.sendRedirect("index.html?msg"+error);
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
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(regAdmin.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (Exception ex) {
            Logger.getLogger(regAdmin.class.getName()).log(Level.SEVERE, null, ex);
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
    
private static String encryptDES(String message, String secretKey) throws Exception {
    Cipher cipher = Cipher.getInstance("DES");
    SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
    SecretKey key = keyFactory.generateSecret(new DESKeySpec(secretKey.getBytes(StandardCharsets.UTF_8)));
    cipher.init(Cipher.ENCRYPT_MODE, key);

    byte[] encryptedBytes = cipher.doFinal(message.getBytes(StandardCharsets.UTF_8));
    return Base64.getEncoder().encodeToString(encryptedBytes);
}
    public static boolean validarNombreProfesor(String nameprof) {
        String patron = "^[a-zA-Z]{4,50}$";
        return !nameprof.matches(patron);
    }
    public static boolean validarEmail(String email) {
        String patron = "^\\w+([.-]?\\w+)*@\\w+([.-]?\\w+)*(\\.\\w{2,})+$";
        if (email.length() >= 200) {
            return false;
        }
        Pattern pattern = Pattern.compile(patron);
        Matcher matcher = pattern.matcher(email);
        return !matcher.matches();
    }
    public static boolean validarTipoUsuario(int tpu) {
        return tpu != 1 && tpu != 2;
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
}
