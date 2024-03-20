<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.*" %>
<%@page import="javax.servlet.http.HttpSession"%>
<% HttpSession sesion = request.getSession(true); %>
<%String tipou = (String) sesion.getAttribute("tipou");%>

<%if(sesion.isNew() || sesion==null)
    {
    response.sendRedirect("index.html");
    return;
    }
%>
<%
   if(tipou == null||tipou.equals("0")||tipou.equals("3")|| tipou.equals("2")){
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
stmt1 = con.createStatement();

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
    numEgresados = rs2.getString("egresados");
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
        <p class="h21">Skill-tech</p>
        <div  id="alinearder"><form action="Cerrar" method="post"><input type="submit" value="Cerrar Sesión" class="BotonCe"></form></div>
    </header>
   <div style="width: 100%; height: 100%; padding-bottom: 13px; padding-left: 24px; padding-right: 808px; background: white; box-shadow: 0px -3px 0px #1589EE inset; justify-content: flex-start; align-items: center; display: inline-flex">
            <div style="justify-content: flex-start; align-items: center; gap: 24px; display: inline-flex">
                <div class="fontdiv">
                    <div class="flujo">
                        <a href="graficas.jsp"><img class="imgflujo2" src="./assets/grafico-circular (1).png"><P class="txtflujo2">Gráficas</P></a>
                    </div>
                 <div class="flujo21">
                        <a href="bita.jsp"><img class="imgflujo3" src="./assets/archivo.png"><P class="txtflujo3">Bitacora</P></a>
                    </div>
                    <div class="flujo31">
                        <a href="repor.jsp"><img class="imgflujo4" src="./assets/reporte.png"><P class="txtflujo4">Reportes</P></a>
                    </div>
                </div>
            </div>
        </div>
    <nav>
        <div class="nav-container">
            <div class="fontdiv"><h2>Reporte General</h2></div>
            <button class="navbar-toggler" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar" aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
                <div class="menu-btn" onclick="toggleMenu()">☰</div>
              </button>
    </div>
    </nav>
    <br>
    <br>
    <div class="reportes" id="reporte">
    <img class="ipn" src="assets/IPN-Logo.png">
    <img class="cecyt9" src="assets/cecyt-logo.png">

    <center>
        <h3>REPORTE GENERAL DE EGRESADOS </h3>
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
            la carrera de Técnico en Programación del CECyT 9 en las materias de Programación Orientada
            a Objetos y Bases de Datos. El propósito de esta recopilación es obtener datos cuantificables
            que faciliten el análisis y respalden la toma de decisiones futuras por parte de la academia de programación.
        </p>
    </div>

    <br>
    <div class="text2" id="txtbd">
        <label>De una muestra de <span><%= numEgresados %></span> egresados del CECyT se obtuvieron los siguientes resultados:<label>

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
</body>

</html>