<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.*" %>
<%@page import="javax.servlet.http.HttpSession"%>
<% HttpSession sesion = request.getSession(true); %>
<%String tipou = (String) sesion.getAttribute("tipou");%>
<%int idUsuario = (int) sesion.getAttribute("usu_id");%>
<%if(sesion.isNew() || sesion==null)
    {
    response.sendRedirect("index.html");
    return;
    }
%>
<%
   if(tipou == null|| tipou.equals("0") || tipou.equals("3")){
   response.sendRedirect("index.html");
   return;
    }
%>
<!DOCTYPE html>
<%!
Conexion pal;
Connection con;
Statement stmt1;
ResultSet rs, rs2, rs3;
String nivel = "";
String nivelBD="";
int numEgresados=0;
int numEgresados2=0;
String nombre="";
String materia[] = new String[2];
double total=0;
double masomenos = 0;
double regular = 0;
double malos = 0;
double buenas = 0;

double avanzado = 0;
double intermedio =0;
double basico = 0; 
double min = 0;
double total2=0;
double percentBD1=0;
double percentBD2=0;
double percentBD3=0;
double percentBD4=0;
 
double porcentajePOO1=0;
double porcentajePOO2=0;
double porcentajePOO3=0;
double porcentajePOO4=0;
int z=0, x=0;
int profeID=0;
%>
<%
pal = new Conexion();
con = pal.getConnection();
stmt1 = con.createStatement();

ResultSet ip = stmt1.executeQuery("select profesor.pro_id, profesor.pro_nombre, asignatura.asi_nombre from asignatura inner join pro_asi on pro_asi.asi_id=asignatura.asi_id inner join profesor on profesor.pro_id=pro_asi.pro_id where profesor.usu_id="+idUsuario+"");
            z=0;
            while(ip.next()){
                profeID = ip.getInt("pro_id");
                nombre = ip.getString("pro_nombre");
                materia[z]=ip.getString("asi_nombre");
                z=z+1;
            }z=0;
%>

<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pagina de reportes</title>
    <link rel="stylesheet" href="css/rep.css">
    <link rel="stylesheet" href="css/estiloreporte.css">
    <link rel="shortcut icon" href="./assets/logo1.png" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script type="text/javascript" src="JS/html2pdf.bundle.js"></script>
    <script src="html2pdf.bundle.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
</head>

<body>
    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
        <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        <div class="offcanvas-header">
            <div>
                <h5 class="offcanvas-title" id="offcanvasNavbarLabel">Reportes por Generacion</h5>
                <h8 class="offcanvas-title" id="offcanvasNavbarLabel">Si desea ver el reporte especifico de alguno de las siguientes generaciones, seleccione su boton correspodiente</h8>
            </div>  
          
        </div>
        <div class="offcanvas-body">
                <form method="post" action="reporte" class="vertical-form">
                    <input type="submit" value="2020" name="rp2020" class="Boton">
                    <input type="submit" value="2021" name="rp2021" class="Boton">
                    <input type="submit" value="2022" name="rp2022" class="Boton">
                </form>
        </div>
      </div>
      <header>
                
        <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
        <div class="barra">
            <div class="fontdiv">
                <div class="flujo2">
                    <a href="graficasProf.jsp"><button type="button" class="opcn">Gráficas</button></a>
                </div>
                <div class="flujo31">
                    <a href="repor.jsp"><button type="button" class="opcn">Reportes</button></a>
                </div>
            </div>
    </div>
    <form action="Cerrar" method="post">
    <button class="btn btn-secon    dary" type="submit" value="Cerrar Sesión" id="salir">
        <svg xmlns="http://www.w3.org/2000/svg" width="2vw" height="5vh" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z"/>
            <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
          </svg>    
    </button>
