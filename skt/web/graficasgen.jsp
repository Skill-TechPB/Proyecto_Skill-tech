<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.*" %>
<%@page import="javax.servlet.http.HttpSession"%>
<% HttpSession sesion = request.getSession(true); %>
<%
    if(sesion.isNew() || sesion == null) {
        response.sendRedirect("index.html");
        return;
    }
%>
<%String x = (String) sesion.getAttribute("generacion");%>
<%String tipou = (String) sesion.getAttribute("tipou");%>


<%
    if (tipou == null || tipou.equals("0") || tipou.equals("4")) {
    response.sendRedirect("index.html");
    return;
}
%>

<!DOCTYPE html>
<%
    Conexion pal = new Conexion();
    Connection con = pal.getConnection();
    Statement stmt = con.createStatement();
    ResultSet rs, rs2, rs3, rs4;
    
    String nivel, nivel2, respo, resbd;
    int pooavz = 0, pooint = 0, poomed = 0, poomin = 0;
    int bdavz = 0, bdint = 0, bdmed = 0, bdmin = 0;
    int arraypo[] = new int[10];
    int arraybd[] = new int[10];
    int arraypoi[] = new int[10];
    int arraybdi[] = new int[10];
    
    
    rs = stmt.executeQuery("select rpo_niv from resultadopo inner join egresado on egresado.egr_id = resultadopo.egr_id where egr_fch = '"+x+"'");
    while (rs.next()) {
        nivel = rs.getString("rpo_niv");
        if(nivel.equals("3")) {
            pooavz++;
        } else if(nivel.equals("2")) {
            pooint++;
        } else if(nivel.equals("1")) {
            poomed++;
        } else if(nivel.equals("0")) {
            poomin++;
        }
    }
   rs2 = stmt.executeQuery("select rbd_niv FROM resultadobd inner join egresado on egresado.egr_id = resultadobd.egr_id where egr_fch = '"+x+"'");
    while (rs2.next()) {
        nivel2 = rs2.getString("rbd_niv");
        if(nivel2.equals("3")) {
            bdavz++;
        } else if(nivel2.equals("2")) {
            bdint++;
        } else if(nivel2.equals("1")) {
            bdmed++;
        } else if(nivel2.equals("0")) {
            bdmin++;
        }
    }
    rs3 = stmt.executeQuery("select rpo_resp from resultadopo inner join egresado on egresado.egr_id = resultadopo.egr_id where egr_fch = '"+x+"'");
    while (rs3.next()) {
    respo = rs3.getString("rpo_resp");
    String[] valores = respo.split(" ");
    for (int i = 0; i<valores.length; i++) {
        if(valores[i].equals("1")){
        arraypo[i]++;
        }else if(valores[i].equals("0")){
        arraypoi[i]++;
        }
        }  
    }
    rs4 = stmt.executeQuery("select rbd_resp FROM resultadobd inner join egresado on egresado.egr_id = resultadobd.egr_id where egr_fch = '"+x+"'");
        while (rs4.next()) {
        resbd = rs4.getString("rbd_resp");
        String[] valores = resbd.split(" ");
        for (int i = 0; i<valores.length; i++) {
            if(valores[i].equals("1")){
            arraybd[i]++;
            }
            if(valores[i].equals("0")){
            arraybdi[i]++;
            }
            }  
        }
%>


<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Grafica de POO</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/Chart.min.css">
    <link rel="stylesheet" href="css/graf.css">
    <link rel="stylesheet" href="css/grafivasr2.css">
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"></script>
    <link rel="shortcut icon" href="./assets/logo1.png" />
