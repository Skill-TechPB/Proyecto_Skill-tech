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
  if (tipou == null || (tipou.equals("0") || tipou.equals("4") || tipou.equals("1"))) {
    response.sendRedirect("index.html");
    return;
}
%>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="utf-8">
    <title>Edicion de Formularios</title>
    <link rel="shortcut icon" href="./assets/logo1.png" />
    <link rel="stylesheet" href="./css/editformu.css">
</head>
<body>

    <header>
        <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
        <p class="h21">Skill-tech</p>
        <div class="Boton" id="alinearder"><form action="Cerrar" method="post"><input type="submit" value="Cerrar Sesion" class="Botona"></form></div>
    </header>
    <div style="width: 100%; height: 100%; padding-bottom: 13px; padding-left: 24px; padding-right: 808px; background: white; box-shadow: 0px -3px 0px #1589EE inset; justify-content: flex-start; align-items: center; display: inline-flex">
        <div style="justify-content: flex-start; align-items: center; gap: 24px; display: inline-flex">
            <div class="fontdiv">
                <div class="flujo">
                    <a href="Editform.jsp" class="link"> <img class="imgflujo" src="./assets/formulario-de-contacto.png"><P class="txtflujo">Edicion de formularios</P></a>
                </div>
                <div class="flujo2">
                    <a href="graficas.jsp" class="link"><img class="imgflujo2" src="./assets/grafico-circular (1).png"><P class="txtflujo2">Graficas</P></a>
                </div>
            </div>
        </div>
    </div>
<nav>
    <div class="nav-container">
            <div class="fontdiv"><h2>Edicion de Formularios</h2></div>
    </div>
</nav>
<h2 class="txtxd">Seleccione el formulario que desee editar: </h2>
    <br>
    
    <div class="op1">
        <a href="FEDITPO.jsp" class="link">
        <p class="poo">POO</p>
        <img class="capt1" src="assets/programacion.png">
         </a> 
    </div>
      

    
    <div class="op2">
        <a href="FEDITBD.jsp" class="link">
        <p class="bd">Bases de Datos</p>
        <img class="capt2" src="assets/base-de-datos (1).png">
        </a>
    </div>  
</body>
</html>