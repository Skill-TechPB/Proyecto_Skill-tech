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
        <%String tipou = (String) sesion.getAttribute("tipou");%>
        <%int idUsuario = (int) sesion.getAttribute("usu_id");%>
        <%
        if (tipou == null || tipou.equals("0") || tipou.equals("3")) {
        response.sendRedirect("index.html");
        return;
        }
        %>
        <%! 
            int pooavz = 0, pooint = 0, poomed = 0, poomin = 0;
            int bdavz = 0, bdint = 0, bdmed = 0, bdmin = 0;
            int z=0;
            String nivel, nivel2,nombre;
            String materia[] = new String[2];
        %>
        <!DOCTYPE html>
        <%
            Conexion pal = new Conexion();
            int profeID=0;
            Connection con = pal.getConnection();
            Statement stmt = con.createStatement();
            ResultSet ip = stmt.executeQuery("select profesor.pro_id, profesor.pro_nombre, asignatura.asi_nombre from asignatura inner join pro_asi on pro_asi.asi_id=asignatura.asi_id inner join profesor on profesor.pro_id=pro_asi.pro_id where profesor.usu_id="+idUsuario+"");
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
            <title>Graficas</title>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/Chart.min.css">
            <link rel="stylesheet" href="css/graf.css">
            <link rel="stylesheet" href="css/grafivasr.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX  6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
            <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.8.0/chart.min.js"></script>
            <link rel="shortcut icon" href="./assets/logo1.png" />
        </head>
        <body>
            <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-scrollable">
                    <div class="modal-content">
                        <div class="modal-header">
                        <h1 class="modal-title fs-5" id="staticBackdropLabel">Niveles y su Cálculo</h1>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                        Para poder asignar un nivel a los conocimientos de los egresados, con base a los resultados obtenidos en los formularios respondidos, seguimos la siguiente escala: <br> <br>Nivel avanzado 80% de aciertos o superior <br> <br>Nivel intermedio menor a 80% y mayor a 60% <br><br>Nivel básico menor a 60% y mayor a 40%  <br><br>Nivel mínimo menor a 40% <br><br>Esta escala aplica para ambos formularios, el porcentaje se obtendrá mediante la suma del valor de todos los aciertos que obtuvo dividido entre la suma total de los valores de los aciertos del examen y el resultado se multiplicará por 100.
                        </div>
                        <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        </div>
                    </div>
                </div>
            </div>
            <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasRight" aria-labelledby="offcanvasRightLabel">
                <div class="offcanvas-header">
                  <h5 class="offcanvas-title" id="offcanvasRightLabel">Aquí podrá encontrar las gráficas de las generaciones disponibles dentro del sistema</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>
                <div class="offcanvas-body">
                    <form method="POST" action="gen">
                        <a><input class="opcn3" type="submit" value="2020" name="gene"></a>      
                        <a><input class="opcn3" type="submit" value="2021" name="gene1"></a>
                        <a><input class="opcn3" type="submit" value="2022" name="gene2"></a>
                    </form>
                </div>
              </div>

            <header>
                
                <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
                <div class="barra">
                    <div class="fontdiv">
                        <%if(tipou.equals("1") ){%>
                        
                        <div class="flujo2">
                            <a href="graficas.jsp"><button type="button" class="opcn">Gráficas</button></a>
                        </div>
                        <div class="flujo31">
                            <a href="repor.jsp"><button type="button" class="opcn">Reportes</button></a>
                        </div>
                        <%}else if(tipou.equals("2")){%>            
                        <div class="flujo21">
                            <a href="graficas.jsp"><button type="button" class="opcn">Gráficas</button></a>
                        </div>
                        <div class="flujo3">
                            <a href="Editform.jsp"><button class="opla" type="button">Ed.Formularios</button></a>
                        </div>  
                        <div class="flujo4">
                            <a href="bita.jsp"><button class="opcn" type="button">Bitacora</button></a>
                        </div>
                        <%}%>
                    </div>
            </div>
            <form action="Cerrar" method="post">
            <button class="btn btn-secondary" type="submit" value="Cerrar Sesión" id="salir">
                <svg xmlns="http://www.w3.org/2000/svg" width="2vw" height="5vh" fill="currentColor" class="bi bi-box-arrow-right" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M10 12.5a.5.5 0 0 1-.5.5h-8a.5.5 0 0 1-.5-.5v-9a.5.5 0 0 1 .5-.5h8a.5.5 0 0 1 .5.5v2a.5.5 0 0 0 1 0v-2A1.5 1.5 0 0 0 9.5 2h-8A1.5 1.5 0 0 0 0 3.5v9A1.5 1.5 0 0 0 1.5 14h8a1.5 1.5 0 0 0 1.5-1.5v-2a.5.5 0 0 0-1 0z"/>
                    <path fill-rule="evenodd" d="M15.854 8.354a.5.5 0 0 0 0-.708l-3-3a.5.5 0 0 0-.708.708L14.293 7.5H5.5a.5.5 0 0 0 0 1h8.793l-2.147 2.146a.5.5 0 0 0 .708.708z"/>
                  </svg>    
            </button>
        </form>
            </header>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop" id="myInput">
                ?
                </button>
            <nav>
               <div class="nav-container">
                    <%if(tipou.equals("1") ){%>
                        <p class="ttl">Graficas Generales del profesor:</p>
                        <p class="ttl2"><%=nombre%></p>
                        <button class="opcn2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight" id="gnrcn">Generaciones</button>
                    <%}else if(tipou.equals("2")){%>
                    <p class="ttlo">Graficas Generales</p>
                    <p class="ttlo2">de los Profesores</p>
                    <button class="opn2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasRight" aria-controls="offcanvasRight" id="gnrcn">Generaciones</button>
                    <%}%>
                </div>
            </nav>
            <div class="alincentro"><p class="ins">A continuación se muestran las gráficas de los egresados evaluados en las areas de programación y bases de datos:</p></div>
            <section class="bodyg">
                <%if(materia[0].equals("POO") && materia[1]== null){
                ResultSet rs = stmt.executeQuery("select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id where egr_pro.pro_id="+profeID+"");
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
                }%>
                <div class="a">
                <div class="titulo">Programación Intermedia</div>
                    <div id="graficaPOO" class="grafica-container">
                    <canvas class="grafica"></canvas>
                </div>
                <div class="layougr">
                    <div class="conti" id="cnt">
                        <img src="assets/recavanzado.jpg" class="alinearrec">
                        <p class="nvl"> Avanzado </p>
                    </div>
                    <div class="conti2">
                        <img src="assets/recintermedio.jpg" class="alinearrec">
                        <p class="nvl">Intermedio </p>
                    </div>
                    <div class="conti3">
                        <img src="assets/recbasico.jpg" class="alinearrec">
                        <p class="nvl">Basico</p>
                    </div>
                    <div class="conti4">
                        <img src="assets/recminimo.jpg" class="alinearrec">
                        <p class="nvl">Minimo</p>
                    </div>
                </div>
                </div>
                <%} else if(materia[0].equals("BD") && materia[1]== null){
                ResultSet rs2 = stmt.executeQuery("select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id where egr_pro.pro_id="+profeID+"");
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
                }%>
                <div class="a">
                <div class="titulo">Bases de Datos</div>
                    <div id="graficaBD" class="grafica-container">
                    <canvas class="grafica"></canvas>
                </div>
                <div class="layougr">
                    <div class="conti" id="cnt">
                        <img src="assets/recavanzado.jpg" class="alinearrec">
                        <p class="nvl"> Avanzado </p>
                    </div>
                    <div class="conti2">
                        <img src="assets/recintermedio.jpg" class="alinearrec">
                        <p class="nvl">Intermedio </p>
                    </div>
                    <div class="conti3">
                        <img src="assets/recbasico.jpg" class="alinearrec">
                        <p class="nvl">Basico</p>
                    </div>
                    <div class="conti4">
                        <img src="assets/recminimo.jpg" class="alinearrec">
                        <p class="nvl">Minimo</p>
                    </div>
                </div>
                </div>
                <%} else {
                ResultSet rs = stmt.executeQuery("select rpo_niv from resultadopo inner join egresado on egresado.egr_id=resultadopo.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id where egr_pro.pro_id="+profeID+"");
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
                ResultSet rs2 = stmt.executeQuery("select rbd_niv from resultadobd inner join egresado on egresado.egr_id=resultadobd.egr_id inner join egr_pro on egr_pro.egr_id=egresado.egr_id where egr_pro.pro_id="+profeID+"");
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
                    }}%>
                <div class="a">
                <div class="titulo">Programación Intermedia</div>
                    <div id="graficaPOO" class="grafica-container">
                    <canvas class="grafica"></canvas>
                </div>
                <div class="layougr">
                    <div class="conti" id="cnt">
                        <img src="assets/recavanzado.jpg" class="alinearrec">
                        <p class="nvl"> Avanzado </p>
                    </div>
                    <div class="conti2">
                        <img src="assets/recintermedio.jpg" class="alinearrec">
                        <p class="nvl">Intermedio </p>
                    </div>
                    <div class="conti3">
                        <img src="assets/recbasico.jpg" class="alinearrec">
                        <p class="nvl">Basico</p>
                    </div>
                    <div class="conti4">
                        <img src="assets/recminimo.jpg" class="alinearrec">
                        <p class="nvl">Minimo</p>
                    </div>
                </div>
                </div>

                <div class="a">
                <div class="titulo">Bases de Datos</div>
                    <div id="graficaBD" class="grafica-container">
                    <canvas class="grafica"></canvas>
                </div>
                <div class="layougr">
                    <div class="conti" id="cnt">
                        <img src="assets/recavanzado.jpg" class="alinearrec">
                        <p class="nvl"> Avanzado </p>
                    </div>
                    <div class="conti2">
                        <img src="assets/recintermedio.jpg" class="alinearrec">
                        <p class="nvl">Intermedio </p>
                    </div>
                    <div class="conti3">
                        <img src="assets/recbasico.jpg" class="alinearrec">
                        <p class="nvl">Basico</p>
                    </div>
                    <div class="conti4">
                        <img src="assets/recminimo.jpg" class="alinearrec">
                        <p class="nvl">Minimo</p>
                    </div>
                </div>
                </div>
                <%}%>
        </section>
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
                const colors = ['#3D29F5', '#05ACFF', '#DA82AF', '#91043D'];

                const graphPOO = document.querySelector("#graficaPOO .grafica");
                const graphBD = document.querySelector("#graficaBD .grafica");

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
            const myModal = document.getElementById('staticBackdrop')
            const myInput = document.getElementById('myInput')

            myModal.addEventListener('shown.bs.modal', () => {
            myInput.focus()
            })
            </script>

        </body>
        </html>