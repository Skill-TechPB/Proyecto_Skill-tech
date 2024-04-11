/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package API;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import Conexion.Conexion;
/**
 *
 * @author d3
 */
import java.io.BufferedReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Base64;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
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
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;





@WebServlet(name = "TEST", urlPatterns = {"/TEST"})
public class TEST extends HttpServlet {
    String x, error;
    ResultSet rs;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.addHeader("Access-Control-Allow-Origin","*");
//        response.setContentType("application/json;charset=UTF-8");
          response.setContentType("text/plain;charset=UTF-8");
        
          try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            
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
                

            
            //out.println(jb.toString());
            
            
            
            try {
                JSONObject jsonObject = new JSONObject( jb.toString() );
                String secretKey = "vedZ3oXi";
                String CorreoElec = jsonObject.getString("correo");
                String Contra = jsonObject.getString("contrasena");
                String encryptedPassword = encryptDES(Contra, secretKey);
                                 try {
            Conexion cn = new Conexion();
            Connection con = cn.getConnection();
            Class.forName("com.mysql.jdbc.Driver");
            String consulta = "SELECT tpu_id, usu_id, usu_hab FROM usuario WHERE usu_email = ? AND usu_password= ?";
            PreparedStatement pst = con.prepareStatement(consulta);
            pst.setString(1, CorreoElec);
            pst.setString(2, encryptedPassword);
            rs = pst.executeQuery();
                  String contraAdmin ="C0cT4L1@$";
        String correoadmin="admin13@gmail.com";  
              
       if (CorreoElec.equals(correoadmin)&& Contra.equals(contraAdmin)){
          /*  boolean create = true;
            HttpSession session = request.getSession(create);
             String tipou="4";
            session.setAttribute("tipou",tipou);
            session.setAttribute("banderita",banderaAdmin);
            response.sendRedirect("admin.jsp"); */
         out.println( " entro admin " );
        }

            if (rs.next()) {
                // El usuario existe en la base de datos
                int habilitado = rs.getInt("usu_hab");
                if(habilitado == 0){
                    //response.sendRedirect("iniciosesion.html?msg=1"); //Json
                    error = "Usuario deshabilitado";
                    out.println( " entro a habilitado 0" );
                }
                
                String tipou = rs.getString("tpu_id");
                int userId = rs.getInt("usu_id");
                
                  // Validar si el usuario tiene registro en la tabla profesor
                if(tipou.equals("1")){
                    String profesorConsulta = "SELECT usu_id FROM profesor WHERE usu_id = ?";
                PreparedStatement profesorPst = con.prepareStatement(profesorConsulta);
                profesorPst.setInt(1, userId);
                ResultSet profesorRs = profesorPst.executeQuery();
  JSONObject responseJson = new JSONObject();
        responseJson.put("message", "entro profesor");
        // Imprimir el JSON creado en la consola del servidor
        System.out.println(responseJson.toString());
        // Configurar el tipo MIME de la respuesta como application/json
        response.setContentType("application/json");
        // Enviar la respuesta JSON
        out.print(responseJson.toString());
        out.flush();
                if (profesorRs.next()) {
                    boolean create = true;
                    HttpSession session = request.getSession(create);
                    session.setAttribute("usu_id", userId);
                    session.setAttribute("tipou", tipou);
                     String teken = "Select usu_tk from usuario where usu_email= ? and usu_password= ?";
                        PreparedStatement tkst = con.prepareStatement(teken);
                        tkst.setString(1,CorreoElec);
                        tkst.setString(2,encryptedPassword);
                        rs = tkst.executeQuery();
                    if (rs.next()){
                        String tokensito = rs.getString("usu_tk");
                    if(tokensito != null){
                      //  response.sendRedirect("graficas.jsp");
                       out.println( " entro a profesor con token");
                        profesorRs.close();
                        profesorPst.close();
                        tkst.close();
                        rs.close();
                        return;
                    }else{
                        x = generarCadenaAleatoria();
                        session.setAttribute("TK", x);
                        //enviarCorreo(CorreoElec, "Token de Skilltech", "Hola "+CorreoElec+" su token: "+x);
                       // response.sendRedirect("teken.jsp");
                        out.println( " entro a profesor sin token" );
                    }
                    }
                        
                    }
                    // El usuario tiene registro en la tabla profesor
/*
                }else if(tipou.equals("2")){
                    boolean create = true;
                    HttpSession session = request.getSession(create);
                    session.setAttribute("usu_id", userId);
                    session.setAttribute("tipou", tipou);
                    out.println( " entro a jefe" );
                    String teken = "Select usu_tk from usuario where usu_email= ? and usu_password= ?";
                        PreparedStatement tkst = con.prepareStatement(teken);
                        tkst.setString(1,CorreoElec);
                        tkst.setString(2,encryptedPassword);
                        rs = tkst.executeQuery();
                     if (rs.next()){
                        String tokensito = rs.getString("usu_tk");
                    if(tokensito != null ){
                       // response.sendRedirect("Editform.jsp");
                        tkst.close();
                        rs.close();
                        out.println( " entro a jefe con token" );
                    }else{
                        x = generarCadenaAleatoria();
                        session.setAttribute("TK", x);
                        // enviarCorreo(CorreoElec, "Token de Skilltech", "Hola "+CorreoElec+" su token: "+x);
                       // response.sendRedirect("teken.jsp");
                    out.println( " entro a jefe sin token" );
                        return;
                    }
                }*/
                }
                
            } else {
                // El usuario no existe en la base de datos
               //response.sendRedirect("iniciosesion.html?msg=1");
                out.println( "no hay cuenta " );
                    error = "Usuario deshabilitado";
            }
            rs.close();
            pst.close();
        } catch (Exception e) {
        } 
            } catch (JSONException e) {
                // crash and burn
                out.println(e);
                throw new IOException("Error parsing JSON request string");
                
            }
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
            Logger.getLogger(TEST.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(TEST.class.getName()).log(Level.SEVERE, null, ex);
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

public static String generarCadenaAleatoria() {
        String caracteresPosibles = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        Random random = new Random();
        StringBuilder cadenaGenerada = new StringBuilder();
        for (int i = 0; i < 5; i++) {
            int indiceAleatorio = random.nextInt(caracteresPosibles.length());
            char caracterAleatorio = caracteresPosibles.charAt(indiceAleatorio);
            cadenaGenerada.append(caracterAleatorio);
        }
        return cadenaGenerada.toString();
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
