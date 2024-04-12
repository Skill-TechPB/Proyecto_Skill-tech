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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js" integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js" integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX  6gSbd85u4mG4QzX+" crossorigin="anonymous"></script>
</head>
<body>
    <header>   
        <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
        <div class="barra">
            <div class="fontdiv">
                <div class="flujo21">
                    <a href="graficas.jsp"><button type="button" class="opcn">Graficas</button></a>
                </div>
                <div class="flujo3">
                    <a href="Editform.jsp"><button class="opla" type="button">Ed.Formularios</button></a>
                </div>  
                <div class="flujo4">
                    <a href="bita.jsp"><button class="opcn" type="button">Bitacora</button></a>
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
        <p class="ttl">Edicion de Formularios</p>
    </div>
</nav>
<div class="alincentro"><p class="ins">Seleccione el formulario que desee editar:</p></div>
    <br>
    
    
    <div class="op1">
        <a href="FEDITPO.jsp" class="link">
        <p class="poo">Programacion Intermedia</p>
        <img class="capt1" src="assets/codi.png">   
    </a>
    </div>


    
    <div class="op2">
        <a href="FEDITBD.jsp" class="link">
        <p class="bd">Bases de Datos</p>
        <svg xmlns="http://www.w3.org/2000/svg" width="17vw" height="27vh" fill="currentColor" class="bi bi-database-fill" viewBox="0 0 16 16" id="dtb">
            <path d="M3.904 1.777C4.978 1.289 6.427 1 8 1s3.022.289 4.096.777C13.125 2.245 14 2.993 14 4s-.875 1.755-1.904 2.223C11.022 6.711 9.573 7 8 7s-3.022-.289-4.096-.777C2.875 5.755 2 5.007 2 4s.875-1.755 1.904-2.223"/>
            <path d="M2 6.161V7c0 1.007.875 1.755 1.904 2.223C4.978 9.71 6.427 10 8 10s3.022-.289 4.096-.777C13.125 8.755 14 8.007 14 7v-.839c-.457.432-1.004.751-1.49.972C11.278 7.693 9.682 8 8 8s-3.278-.307-4.51-.867c-.486-.22-1.033-.54-1.49-.972"/>
            <path d="M2 9.161V10c0 1.007.875 1.755 1.904 2.223C4.978 12.711 6.427 13 8 13s3.022-.289 4.096-.777C13.125 11.755 14 11.007 14 10v-.839c-.457.432-1.004.751-1.49.972-1.232.56-2.828.867-4.51.867s-3.278-.307-4.51-.867c-.486-.22-1.033-.54-1.49-.972"/>
            <path d="M2 12.161V13c0 1.007.875 1.755 1.904 2.223C4.978 15.711 6.427 16 8 16s3.022-.289 4.096-.777C13.125 14.755 14 14.007 14 13v-.839c-.457.432-1.004.751-1.49.972-1.232.56-2.828.867-4.51.867s-3.278-.307-4.51-.867c-.486-.22-1.033-.54-1.49-.972"/>
          </svg>
        </a>
    </div>  
</body>
</html>