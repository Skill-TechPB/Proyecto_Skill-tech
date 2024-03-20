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
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.ResultSet;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Random;
/**
 *
 * @author olthek
 */
@WebServlet(urlPatterns = {"/reg"})
public class reg extends HttpServlet {
String anioegreso,error,x;
ResultSet rs;
int [] lent = {200,200};
int [] lentv = new int[2];
String[] res = new  String[2]; 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
                res[0] = request.getParameter("email");
        res[1] = request.getParameter("lname");
            anioegreso= request.getParameter("anioegreso");
             for (int d = 0; d < 2; d++) {
                    if (res[d] == null) {
                        response.sendRedirect("iniciosesion.html");
                    return; 
                    }
                    lentv [0]=res[0].length();
                    lentv [1]=res[1].length();
                    if(lent[d]<lentv[d]){
                        response.sendRedirect("iniciosesion.html");
                    return; 
                    }
                    
                if(lentv[d]<lent[d] && res[d] != null){    
                try {
                    String secretKey = "vedZ3oXi";
                    String encryptedPassword = encryptDES(res[1], secretKey);
                    Conexion cn = new Conexion();
                    Connection con = cn.getConnection();
                    Class.forName("com.mysql.jdbc.Driver");
                    PreparedStatement insertStatement = con.prepareStatement("INSERT INTO usuario(usu_password, usu_email,tpu_id) values(?,?,0)");
                    insertStatement.setString(1, encryptedPassword);
                    insertStatement.setString(2, res[0]);
                    insertStatement.executeUpdate();      
                    boolean create = true;
                    HttpSession session = request.getSession(create);
                    session.setAttribute("email", res[0]);
                    session.setAttribute("password", res[1]);
                    String consulta = "SELECT usu_id FROM usuario WHERE usu_email = ?";
                    PreparedStatement pst = con.prepareStatement(consulta);
                    pst.setString(1, res[0]);
                    rs = pst.executeQuery();
                    if (rs.next()) {
                    int userId = rs.getInt("usu_id");
                    session.setAttribute("tipou","0");
                    session.setAttribute("usu_id", userId);
                    session.setAttribute("anioegreso", anioegreso);
                    x = generarCadenaAleatoria();
                    session.setAttribute("TK", x);
                    enviarCorreo(res[0], "Token de Skilltech", "Hola "+res[0]+" su token: "+x);
                response.setContentType("text/html;charset=UTF-8");
            response.sendRedirect("teken.jsp");
            return ;
                    }
                    } catch (ClassNotFoundException | SQLException ex) {
                        error = "Error al registrar/actualizar los datos: " + ex.getMessage();
                        response.setContentType("text/html;charset=UTF-8");
                        response.sendRedirect("iniciosesion.html");
                        return ;
                    }    
                }
        }
}         
    private void enviarCorreo(String destinatario, String asunto, String cuerpo) {
        String remitente = "skilltechpg@gmail.com";
        String clave = "hgchqkoequuisqkn";
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
    try {
        processRequest(request, response);
    } catch (Exception ex) {
        Logger.getLogger(reg.class.getName()).log(Level.SEVERE, null, ex);
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
}
