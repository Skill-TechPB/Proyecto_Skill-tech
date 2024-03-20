    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="Conexion.Conexion" %>
    <%@page import="java.io.*" %>
    <%@page import="javax.servlet.http.HttpSession"%>
    <% HttpSession sesion = request.getSession(true); %>
    <%String tipou = (String) sesion.getAttribute("tipou");%>

    <% if(sesion.isNew() || sesion==null)
        {
        response.sendRedirect("index.html");
        return;
        }
    %>
    <%
          if (tipou == null || tipou.equals("0") || tipou.equals("4") || tipou.equals("1")) {
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
    String filform="", filfch="";
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
    //Preparacion del statment
    filform = request.getParameter("filform");
    filfch = request.getParameter("filfch");
    System.out.println(filform+filfch);
    if(filform==null){
    filform="1";
    }
    if(filfch==null){
    filfch="desc";
    }
    //introduccion de los registros de la bita
    rs2=stmt.executeQuery("select bitacora.bit_fchmod, profesor.pro_nombre, formulario.for_nombre, bitacora.elf_id,bitacora.bit_indice, bitacora.bit_origen, bitacora.bit_cambio from bitacora inner join profesor on profesor.pro_id=bitacora.pro_id inner join formulario on formulario.for_id=bitacora.for_id where bitacora.for_id ="+filform+" order by bitacora.bit_fchmod "+filfch+"");
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
            <title>Bitacora</title>
        </head>
        <body>
            <header>
                <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
                <p class="h21">Skill-tech</p>
                <div class="Boton" id="alinearder"><form action="Cerrar" method="post"><input type="submit" value="Cerrar Sesión" class="Botona"></form></div>
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
                        <div class="fontdiv"><h2>Bitácora</h2></div>
                </div>
            </nav>
            
            <div class="classform2">
                <form class="form" method="POST">
                <label for="tipousu" class="small-text">Filtrar por formulario: </label>
                <select id="tipousu" name="filform" class="inputf2" required>
                    <option value="1">Programaci&oacuten Intermedia</option>
                    <option value="2">Base de datos</option>
                </select>
                <br>
                <label for="tipousu" class="small-text">Filtrar por fecha: </label>
                <select id="tipousu" name="filfch" class="inputf2" required>
                    <option value="desc">M&aacutes reciente</option>
                    <option value="asc">Menos reciente</option>
                </select>
                <button type="button" onclick="" class="Botona">Registrar usuario</button>
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
            <td colspan="6"><h4>Sin cambios por reportar, vuelva mas tarde :)</h4></td>
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
            <%}%>
            <%}%>
            </table>
        </body>
    </html>