</form>
    </header>
    <nav>
        <div class="nav-container">
            <p class="ttl">Reporte General del profesor: <%=nombre%> </p>
            <button class="opcn2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation" onclick="toggleMenu()" id="gnrcn">Generaciones</button>
    </div>
    </nav>
    <br>
    <br>
    <div class="reportes" id="reporte">
    <img class="ipn" src="assets/IPN-Logo.png">
    <img class="cecyt9" src="assets/cecyt-logo.png">

    <center>
        <h3>REPORTE GENERAL DE LOS ALUMNOS DE 4TO SEMESTRE </h3>
        <h3>CENTRO DE ESTUDIOS CIENTIFICOS Y TECNOLÓGICOS</h3>
        <h3>"JUAN DE DIOS BATIZ"</h3>
        <h4>CARRERA: PROGAMACIÓN</h4>
    </center>
    <br>
    <br>
    <br>
    <div class="text1">
        <p>La empresa MSDEV, encargada del desarrollo del sistema Skill-Tech,
            ha recopilado información a través de este sistema sobre los conocimientos de los egresados de
            la carrera de Técnico en Programación del CECyT 9 en las materias de Programación Intermedia
            y Bases de Datos. El propósito de esta recopilación es obtener datos cuantificables
            que faciliten el análisis y respalden la toma de decisiones futuras por parte de la academia de programación.
        </p>
    </div>
    <br>
    <%
    if(tipou.equals("1")){
    if(materia[0].equals("POO") && materia[1]== null){
        rs = stmt1.executeQuery("select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=0 and profesor.usu_id="+idUsuario+"");
        x=0;
        while (rs.next()) {
        nivel = rs.getString("rpo_niv");
        x=x+1;
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
        numEgresados=x;
        total = masomenos + buenas + regular + malos;
        if (buenas != 0) {
            porcentajePOO1 = buenas / total *100;
        }
        if (masomenos != 0) {
            porcentajePOO2 = masomenos / total *100;
        }
        if (regular != 0) {
            porcentajePOO3 =  regular / total *100;
        }
        if (malos != 0) {
            porcentajePOO4 =  malos / total *100;
        }
    %>
    <div class="text2" id="txtbd">
    <label>De una muestra de <span><%= numEgresados%></span> egresados del CECyT de Programacion Intermedia se obtuvieron los siguientes resultados:</label>
    </div>
    <br>
    <div class="text2" id="txt1bd">
        <p class="bold">
            PROGRAMACIÓN INTERMEDIA (PI):  
        </p>
        <label> Avanzado: </label><span><%= porcentajePOO1 %></span>%
        <p> Intermedio: <span><%= porcentajePOO2 %></span>%</p>
        <p> Básico: <span><%= porcentajePOO3 %></span>%</p>
        <p> Mínimo: <span><%= porcentajePOO4 %></span>%</p>
    </div>
    <%
    x=0;
    } else if(materia[0].equals("BD") && materia[1]== null){
        rs3 = stmt1.executeQuery("select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=1 and profesor.usu_id="+idUsuario+"");
        x=0;
        while (rs3.next()) {
        x=x+1;
        nivelBD = rs3.getString("rbd_niv");
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
        numEgresados=x;
        total2 = avanzado + intermedio + basico + min;
        if (avanzado != 0) {
            percentBD1 = avanzado / total2 *100;
        }
        if (intermedio != 0) {
            percentBD2 =intermedio / total2 *100;
        }
        if (basico != 0) {
            percentBD3 = basico / total2 *100;
        }
        if (min != 0) {
            percentBD4 = min / total2 *100;
        }
    %>
    <div class="text2" id="txtbd">
    <label>De una muestra de <span><%= numEgresados%></span> egresados del CECyT de Base de Datos se obtuvieron los siguientes resultados:</label>
    </div>
    <br>
    <div class="text2" id="txt2bd">
        <p class="bold">
            BASES DE DATOS:
        </p>
        <p>
            Avanzado: <span><%= percentBD1 %></span>%
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
    <%
    x=0;
    }else{
    //aqui son los dos
    rs = stmt1.executeQuery("select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=0 and profesor.usu_id="+idUsuario+"");
        while (rs.next()) {
        x=x+1;
        nivel = rs.getString("rpo_niv");
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
        numEgresados=x;
        total = masomenos + buenas + regular + malos;
        if (buenas != 0) {
            porcentajePOO1 = buenas / total *100;
        }
        if (masomenos != 0) {
            porcentajePOO2 = masomenos / total *100;
        }
        if (regular != 0) {
            porcentajePOO3 =  regular / total *100;
        }
        if (malos != 0) {
            porcentajePOO4 =  malos / total *100;
        }
    %>
    <div class="text2" id="txtbd">
    <label>De una muestra de <span><%= numEgresados%></span> egresados del CECyT de la materia de Programacion Intermedia se obtuvieron los siguientes resultados:</label>
    </div>
    <br>
    <div class="text2" id="txt1bd">
        <p class="bold">
            PROGRAMACIÓN INTERMEDIA (PI):  
        </p>
        <label> Avanzado: </label><span><%= porcentajePOO1 %></span>%
        <p> Intermedio: <span><%= porcentajePOO2 %></span>%</p>
        <p> Básico: <span><%= porcentajePOO3 %></span>%</p>
        <p> Mínimo: <span><%= porcentajePOO4 %></span>%</p>
    </div>
    <%
    rs3 = stmt1.executeQuery("select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id inner join profesor on profesor.pro_id=egr_pro.pro_id inner join pro_asi on pro_asi.pro_id=profesor.pro_id where pro_asi.asi_id=1 and profesor.usu_id="+idUsuario+"");
        while (rs3.next()) {
        z=z+1;
        nivelBD = rs3.getString("rbd_niv");
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
        numEgresados2=z;
        total2 = avanzado + intermedio + basico + min;
        if (avanzado != 0) {
            percentBD1 = avanzado / total2 *100;
        }
        if (intermedio != 0) {
            percentBD2 =intermedio / total2 *100;
        }
        if (basico != 0) {
            percentBD3 = basico / total2 *100;
        }
        if (min != 0) {
            percentBD4 = min / total2 *100;
        }
    %>
    <div class="text2" id="txtbd">
    <label>De una muestra de <span><%= numEgresados2%></span> egresados del CECyT de la materia de Base de datos se obtuvieron los siguientes resultados:</label>
    </div>
    <br>
    <div class="text2" id="txt2bd">
        <p class="bold">
            BASES DE DATOS:
        </p>
        <p>
            Avanzado: <span><%= percentBD1 %></span>%
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
    <%
    x=0;
    z=0;
    }
    //aqui va del otro usuario
    }else if(tipou.equals("2")){
    rs = stmt1.executeQuery("select rpo_niv FROM resultadopo");
    while (rs.next()) {
        nivel = rs.getString("rpo_niv");

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
    rs3 = stmt1.executeQuery("select rbd_niv FROM resultadobd");
    while (rs3.next()) {
        nivelBD = rs3.getString("rbd_niv");

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
    rs2 = stmt1.executeQuery("select count(*) as 'egresados' from egresado");
    if (rs2.next()) {
    numEgresados = rs2.getInt("egresados");
    } else {
        //System.out.println("XD");
    }
    total = masomenos + buenas + regular + malos;
    if (buenas != 0) {
        porcentajePOO1 = buenas / total *100;
    }
    if (masomenos != 0) {
        porcentajePOO2 = masomenos / total *100;
    }
    if (regular != 0) {
        porcentajePOO3 =  regular / total *100;
    }
    if (malos != 0) {
        porcentajePOO4 =  malos / total *100;
    }

    total2 = avanzado + intermedio + basico + min;
    if (avanzado != 0) {
        percentBD1 = avanzado / total2 *100;
    }
    if (intermedio != 0) {
        percentBD2 =intermedio / total2 *100;
    }
    if (basico != 0) {
        percentBD3 = basico / total2 *100;
    }
    if (min != 0) {
        percentBD4 = min / total2 *100;
    }
    %> 
    <div class="text2" id="txtbd">
        <label>De una muestra de <span><%= numEgresados %></span> egresados del CECyT se obtuvieron los siguientes resultados:</label>
    </div>
    <br>
    <div class="text2" id="txt1bd">
        <p class="bold">
            PROGRAMACIÓN INTERMEDIA (PI):  
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
            Avanzado: <span><%= percentBD1 %></span>%
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
    <%}%> 
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
</div>
<script>
    function toggleMenu() {
        var menu = document.getElementById("dropdownMenu");
        menu.style.display = (menu.style.display === "block") ? "none" : "block";
    }
</script>
<%
//IMPORTANTE
numEgresados=0;
numEgresados2=0;
total=0;
masomenos = 0;
regular = 0;
malos = 0;
buenas = 0;
avanzado = 0;
intermedio =0;
basico = 0; 
min = 0;
total2=0;
percentBD1=0;
percentBD2=0;
percentBD3=0;
percentBD4=0;
porcentajePOO1=0;
porcentajePOO2=0;
porcentajePOO3=0;
porcentajePOO4=0;
%>
</body>
</html>