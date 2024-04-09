<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.*" %>
<%@page import="javax.servlet.http.HttpSession"%>

<% HttpSession sesion = request.getSession(true); %>
<% if(sesion.isNew() || sesion==null)
    {
    response.sendRedirect("index.html");
    return;
    }
     
%>
<%String tipou = (String) sesion.getAttribute("tipou");%>
<%
    if (tipou == null || tipou.equals("2") || tipou.equals("4") || tipou.equals("1")) {
    response.sendRedirect("index.html");
    return;
}
%>
<%!
Conexion pal;
Connection con;
Statement stmt;
ResultSet rs,rs2;
String respo,resBD;
%>
<%
    int userID = (int) sesion.getAttribute("usu_id");
     pal = new Conexion();
     con = pal.getConnection();
     stmt = con.createStatement();
    rs = stmt.executeQuery("select rpo_calif from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id where usu_id=  "+ userID+"");
    if(rs.next()){
    respo = rs.getString("rpo_calif");
    }
   
    rs2 = stmt.executeQuery("select rbd_calif from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id where usu_id= "+userID+""); 
    if(rs2.next()){
    resBD= rs2.getString("rbd_calif");
    }
    
    
%>


<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Agradecimiento</title>
    <link rel="shortcut icon" href="./assets/logo1.png" />
    <link rel="stylesheet" href="css/agradecimiento.css" />
  </head>
  <body>

    <header>
        <img src="./assets/logo1.png" class="imglogo"/>
        <p class="h21">Skill-tech</p>
    </header>
    
    <div class="row" id="centro">
        <section>
            <h5 class="small-text">En hora buena, tus resultados ya han sido registrados. </h5><br><br>
            <h1 class="medium-text">¡Muchas gracias por tu colaboración! </h1>
            <br>
            <h5 class="small-text">Obtuviste : <span><%= respo %></span> aciertos en el formulario de POO </h5>
            <br>
             <h5 class="small-text">Obtuviste : <span><%= resBD %></span> aciertos en el formulario de Bases de Datos</h5>
            <br>
            <h5 class="small-text">Tu contribución es muy importante para nosotros, con el nos brindas la oportunidad de dar a conocer el <br>potencial de nuestra comunidad. </h5>
            <hr>
            <h5 class="small-text">No olvides visitarnos en nuestras redes sociales</h5>
            <h5 class="medium-text"><a href="https://www.facebook.com/profile.php?id=61553816145155"><img src="assets/facebook.png" class="logos"></a> | <a href="https://twitter.com/SkillTechpb"><img src="assets/twitter.png" class="logos"></a> | <a href="https://www.instagram.com/skilltechpb/"><img src="assets/instagram.png" class="logos"></a> </h5>
            <img src="assets/logo1.png" class="logos"><img src="assets/Skill-Tech.png" class="logos" id="verticalalign">
            <div id="izquierda">
                <a href="#"> <form action="Cerrar" method="post"><input type="submit" value="Regresar al inicio" class="Botona"></form></a>
            </div>
        </section>
      </div>
  </body>
  <div class="animateme">
    <ul class="bg-bubbles">
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
      <li></li>
    </ul>
  </div>
</html>
