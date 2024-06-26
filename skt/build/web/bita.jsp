<%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="Conexion.Conexion" %>
    <%@page import="java.io.*" %>
    <%@page import="javax.servlet.http.HttpSession"%>
    <% HttpSession sesion = request.getSession(true); %>
    <%String tipou = (String) sesion.getAttribute("tipou");%>
    <% if(sesion.isNew() || sesion==null){
    response.sendRedirect("index.html");
    return;
    }
    %>
    <%if (tipou == null || tipou.equals("0") || tipou.equals("3") || tipou.equals("1")) {
    response.sendRedirect("index.html");
    return;
    }
    %>
    <!DOCTYPE html>
    <%!
    Conexion pal;
    Connection con;
    Statement stmt;
    ResultSet rs, rs2;
    int cont=0, reg= 0;
    %>
    <%
    pal = new Conexion();
    con = pal.getConnection();
    stmt = con.createStatement();
    rs=stmt.executeQuery("select count(*) as Registros from bitacora");
    if(rs.next()){
    reg=rs.getInt("Registros");
    }
    //creacion de las listas
    String[] pronombre=new String[reg];
    String[] fecha = new String[reg];
    String[] form = new String[reg];
    int[] tipoele = new int[reg];
    int[] indice = new int[reg];
    String[] origen = new String[reg];
    String[] cambio = new String[reg];

    //introduccion de los registros de la bita
    rs2=stmt.executeQuery("select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id order by bitacora.bit_fchmod");
    while(rs2.next()){
    fecha[cont]=rs2.getString("bit_fchmod");
    pronombre[cont]=rs2.getString("pro_nombre");
    form[cont]=rs2.getString("for_nombre");
    tipoele[cont]=rs2.getInt("elf_id");
    indice[cont]=rs2.getInt("bit_indice");
    origen[cont]=rs2.getString("bit_origen");
    cambio[cont]=rs2.getString("bit_cambio");
    cont=cont+1;
    }
    cont=0;
    %>
    <html>
        <head>
            <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
            <link rel="stylesheet" href="css/bit.css">
            <link rel="shortcut icon" href="./assets/logo1.png" />
            <link rel="stylesheet" href="css/popup.css">
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX  6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
            <title>Bitacora</title>
        </head>
        <body>
            <header>   
                <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
                <div class="barra">
                    <div class="fontdiv">
                        <div class="flujo21">
                            <a href="graficas.jsp"><button type="button" class="opcn">Gráficas</button></a>
                        </div>
                        <div class="flujo3">
                            <a href="Editform.jsp"><button class="opla" type="button">Ed.Formularios</button></a>
                        </div>  
                        <div class="flujo4">
                            <a href="bita.jsp"><button  type="button" id="btc">Bitácora</button></a>
                        </div>
                        <div class="flujo5">
                            <a href="reporteacademia.jsp"><button class="opcn" type="button">Reporte</button></a>
                        </div>
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
            <nav>
                <div class="nav-container">
                    <p class="ttl">Bitácora</p>
                </div>
            </nav>
            <div class="alincentro">
                <p class="ins">A continuación se presentan los cambios realizados en los formularios</p>
            </div>
            <div class="filtros">
                <form class="fil" action="">
                    <input class="inicio" type="date" name="" id="">
                    <input class="final" type="date" name="" id="">
                    <select class="formulario" id="" name="formulario">
                        <option value="" selected>Seleccionar formulario</option>
                    </select>
                    <select class="pregunta" id="" name="pregunta">
                        <option value="" selected>Seleccionar pregunta</option>
                    </select>
                    <label class="lbl">
                        <input type="radio" class="pyr" id="">
                        <p class="polito">Preguntas y respuestas</p>
                    </label>
                    <button class="opcn2">Aplicar</button>
                </form>
            </div>
            <table class="bitacora">
            <tr>
                <th>Fecha de modificación</th>
                <th>Nombre del Docente</th>
                <th>Nombre del formulario</th>
                <th>Elemento editado</th>
                <th>Elemento original</th>
                <th>Nuevo elemento</th>
            </tr>
            <%
            if(reg==0){
            %>
            <tr>
            <td colspan="6"><h4>Sin cambios por reportar, vuelva mas tarde</h4></td>
            </tr>
            <%
                }
            for(int i=0; i<reg;i++){
            %>
            <tr>
                <td><h4><%=fecha[i]%></h4></td>
                <td><h4><%=pronombre[i]%></h4></td>
                <td><h4><%=form[i]%></h4></td>
            <%if(tipoele[i]==1){
            %>
                <td><h4>Pregunta <%=indice[i]%></h4></td>
                <td><h4><%=origen[i]%></h4></td>
                <td><h4><%=cambio[i]%></h4></td>
            </tr>
            <%
            }else if(tipoele[i]==2){
            %>
                <td><h4>Respuesta de la pregunta <%=indice[i]%></h4></td>
                <td><h4><%=origen[i]%></h4></td>
                <td><h4><%=cambio[i]%></h4></td>
            </tr>
            <%}else if(tipoele[i]==3){
            %>
                <td><h4>Respuesta correcta de la pregunta <%=indice[i]%></h4></td>
                <td><h4><%=origen[i]%></h4></td>
                <td><h4><%=cambio[i]%></h4></td>
            </tr>
            <%}else if(tipoele[i]==4){
            %>
                <td><h4>Tematica <%=indice[i]%></h4></td>
                <td><h4><%=origen[i]%></h4></td>
                <td><h4><%=cambio[i]%></h4></td>
            </tr>
            <%}%>
            <%}%>
            </table>
            <%
            con.close();
            stmt.close();
            rs.close();
            rs2.close();
            %>

            <button class="chatbot-toggler">
                <span class="material-symbols-rounded"><img src="./assets/fi-rs-headset.png" class="imgayuda"></span>
                <span class="material-symbols-outlined">close</span>
              </button>
              <div class="chatbot">
                <header>
                  <p class="titchat">Chatbot</p>
                  <span class="close-btn material-symbols-outlined">close</span>
                </header>
                <ul class="chatbox">
                  <li class="chat incoming">
                    <span class="material-symbols-outlined"><img src="assets/usuario.png" class="imgbot"></span>
                    <p>Hola!<br>¿Cómo puedo ayudarte?<br>1-¿Qué diferencia tienen mis gráficas y mis reportes con los de los profesores?<br>2-¿Los cambios realizados a los formularios, en cuánto tiempo se ven reflejados?<br>3-¿Cuántas veces se pueden editar los formularios?<br>4-¿Hay un límite o restricción sobre cuántos elementos de los formularios se pueden modificar?<br>5-¿Otros usuarios pueden acceder a la bitácora?<br>6-Formulario</p>  
                  </li>
                </ul>
                <div class="chat-input">
                  <textarea id="user-input" placeholder="Introduce un mensaje..." spellcheck="false" required></textarea>
                  <span id="send-btn" class="material-symbols-rounded">send</span>
                </div>
              </div>
              <script src="js/chatbotJ.js"></script>
        </body>
    </html>