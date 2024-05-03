<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.Soporte" %>
<%@page import="javax.servlet.http.HttpSession"%>
<% HttpSession sesion = request.getSession(true); %>
<%String tipou = (String) sesion.getAttribute("tipou");%>
<% if(sesion.isNew() || sesion==null){
response.sendRedirect("index.html");
return;
}
%>
<%if (tipou == null || (tipou.equals("0") || tipou.equals("1") || tipou.equals("2"))) {
  response.sendRedirect("index.html");
  return ;
}
%>
<!DOCTYPE html>
<%!
Soporte pal;
Connection con;
Statement stmt;
ResultSet rs, rs2,rs3,rs4;
int x=0,y=0;
int reg=0;
int reg2=0;
%>
<%
pal =new Soporte();
con = pal.getConnection();
stmt = con.createStatement();

rs = stmt.executeQuery("select count(*) as Registros from incidencia");
while(rs.next()){
reg=rs.getInt("Registros");
}
int id[]=new int[reg];
String email[] = new String[reg];
String desc[] = new String[reg];
String fch[] = new String[reg];
String tipo[] = new String[reg];
String est[] = new String[reg];
int est2[] = new int[reg];
String prio[] = new String[reg];
x=0;
rs2 = stmt.executeQuery("select inc_id, inc_email, inc_descripcion, inc_fch, estado.est_estado, incidencia.est_id, tincidencia.tin_nombre, prioridad.pri_prioridad from incidencia inner join estado on estado.est_id=incidencia.est_id inner join tincidencia on tincidencia.tin_id=incidencia.tin_id inner join prioridad on prioridad.pri_id=tincidencia.pri_id where 0<incidencia.est_id<3 order by inc_id asc");
while(rs2.next()){
id[x]=rs2.getInt("inc_id");
email[x] =rs2.getString("inc_email");
desc[x]=rs2.getString("inc_descripcion");
fch[x]=rs2.getString("inc_fch");
est[x] = rs2.getString("est_estado");
est2[x] = rs2.getInt("est_id");
tipo[x]=rs2.getString("tin_nombre");
prio[x]=rs2.getString("pri_prioridad");
x =1+x;
}x=0;

rs3 = stmt.executeQuery("select count(*) Registrop from programador");
while(rs3.next()){
reg2 = rs3.getInt("Registrop");
}
String pronombre[] = new String[reg2];
int proid[] = new int[reg2];
rs3 = stmt.executeQuery("select pro_id, pro_nombre from programador");
y=0;
while(rs3.next()){
proid[y] = rs3.getInt("pro_id");
pronombre[y] = rs3.getString("pro_nombre");
y=y+1;
}y=0;
rs.close();
rs2.close();
rs3.close();
%>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Administrador</title>
    <link rel="stylesheet" href="css/admin2.css">
    <link rel="stylesheet" href="css/estiloadmin.css">
    <title>Incidencias</title>
    <link rel="stylesheet" href="tabla.css">
    <link rel="stylesheet" href="css/popup.css">
    <link rel="shortcut icon" href="./assets/logo1.png" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Rounded:opsz,wght,FILL,GRAD@48,400,1,0" />
</head>
<body>
    <header>
    <h1 class="imglogo"><img src="./assets/logo1.png" class="logo"/></h1>
    <div class="barra">
        <div class="fontdiv">
            <div class="flujo2">
                <a href="gradmin.html"><button type="button" class="opcn">Gráficas</button></a>
            </div>
            <div class="flujo31">
                <a href="admin.jsp"><button type="button" class="opcn">Administración</button></a>
            </div>
            <div class="flujo5">
                <a href="incidencia.jsp"><button type="button" class="opcn">Incidencias</button></a>
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
    <br>
    <center>
    <table>
        <tr>
            <th>Identificador</th>
            <th>Fecha ocurrida</th>
            <th>Corre Electrónico</th>
            <th>Incidencia</th>
            <th>Clasificación</th>
            <th>Prioridad</th>
            <th>Estado</th>
            <th>Asignación</th>
        </tr>
        <%for(int i=0; i<reg; i++){%>
        <tr>
            <td>I<%=id[i]%></td>
            <td><%=fch[i]%></td>
            <td><%=email[i]%></td>
            <td><%=desc[i]%></td>
            <td><%=tipo[i]%></td>
            <td><%=prio[i]%></td>
            <td><%=est[i]%></td>
            <td>
            <%if( est2[i]>0 && est2[i]<2){%>
            <form class="inc<%=i%>" action="editsop" method="post">
            <div style="display: none">
            <input type="text" name="idinc" value="<%=id[i]%>" disable>
            <input type="text" name="fchinc" value="<%=fch[i]%>" disable>
            <input type="text" name="emailinc" value="<%=email[i]%>" disable>
            <input type="text" name="descinc" value="<%=desc[i]%>" disable>
            <input type="text" name="tipoinc" value="<%=tipo[i]%>" disable>
            <input type="text" name="prioinc" value="<%=prio[i]%>" disable>
            <input type="text" name="estinc" value="<%=est[i]%>" disable>
            </div>
            <select name="programinc" id="program">
                <%if(reg2==0){%>
                <option value="" selected disabled hidden>Sin programadores registrados (WTF)</option>
                <%}else if(reg2!=0){%>
                <option value="" selected disabled hidden>Selecciona una opción</option>
                <%for(int r=0; r<reg2; r++){%>
                <option value="<%=proid[r]%>"><%=pronombre[r]%></option>
                <%}%>
                <%}%>
            </select>
            <button type="submit">Enviar</button>
            </form>  
            <%}else{
            String nombrepro="";
            rs4=stmt.executeQuery("select programador.pro_nombre from programador inner join pro_inc on programador.pro_id=pro_inc.pro_id where pro_inc.inc_id="+id[i]+"");
            while(rs4.next()){
            nombrepro = rs4.getString("pro_nombre");
            }rs4.close();
            %>
            <%=nombrepro%>
            <%}
            }
            stmt.close();
            %>
            </td>
        </tr>
    </table>
    </center>
</body>
</html>