</head>
<body>
    <header>
        <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
        <p class="h21">Skill-tech</p>
        <div class="Boton" id="alinearder"><form action="Cerrar" method="post"><input type="submit" value="Cerrar Sesión" class="BotonCe"></form></div>
    </header>
 
    <nav>
        <div class="nav-container">
                <div class="fontdiv"><h2>Graficas por Generacion</h2></div>
        </div>
    </nav>
    <div class="alincentro"><h4 id='borde'>A continuacion se muestran las graficas de los egresados evaluados en las areas de programacion y bases de datos:</h4></div>
    <br>
    <br>
    <section class="bodyg" id="1">
        <div class="a">
            <div class="titulo">POO</div>
            <div id="graficaBD" class="grafica-container">
            <canvas class="grafica"></canvas>
        </div>
            <div class="layoutgr"> <div class="alineatext"><br><br><img src="assets/rectangulo avanzado.jpg" class="alinearrec"> Avanzado <br><br> <img src="assets/rectangulo intermedio.png" class="alinearrec">Intermedio <br><br> <img src="assets/rectangulo basico.png" class="alinearrec">Basico <br><br> <img src="assets/rectangulo minimo.png" class="alinearrec">Minimo </div></div>
            <canvas id="grafica"></canvas>
        </div>
        <div class="a">
            <div class="titulo">BD</div>
             <div id="graficaPOO" class="grafica-container">
            <canvas class="grafica"></canvas>
        </div>
            <div class="layoutgr"> <div class="alineatext"><br><br><img src="assets/rectangulo avanzado.jpg" class="alinearrec"> Avanzado <br><br> <img src="assets/rectangulo intermedio.png" class="alinearrec">Intermedio <br><br> <img src="assets/rectangulo basico.png" class="alinearrec">Basico <br><br> <img src="assets/rectangulo minimo.png" class="alinearrec">Minimo </div></div>
            <canvas id="pol"></canvas>
        </div>
    </section>
    <br>
    <br>
    <section class="bodyg2" id="2">
        <div class="po1" id="a">
            <div class="titulo">Preguntas POO</div>
            <canvas id="grafica" class="bar"></canvas>
        </div>

        <div class="bd1" id="a">
            <div class="titulo">Preguntas BD</div>
        <canvas id="grafica" class="bar2"></canvas>
        </div>
    </section>
    <br>
    <br>
	<footer id="alinderecha">
      <a href="graficas.jsp"><div class="Botona">Regresar</div></a>
    </footer>

 
<script>
        var NivAvanz = "<%=pooavz%>";
        var Nivint = "<%=pooint%>";
        var Nivmed = "<%=poomed%>";
        var Nivbas = "<%=poomin%>";

        var NivAvanz2 = "<%=bdavz%>";
        var Nivint2 = "<%=bdint%>";
        var Nivmed2 = "<%=bdmed%>";
        var Nivbas2 = "<%=bdmin%>";

        const xd1 = parseInt(NivAvanz);
        const xd2 = parseInt(Nivint);
        const xd3 = parseInt(Nivmed);
        const xd4 = parseInt(Nivbas);

        const xd5 = parseInt(NivAvanz2);
        const xd6 = parseInt(Nivint2);
        const xd7 = parseInt(Nivmed2);
        const xd8 = parseInt(Nivbas2);

        const labels = ['Avanzado', 'Intermedio', 'Básico', 'Mínimo'];
        const colors = ['#20516F', '#585bb2', '#56D0FC', '#C23934'];

        const graphPOO = document.querySelector("#graficaBD .grafica");
        const graphBD = document.querySelector("#graficaPOO .grafica");

        const dataPOO = {
            datasets: [{
                data: [xd1, xd2, xd3, xd4],
                backgroundColor: colors
            }]
        };

        const dataBD = {
            datasets: [{
                data: [xd5, xd6, xd7, xd8],
                backgroundColor: colors
            }]
        };

        const configPOO = {
            type: 'pie',
            data: dataPOO
        };

        const configBD = {
            type: 'pie',
            data: dataBD
        };

        new Chart(graphPOO, configPOO);
        new Chart(graphBD, configBD);
    </script>
    
    <script>
        var ppo1 = "<%=arraypo[0] %>";
        var ppo2 = "<%=arraypo[1] %>";
        var ppo3 = "<%=arraypo[2] %>";
        var ppo4 = "<%=arraypo[3] %>";
        var ppo5 = "<%=arraypo[4] %>";
        var ppo6 = "<%=arraypo[5] %>";
        var ppo7 = "<%=arraypo[6] %>";
        var ppo8 = "<%=arraypo[7] %>";
        var ppo9 = "<%=arraypo[8] %>";
        var ppo10 = "<%=arraypo[9] %>";
        
        var ppoi1 = "<%=arraypoi[0] %>";
        var ppoi2 = "<%=arraypoi[1] %>";
        var ppoi3 = "<%=arraypoi[2] %>";
        var ppoi4 = "<%=arraypoi[3] %>";
        var ppoi5 = "<%=arraypoi[4] %>";
        var ppoi6 = "<%=arraypoi[5] %>";
        var ppoi7 = "<%=arraypoi[6] %>";
        var ppoi8 = "<%=arraypoi[7] %>";
        var ppoi9 = "<%=arraypoi[8] %>";
        var ppoi10 = "<%=arraypoi[9] %>";
        
        // Obtener una referencia al elemento canvas del DOM
        const $grafica = document.querySelector(".bar");
        const etiquetas = ["1","2","3","4","5","6","7","8","9","10"];
        const datosVentas2020 = {
            label: "Aciertos",
            data: [ppo1,ppo2,ppo3,ppo4,ppo5,ppo6,ppo7,ppo8,ppo9,ppo10], // La data es un arreglo que debe tener la misma cantidad de valores que la cantidad de etiquetas
            backgroundColor: "#008000", // Color de fondo
            borderColor: "#008000", // Color del borde
            borderWidth: 1// Ancho del borde
        };
        const datosVentas2021 = {
            label: "Errores",
            data: [ppoi1,ppoi2,ppoi3,ppoi4,ppoi5,ppoi6,ppoi7,ppoi8,ppoi9,ppoi10], // La data es un arreglo que debe tener la misma cantidad de valores que la cantidad de etiquetas
            backgroundColor:  "#cc0605",// Color de fondo
            borderColor: "#cc0605",// Color del borde
            borderWidth: 1// Ancho del borde
        };

        new Chart($grafica, {
            type: 'bar',// Tipo de grÃ¡fica
            data: {
                labels: etiquetas,
                datasets: [
                    datosVentas2020,
                    datosVentas2021
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }],
                },
            }
        });
    </script>

