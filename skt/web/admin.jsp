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
//onchange="mostrarCodigo()"
%>
    <html lang="es">

    <head>
        <meta charset="utf-8">
        <title>Administrador</title>
        <link rel="stylesheet" href="css/admin2.css">
        <link rel="stylesheet" href="css/estiloadmin.css">
        <link rel="stylesheet" href="css/popup.css">
        <link rel="shortcut icon" href="./assets/logo1.png" />
           <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/Admin1.js"></script>
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
                        <a href="admin.html"><button type="button" class="opcn">Administración</button></a>
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
                <p class="ttl">Creación y deshabilitación de usuarios</p>
            </div>
        </nav>

            <div class="row">
                    <form class="form" action="regAdmin" method="POST">
                        <div class="alincentro"><p class="ins">A continuación llene los siguientes campos para registrar a un nuevo usuario:</p></div>                     
                        <article class="column">
                            <div class="divalform2">
                                <label for="tipousu" class="small-text">Tipo de usuario a crear:</label>
                                <select id="tipousu" name="tipou" class="inputf2" required onchange="mostrarCodigo()">
                                    <option  value="" selected disabled hidden>Selecciona una opción</option>
                                    <option  value="1">Profesor</option>
                                    <option value="2">Jefe de Academia</option>
                                </select>
                            </div>
                            <div class="divalform">
                                <label for="Nombrepr" class="small-text">Nombre del profesor:</label>
                                <input type="text" id="Nombrepr" name="nombrepr" placeholder="Apellido y nombre(s)" class="inputf" required><br>
                                <label for="Email" id="alinearizq" class="small-text">Correo electrónico:</label>
                                <input type="email" id="Email" name="email" placeholder="ejemplo@gmail.com" class="inputf" required><br>
                                <label for="password" id="alinearizq" class="small-text">Contraseña:</label>
                                <input type="password" id="Pasword" name="pasword" placeholder="Contraseña" class="inputf" required>
                                <p>
                                    <label for="password" id="alinearizq" class="small-text">Unidades de aprendizaje:</label><br><br>
                                    <label class="container">
                                    <input type="checkbox" id="product-1-1" name="check" value="0"> POO <span class="checkmark"></span>
                                    </label>
                                    <label class="container">
                                    <input type="checkbox" id="product-1-2" name="check" value="1"> BDR <span class="checkmark"></span>
                                    </label>
                                    <label class="container">
                                    <input type="checkbox" id="product-1-3" name="check" value="2"> Ambas <span class="checkmark"></span>
                                    </label>
                                </p>

                                <div class="footer">
                                <button type="button" onclick="validarFormulario()" class="opcn2">Registrar usuario</button>
                                <button type="reset" class="opcn3">Cancelar</button>
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
                        <button type="submit" class="opcn2" id="centrarbtn">Deshabilitar cuenta</button>
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
                        <button type="submit" class="opcn2" id="centrarbtn">Habilidar cuenta</button>
                        </form>
                        </div>
                    </div>
            </div>
            <button class="chatbot-toggler">
                <span class="material-symbols-rounded"><img src="./assets/fi-rs-headset.png" class="imgayuda"></span>
                <span class="material-symbols-outlined">close</span>
              </button>
              <div class="chatbot">
                <header>
                  <h5>Chatbot</h5>
                  <span class="close-btn material-symbols-outlined">close</span>
                </header>
                <ul class="chatbox">
                  <li class="chat incoming">
                    <span class="material-symbols-outlined">person</span>
                    <p>Hola! 👋<br>¿Cómo puedo ayudarte?</p>
                  </li>
                </ul>
                <div class="chat-input">
                  <textarea placeholder="Introduce un mensaje..." spellcheck="false" required></textarea>
                  <span id="send-btn" class="material-symbols-rounded">send</span>
                </div>
              </div>
<script>
    function mostrarCodigo() {
        var selectElement = document.getElementById("tipousu");
        var codigoDiv = document.getElementById("codigo_oculto");
        
        if (selectElement.value == "1") { // Si la opción seleccionada es "Profesor"
            codigoDiv.style.display = "block"; // Mostrar el código
        } else {
            codigoDiv.style.display = "none"; // Ocultar el código
        }
    }
</script>
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
