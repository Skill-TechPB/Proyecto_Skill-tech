<%-- 
    Document   : Reporte Anual
    Created on : 13 nov 2023, 21:51:33
    Author     : dieag
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.*" %>
<%@page import="javax.servlet.http.HttpSession"%>
<% HttpSession sesion = request.getSession(true); %>
<%if(sesion.isNew() || sesion == null) {
    response.sendRedirect("index.html");
    return;
}
%>
<%String aniorep = (String) sesion.getAttribute("reporte");%>
<%String tipou = (String) sesion.getAttribute("tipou");%>
<%if(tipou == null|| tipou.equals("0") || tipou.equals("3")|| tipou.equals("1")){
response.sendRedirect("index.html");
return;
 }
%>

<%!
Conexion pal;
Connection con;
Statement stmt;
ResultSet rs, rs2, rs3;
String nivel = "";
String nivelBD="";
double total;
double masomenos = 0;
double regular = 0;
double malos = 0;
double buenas = 0;

double avanzado = 0;
double intermedio =0;
double basico = 0; 
double min = 0;
double total2;
double percentBD1;
double percentBD2;
double percentBD3 ;
double percentBD4 ;

double porcentajePOO1 ;
double porcentajePOO2 ;
double porcentajePOO3 ;
double porcentajePOO4 ;
 
String numEgresados;

%>
<%
pal = new Conexion();
con = pal.getConnection();
stmt = con.createStatement();

rs = stmt.executeQuery("select rpo_niv FROM resultadopo inner join egresado on egresado.egr_id = resultadopo.egr_id where egr_fch = '"+aniorep+"'");


while (rs.next()) {
    nivel = rs.getString("rpo_niv");
    System.out.println(nivel);
    if (nivel.equals("2")) {
        masomenos++;
    }
    if (nivel.equals("3")) {
        buenas++;
    }
    if (nivel.equals("1")) {
        regular++;
    }
    if (nivel.equals("0")) {
        malos++;
    }
}

rs3 = stmt.executeQuery("select rbd_niv FROM resultadobd inner join egresado on egresado.egr_id = resultadobd.egr_id where egr_fch = '"+aniorep+"'");


while (rs3.next()) {
    nivelBD = rs3.getString("rbd_niv");
    System.out.println(nivelBD);
    if (nivelBD.equals("2")) {
        intermedio++;
    }
    if (nivelBD.equals("3")) {
        avanzado++;
    }
    if (nivelBD.equals("1")) {
        basico++;
    }
    if (nivelBD.equals("0")) {
        min++;
    }
}
rs2 = stmt.executeQuery("select count(*) as 'egresados' from egresado where egr_fch = '"+aniorep+"'");
if (rs2.next()) {
    numEgresados = rs2.getString("egresados");
} else {
    System.out.println("XD");
}
total = masomenos + buenas + regular + malos;

if (buenas != 0) {
    porcentajePOO1 =   buenas / total * 100;
}
if (masomenos != 0) {
    porcentajePOO2 =  masomenos / total * 100;
}
if (regular != 0) {
    porcentajePOO3 = regular / total * 100;
}
if (malos != 0) {
    porcentajePOO4 =  malos / total * 100;
}

total2 = avanzado + intermedio + basico + min;

if (avanzado != 0) {
    percentBD1 = avanzado / total2 * 100;
}
if (intermedio != 0) {
    percentBD2 =  intermedio / total2 * 100;
}
if (basico != 0) {
    percentBD3 =  basico / total2 * 100;
}
if (min != 0) {
    percentBD4 =  min /  total2 * 100;
}
%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Reporte Anual</title>
   
    <link rel="stylesheet" href="css/estiloreporte.css">
    <script type="text/javascript" src="JS/html2pdf.bundle.js"></script>
    <script src="html2pdf.bundle.js"></script>
    <link rel="shortcut icon" href="./assets/logo1.png" />
</head>
<body>
    <br>
    <br>
    <br>
<div class="reportes" id="reporte">
    <img class="ipn" src="assets/IPN-Logo.png">
    <img class="cecyt9" src="assets/cecyt-logo.png">

    <center>
        <h3>REPORTE GENERAL DE EGRESADOS ANIO <span><%= aniorep %></span></h3>
        <h3>CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLÓGICOS</h3>
        <h3>"JUAN DE DIOS BATIZ"</h3>
        <h4>CARRERA: PROGAMACIÓN</h4>
    </center>
    <br>
    <br>
    <br>
    <div class="text1">
        <p>La empresa MSDEV, encargada del desarrollo del sistema Skill-Tec,
            ha recopilado información a través de este sistema sobre los conocimientos de los egresados de
            la carrera de Técnico en Programación del CECyT 9 en las materias de Programación Orientada
            a Objetos y Bases de Datos. El propósito de esta recopilación es obtener datos cuantificables
            que faciliten el análisis y respalden la toma de decisiones futuras por parte de la academia de programación.
        </p>
    </div>

    <br>
    <div class="text2" id="txtbd">
        <label>De una muestra de <span><%= numEgresados %></span> egresados del año <span><%= aniorep %></span> se obtuvieron los siguientes resultados:<label>

    </div>
    <div class="text2" id="txt1bd">
        <p class="bold">
            PROGRAMACIÓN ORIENTADA A OBJETOS (POO):
        </p>
        <label> Avanzado: </label><span><%= porcentajePOO1 %></span>%
        <p> Intermedio: <span><%= porcentajePOO2 %></span>%</p>
        <p> Básico: <span><%= porcentajePOO3 %></span>%</p>
        <p> Mínimo: <span><%= porcentajePOO4 %></span>%</p>
    </div>
    <div class="text2" id="txt2bd">
        <p class="bold">
            BASES DE DATOS:
        </p>
        <p>
            Avanzado: <span><%= percentBD1 %></span> %
        </p>
        <p>
            Intermedio: <span><%= percentBD2 %></span>%
        </p>
        <p>
            Básico: <span><%= percentBD3 %></span>%
        </p>
        <p>
            Mínimo: <span><%= percentBD4 %></span>%
        </p>
    </div>
    <div class="text1">
        <p>
            “La obtención de estos porcentajes se realizó mediante formularios con preguntas obtenidas de exámenes a título de suficiencia las dos materias previamente mencionadas.”
        </p>
    </div>

    <div class="text1">
        <p class="bold">
            ATENTAMENTE:
        </p>
        <p class="bold">
            MIEMBROS DE MSDEV
        </p>
    </div>
    <img class="msdev" src="assets/logo_msdev.png">

</div>
</body>
<%
total = 0;
masomenos = 0;
regular = 0;
malos = 0;
buenas = 0;
avanzado = 0;
intermedio =0;
basico = 0; 
min = 0;
total2 = 0;
percentBD1 = 0;
percentBD2 = 0;
percentBD3 = 0 ;
percentBD4 = 0 ;
porcentajePOO1 = 0 ;
porcentajePOO2 = 0;
porcentajePOO3 = 0;
porcentajePOO4 = 0;
con.close();
stmt.close();
rs.close();
rs2.close();
rs3.close();
%>
<script src="JS/GeneradorPDF.js"></script>
</html>
