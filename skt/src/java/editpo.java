/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

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
import java.sql.Statement;
import java.sql.ResultSet;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.ArrayList;
import java.util.List;
import java.util.Arrays;
/**
 *
 * @author Josue
 */
@WebServlet(urlPatterns = {"/editpo"})
public class editpo extends HttpServlet {
    //Nuevas
    String[] prege = new String[10];
    String[] respe = new String[40];
    //id
    String[] valore= new String[10];
    
    //Originales
    String[] preg = new String[10];
    String[] resp = new String[40];
    //id
    String[] vals = new String[10];
    
    String timeStamp = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss").format(Calendar.getInstance().getTime());
    String error="";
    Statement stmt;
    ResultSet rs,rs2;
    //Este arreglo se encargara de guardar todas laas actualizaciones recibidas
    String[] genew = new String[90];
    String ruta = "";
    String content = "";
    int a = 0;
    int b = 0;
    int c = 0;
    int idpro=0;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(true);
        try {
                    //Inicio de todo
                    Conexion cn = new Conexion();
                    Connection con = cn.getConnection();
                    Class.forName("com.mysql.jdbc.Driver");
                    stmt = con.createStatement();
                    PreparedStatement insertStatement;
                    int idUsuario = (int) session.getAttribute("usu_id");
                    rs2 = stmt.executeQuery("select pro_id from profesor where usu_id="+idUsuario+"");
                    if(rs2.next()){
                    idpro=rs2.getInt("pro_id");
                    }
                    rs = stmt.executeQuery("select for_url from formulario where for_id=1");
                    while(rs.next()){
                    ruta =rs.getString("for_url");
                    }
                    File form = new File(ruta);

                    if(form.exists()== false){
                     try{
                     if(form.createNewFile()){
                     System.out.println("Se creo apa");
                     }else {
                         System.out.println("Ya existe o le moviste a algo");
                     }
                     }catch(IOException ex){
                     ex.printStackTrace(System.out);
                     }
                     } 

                    try{
                    //Se establece la comunicacion
                    FileReader leer = new FileReader(form);
                    BufferedReader lector = new BufferedReader(leer);

                    //Se lee el fichero
                    content = lector.readLine();
                    String gene[] = content.split("/ ");
                    //Preguntas
                    for(int i=0; i<preg.length;i++){
                    preg[i]=gene[i];
                    }
                    //Respuestas
                    a=preg.length;
                    for(int i=0; i<resp.length;i++ ){
                    resp[i]=gene[a];
                    a=a+1;
                    }a=0;
                    //Valores(id)
                    b=preg.length+resp.length;
                    c=0;
                    for(int i=0; i<resp.length;i++ ){
                    if(gene[b].equals("1")){
                    vals[c]=String.valueOf(b);
                    c=c+1;
                    }
                    b=b+1;
                    }b=0;c=0;
                    lector.close();
                    //id de lo si
                    }catch(IOException ex){
                    ex.printStackTrace(System.out);
                    }
                    //Se obtienen los arreglos de las modificaciones de preguntas y respuestas y se comparan con las originales
                    //pregunta
                    for(int i=0; i<prege.length;i++){
                    prege[i]=request.getParameter("editable"+String.valueOf(i+1));
                    if(prege[i].equals(preg[i])==true || prege[i]==""){
                    genew[i] = preg[i]+"/ ";
                    }else{
                    genew[i] = prege[i]+"/ ";
                    //bitacora
                    insertStatement = con.prepareStatement("insert into bitacora(pro_id, bit_fchmod, for_id, elf_id, bit_indice, bit_origen, bit_cambio) values(?,?,?,?,?,?,?)");
                    insertStatement.setInt(1, idpro);
                    insertStatement.setString(2, timeStamp);
                    insertStatement.setInt(3, 1);
                    insertStatement.setInt(4, 1);
                    insertStatement.setInt(5, i+1);
                    insertStatement.setString(6, preg[i]);
                    insertStatement.setString(7, prege[i]);
                    insertStatement.executeUpdate();
                    }
                    }
                    //respuesta
                    a=preg.length;
                    for(int i=0; i<respe.length;i++){
                    respe[i]=request.getParameter("respedit"+String.valueOf(i+1));
                    if(respe[i].equals(resp[i])==true || respe[i]==""){
                    genew[a] = resp[i]+"/ ";
                    }else{
                    genew[a] = respe[i]+"/ ";
                    //bitacora
                    insertStatement = con.prepareStatement("insert into bitacora(pro_id, bit_fchmod, for_id, elf_id, bit_indice, bit_origen, bit_cambio) values(?,?,?,?,?,?,?)");
                    insertStatement.setInt(1, idpro);
                    insertStatement.setString(2, timeStamp);
                    insertStatement.setInt(3, 1);
                    insertStatement.setInt(4, 2);
                    insertStatement.setInt(5, editpo.pospgt(i));
                    insertStatement.setString(6, resp[i]);
                    insertStatement.setString(7, respe[i]);
                    insertStatement.executeUpdate();
                    }
                    a=a+1;
                    }a=0;
                    //inicio de valores
                    //llenar lo que resta del array de 0
                    b=preg.length+resp.length;
                    for(int i=0; i<resp.length;i++){
                    genew[b]="0/ ";
                    b=b+1;
                    }
                    b=preg.length+resp.length;
                    for(int i=0; i<prege.length;i++){
                    valore[i]=request.getParameter("select"+String.valueOf(i+1));
                    if( valore[i]==null || valore[i].equals("")){
                    genew[Integer.parseInt(vals[i])] = "1/ ";
                    }else{
                    genew[Integer.parseInt(valore[i])+b-1] = "1/ ";
                    //bitacora
                    insertStatement = con.prepareStatement("insert into bitacora(pro_id, bit_fchmod, for_id, elf_id, bit_indice, bit_origen, bit_cambio) values(?,?,?,?,?,?,?)");
                    insertStatement.setInt(1, idpro);
                    insertStatement.setString(2, timeStamp);
                    insertStatement.setInt(3, 1);
                    insertStatement.setInt(4, 3);
                    insertStatement.setInt(5, editpo.pospgt(Integer.parseInt(valore[i])-1));
                    insertStatement.setInt(6, editpo.posresp(Integer.parseInt(vals[i])-49));
                    insertStatement.setInt(7, editpo.posresp(Integer.parseInt(valore[i])));
                    insertStatement.executeUpdate();
                    }
                    }b=0;
                    //fin de valores
                    FileWriter escribir = new FileWriter(form);
                    for(int i=0;i<genew.length;i++){
                        escribir.write(genew[i]);
                    }
                    escribir.close();
                    //fin 
                    } catch (ClassNotFoundException | SQLException ex) {
                        error = "Error al registrar/actualizar los datos: " + ex.getMessage();
                        response.setContentType("text/html;charset=UTF-8");
                        response.sendRedirect("FEDITPO.jsp");
                    }
        
        response.setContentType("text/html;charset=UTF-8");
        response.sendRedirect("Editform.jsp");
    }
    //Nota: lo que reciben estos metodos son numeros de entre 1 al 40 tocando los extremos, es por eso que a veces se suma 1 o se le resta 49
    static int posresp(int numero){
    int posicion=0;
    if(numero%4 == 0){
    posicion=4;
    }else if(numero%4 != 0){
    posicion=numero%4;
    }
    return posicion;
    }
    static int pospgt(int numero){
    int pregunta=0;
    if(numero/4==0){
    pregunta=1;
    }else if(numero/4!=0){
    pregunta=(numero/4)+1;
    }
    return pregunta;
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
