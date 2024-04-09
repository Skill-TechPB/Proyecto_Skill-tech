<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.Statement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="Conexion.Conexion" %>
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
  if (tipou == null || (tipou.equals("0") || tipou.equals("1") || tipou.equals("2"))) {
    response.sendRedirect("index.html");
    return ;
}
%>
<!DOCTYPE html>
<%!
Conexion pal, pal2;
Connection con, con2;
Statement stmt, stmt2;
ResultSet rs, rs2,rs3,rs4;
int cont=0;
int reg=0;
int cont2=0;
int reg2=0;
String mensajeselec="";
String mensajeselec2="";
%>
    <html lang="es">

    <head>
        <meta charset="utf-8">
        <title>Administrador</title>
        <link rel="stylesheet" href="css/admin2.css">
        <link rel="shortcut icon" href="./assets/logo1.png" />
           <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/Admin1.js"></script>
    </head>

    <body>

        <header>
            <img src="./assets/logo1.png" class="imglogo" alt="Logo">
                <div class="Boton" id="alinearder"><form action="Cerrar" method="post"><input type="submit" value="Cerrar Sesión" class="BotonCe"></form></div>
            <p class="h21">Skill-tech</p>
        </header>

        <nav>
            <div class="nav-container">
                <a href="#">
                    <div class="fontdiv"><h2 class="h24">Creación y deshabilitación de usuarios</h2></div>
                </a>
            </div>
        </nav>

            <div class="row">
                    <form class="form" action="regAdmin" method="POST">
                        <div class="divins">
                        <h2 class="txtins">A continuación llene los siguientes campos para el registro de un nuevo usuario: </h2>
                        </div>                        <article class="column">
                            <div class="divalform2">
                                <label for="tipousu" class="small-text">Tipo de usuario a crear:</label>
                                <select id="tipousu" name="tipou" class="inputf2" required>
                                    <option value="" selected disabled hidden>Selecciona una opción</option>
                                    <option value="1">Profesor</option>
                                    <option value="2">Jefe de Academia</option>
                                </select>
                            </div>
                        </article>
                        <article class="column">
                            <div class="divalform">
                                <label for="Nombrepr" class="small-text">Nombre del profesor:</label>
                                <input type="text" id="Nombrepr" name="nombrepr" placeholder="Apellido y nombre(s)" class="inputf" required><br>
                                <label for="Email" id="alinearizq" class="small-text">Correo electrónico:</label>
                                <input type="email" id="Email" name="email" placeholder="ejemplo@gmail.com" class="inputf" required><br>
                                <label for="password" id="alinearizq" class="small-text">Contraseña:</label>
                                <input type="password" id="Pasword" name="pasword" placeholder="Contraseña" class="inputf" required>
                                <p>
                                    <label for="password" id="alinearizq" class="small-text">Unidades de aprendizaje:</label><br>
                                    <input type="checkbox" id="product-1-1" name="check" value="0"> POO
                                    <input type="checkbox" id="product-1-2" name="check" value="1"> BDR
                                    <input type="checkbox" id="product-1-3" name="check" value="2"> Ambas
                                </p>

                                <div class="footer">
                                <button type="button" onclick="validarFormulario()" class="Botona">Registrar usuario</button>
                                <button type="reset" class="Botond">Cancelar</button>
                                </div>
                            </div>
                        </article>
                    </form>
                    <div class="sndcolumn">
                         <div class="divalform3">
                        <h2>Seleccione al Profesor que desee deshabilitar: </h2>
                        <form class="form2" action="dropAdmin" method="POST">
                        <select name="delete" class="inputf2">
                            <option value="" selected disabled hidden>Selecciona una opción</option>
                            <%
                            pal = new Conexion();
                            con = pal.getConnection();
                            stmt = con.createStatement();
                            rs = stmt.executeQuery("select count(*) as Registro from profesor inner join usuario on usuario.usu_id=profesor.usu_id where usu_hab=1");
                            if(rs.next()){
                            reg=rs.getInt("Registro");
                            }
                            
                            String[] pronombre= new String[reg];
                            int[] proid= new int[reg];
                            rs2=stmt.executeQuery("select profesor.pro_nombre, profesor.pro_id from  profesor inner join usuario on usuario.usu_hab=1 and usuario.usu_id=profesor.usu_id");
                            cont=0;
                            while(rs2.next()){
                            pronombre[cont]=rs2.getString("pro_nombre");
                            proid[cont]=rs2.getInt("pro_id");
                            cont=cont+1;
                            }
                            cont=0;
                            if(reg==0){
                            %>
                            <option value="" selected disabled hidden>Sin docentes registrados</option>
                            <%
                            } else{
                            for(int i=0; i<reg;i++){
                            %>
                            <option value="<%=proid[i]%>">Docente <%=pronombre[i]%></option>
                            <%}
                            }
                            %>
                        </select>
                        <br>
                        <button type="submit" class="Botonc">Deshabilitar cuenta</button>
                        </form>
                        </div>
                        <div class="divalform4">
                        <h2>Seleccione al Profesor que desee habilitar: </h2>
                        <form class="form2" action="corpAdmin" method="POST">
                        <select name="vivir" class="inputf2">
                            <option value="" selected disabled hidden>Selecciona una opción</option>
                            <%
                            pal2 = new Conexion();
                            con2 = pal2.getConnection();
                            stmt2 = con2.createStatement();
                            rs4 = stmt2.executeQuery("select count(*) as Registro from profesor inner join usuario on usuario.usu_id=profesor.usu_id where usu_hab=0");
                            if(rs4.next()){
                            reg2=rs4.getInt("Registro");
                            }
                            
                            String[] pol= new String[reg2];
                            int[] polid= new int[reg2];
                            rs3=stmt2.executeQuery("select profesor.pro_nombre, profesor.pro_id from  profesor inner join usuario on usuario.usu_hab=0 and usuario.usu_id=profesor.usu_id");
                            cont2=0;
                            while(rs3.next()){
                            pol[cont2]=rs3.getString("pro_nombre");
                            polid[cont2]=rs3.getInt("pro_id");
                            cont2=cont2+1;
                            }
                            cont2=0;
                            if(reg2==0){
                            %>
                            <option value="" selected disabled hidden>Sin docentes por habilitar</option>
                            <%
                            } else{
                            for(int i=0; i<reg2;i++){
                            %>
                            <option value="<%=polid[i]%>">Docente <%=pol[i]%></option>
                            <%}
                            }
                            %>
                        </select>
                        <br>
                        <button type="submit" class="Botonc">Habilidar cuenta</button>
                        </form>
                        </div>
                    </div>
            </div>
            
    </body>
<script>
  const checkboxes = document.querySelectorAll('input[type="checkbox"][name="check"]');
  checkboxes.forEach((checkbox) => {
    checkbox.addEventListener('change', function() {
      if (this.checked) {
        checkboxes.forEach((otherCheckbox) => {
          if (otherCheckbox !== this) {
            otherCheckbox.checked = false;
          }
        });
      }
    });
  });
</script>
    </html>
