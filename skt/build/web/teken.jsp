<%@page import="javax.servlet.http.HttpSession"%>
<% HttpSession sesion = request.getSession(true); %>
<%int idUsuario = (int) sesion.getAttribute("usu_id");%>
<%String anio= (String) sesion.getAttribute("anioegreso");%>
<%String tipou = (String) sesion.getAttribute("tipou");%>

<% if(sesion.isNew() || sesion==null)
    {
    response.sendRedirect("index.html");
    return;
    }
%>
<%
   if(tipou.equals("3")){
   response.sendRedirect("index.html");
   return;
    }
%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>Inicio de sesion</title>
    <link rel="shortcut icon" href="./assets/logo1.png" />
    <link rel="stylesheet" href="./css/token.css" />
       <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/token.js"></script>
  </head>
  <body>

    <header>
        <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
    </header>
    <nav>
        <div style="width: 100%; height: 100%; padding-bottom: 13px; padding-left: 24px; padding-right: 808px; background: white; box-shadow: 0px -3px 0px #1589EE inset; justify-content: flex-start; align-items: center; display: inline-flex">
        <div style="justify-content: flex-start; align-items: center; gap: 24px; display: inline-flex">
            
            <a href="#"><div class="fontdiv">Inicio de sesion / Registro</div></a>
        </div>

    </nav>
    <div class="row">
        <section>
            <div class="layoutbl">
                <div class="layoutlogin">
                    <br>
                    <p class="h22">Revisa tu correo</p>
                    <h2>Por favor ingresa el token que se envia al correo que ingresaste</h2>
                    <br>
                    <form class="formsa" id="formsa" action="TokenServlet" method="POST" >
                      <br>
                      <input type="password" id="Token" name="token" placeholder="Token" class="inputfb" required>
                     
                      <br><br><br>
                        <div class="alinearegis"><input type="button" onclick="validarToken()" id="login" value="Ingresar" style="border: #000000 solid; border-radius: 11px; color: #FFF; background-color: #347499; padding: 11px 25px;"></div>
                      </form>
                </div>
            </div>
        
        </section>  
        
    </div>

    <footer id="alinearizq">
      <a href="index.html"><div class="Botona">Regresar</div></a>
    </footer>

  </body>
</html>