<script>
        var pbd1 = "<%=arraybd[0] %>";
        var pbd2 = "<%=arraybd[1] %>";
        var pbd3 = "<%=arraybd[2] %>";
        var pbd4 = "<%=arraybd[3] %>";
        var pbd5 = "<%=arraybd[4] %>";
        var pbd6 = "<%=arraybd[5] %>";
        var pbd7 = "<%=arraybd[6] %>";
        var pbd8 = "<%=arraybd[7] %>";
        var pbd9 = "<%=arraybd[8] %>";
        var pbd10 = "<%=arraybd[9] %>";
        
        var pbdi1 = "<%=arraybdi[0] %>";
        var pbdi2 = "<%=arraybdi[1] %>";
        var pbdi3 = "<%=arraybdi[2] %>";
        var pbdi4 = "<%=arraybdi[3] %>";
        var pbdi5 = "<%=arraybdi[4] %>";
        var pbdi6 = "<%=arraybdi[5] %>";
        var pbdi7 = "<%=arraybdi[6] %>";
        var pbdi8 = "<%=arraybdi[7] %>";
        var pbdi9 = "<%=arraybdi[8] %>";
        var pbdi10 = "<%=arraybdi[9] %>";
        
        // Obtener una referencia al elemento canvas del DOM
        const $grafica2 = document.querySelector(".bar2");
        // Las etiquetas son las que van en el eje X. 
        const etiquetas2 = ["1","2","3","4","5","6","7","8","9","10"];
        // Podemos tener varios conjuntos de datos
        const datosVentas20201 = {
            label: "Aciertos",
            data: [pbd1,pbd2,pbd3,pbd4,pbd5,pbd6,pbd7,pbd8,pbd9,pbd10], // La data es un arreglo que debe tener la misma cantidad de valores que la cantidad de etiquetas
            backgroundColor: "#008000", // Color de fondo
            borderColor: "#008000", // Color del borde
            borderWidth: 1// Ancho del borde
        };
        const datosVentas20211 = {
            label: "Errores",
            data: [pbdi1,pbdi2,pbdi3,pbdi4,pbdi5,pbdi6,pbdi7,pbdi8,pbdi9,pbdi10], // La data es un arreglo que debe tener la misma cantidad de valores que la cantidad de etiquetas
            backgroundColor:  "#cc0605",// Color de fondo
            borderColor: "#cc0605",// Color del borde
            borderWidth: 1// Ancho del borde
        };

        new Chart($grafica2, {
            type: 'bar',// Tipo de grÃ¡fica
            data: {
                labels: etiquetas2,
                datasets: [
                    datosVentas20201,
                    datosVentas20211
                ]
            },
            options: {
                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }],
                },
            }
        });
    </script>
    </body>
</html>