/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import Conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.Random;
import java.util.logging.Level;
import java.util.logging.Logger;
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
import javax.servlet.http.HttpSession;

/**
 *
 * @author dieag
 */
@WebServlet(urlPatterns = {"/Sesion"})

public class Sesion extends HttpServlet {
String x;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
  String error = "";
        ResultSet rs;
        String CorreoElec = request.getParameter("lemail");
        String Contra = request.getParameter("lpassword");
        String secretKey = "vedZ3oXi";
        String encryptedPassword = encryptDES(Contra, secretKey);
        String contraAdmin ="C0cT4L1@$";
        String correoadmin="admin13@gmail.com";
        int banderaAdmin = 1;
        int banPO= 0;
        int banBD= 0;
       
       if (CorreoElec.equals(correoadmin)&& Contra.equals(contraAdmin)){
            boolean create = true;
            HttpSession session = request.getSession(create);
             String tipou="4";
            session.setAttribute("tipou",tipou);
            session.setAttribute("banderita",banderaAdmin);
            response.sendRedirect("admin.jsp");
        }
           
        try {
            Conexion cn = new Conexion();
            Connection con = cn.getConnection();
            Class.forName("com.mysql.jdbc.Driver");
            String consulta = "SELECT tpu_id, usu_id, usu_hab FROM usuario WHERE usu_email = ? AND usu_password= ?";
            PreparedStatement pst = con.prepareStatement(consulta);
            pst.setString(1, CorreoElec);
            pst.setString(2, encryptedPassword);
            rs = pst.executeQuery();
            
            

            if (rs.next()) {
                // El usuario existe en la base de datos
                int habilitado = rs.getInt("usu_hab");
                if(habilitado == 0){
                    response.sendRedirect("iniciosesion.html?msg=1");
                    error = "Usuario deshabilitado";
                }
                
                String tipou = rs.getString("tpu_id");
                int userId = rs.getInt("usu_id");
                
                  // Validar si el usuario tiene registro en la tabla profesor
                if(tipou.equals("1")){
                    String profesorConsulta = "SELECT usu_id FROM profesor WHERE usu_id = ?";
                PreparedStatement profesorPst = con.prepareStatement(profesorConsulta);
                profesorPst.setInt(1, userId);
                ResultSet profesorRs = profesorPst.executeQuery();
                
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
                        response.sendRedirect("graficasProf.jsp");
                        profesorRs.close();
                        profesorPst.close();
                        tkst.close();
                        rs.close();
                        return;
                    }else{
                        x = generarCadenaAleatoria();
                        session.setAttribute("TK", x);
                        enviarCorreo(CorreoElec, "Token de Skilltech", "Hola "+CorreoElec+" su token: "+x);
                        response.sendRedirect("teken.jsp");
                    }
                    }
                        
                    }
                    // El usuario tiene registro en la tabla profesor
                    
                
                }else if(tipou.equals("2")){
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
                    if(tokensito != null ){
                        response.sendRedirect("Editform.jsp");
                        tkst.close();
                        rs.close();
                        String jsonResponse = "{\"status\": \"ok\"}";
                        response.setContentType("application/json");
                        response.getWriter().write(jsonResponse.toString());
                        return;
                    }else{
                        x = generarCadenaAleatoria();
                        session.setAttribute("TK", x);
                        enviarCorreo(CorreoElec, "Token de Skilltech", "Hola "+CorreoElec+" su token: "+x);
                        response.sendRedirect("teken.jsp");
                        return;
                    }
                }
                }else if(tipou.equals("0")){
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
                String egresadoConsulta = "select egr_bandPOO, egr_banBD from egresado where usu_id= ? ";
                PreparedStatement POOPst = con.prepareStatement(egresadoConsulta);
                 POOPst.setInt(1, userId); 
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
                        return;
                    }else{
                        x = generarCadenaAleatoria();
                        session.setAttribute("TK", x);
                        enviarCorreo(CorreoElec, "Token de Skilltech", "Hola "+CorreoElec+" su token: "+x);
                        response.sendRedirect("teken.jsp");
                    }
                    }
                } 
                
            } else {
                // El usuario no existe en la base de datos
               response.sendRedirect("iniciosesion.html?msg=1");
                    error = "Usuario deshabilitado";
            }
            rs.close();
            pst.close();
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            
                out.println("<html><body><h2>"+e+"</h2></body></html>");
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
            Logger.getLogger(Sesion.class.getName()).log(Level.SEVERE, null, ex);
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
        Logger.getLogger(reg.class.getName()).log(Level.SEVERE, null, ex);
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

