    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="Conexion.Conexion" %>
    <%@page import="javax.servlet.http.HttpSession"%>
    <%@page import="java.io.*" %>
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
        return ;
    }
    %>
    <!DOCTYPE html>
    <%!
    Conexion pal;
    Connection con;
    Statement stmt;
    ResultSet rs;
    String[] preg = new String[10];
    String[] resp = new String[40];
    String forname="";
    String ruta = "";
    String content = "";
    int a = 0;
    %>
    <% 
    pal = new Conexion();
    con = pal.getConnection();
    stmt = con.createStatement();
    rs = stmt.executeQuery("select for_nombre, for_url from formulario where for_id=1");

    while(rs.next()){
    ruta =rs.getString("for_url");
    forname=rs.getString("for_nombre");
    }
    File form = new File(ruta);
    
    if(form.exists()== false){
     try{
     if(form.createNewFile()){
     System.out.println("Se creo apa");
     }else {
         System.out.println("Ya existe o le moviste a algo");
     }
     }catch(IOException ex){
     ex.printStackTrace(System.out);
     }
     } 

    try{
    //Se establece la comunicacion
    FileReader leer = new FileReader(form);
    BufferedReader lector = new BufferedReader(leer);

    //Se lee el fichero
    content = lector.readLine();
    String gene[] = content.split("/ ");
    //Preguntas
    for(int i=0; i<preg.length;i++ ){
    preg[i]=gene[i];
    }

    //Respuestas
    a=preg.length;
    for(int i=0; i<resp.length;i++ ){
    resp[i]=gene[a];
    a=a+1;
    }
    a=0;

    lector.close();
    }catch(IOException ex){
    ex.printStackTrace(System.out);
    }
    %>

    <html>
      <head>
        <meta charset="utf-8" />
        <title>Formulario POO</title>
        <link rel="stylesheet" href="./css/profesor.css" />
        <link rel="shortcut icon" href="./assets/logo1.png" />
        <style>
            input[type="text"]{
            border:none;
            width: 1100px;
            height: 30px;
            font-size: 15px; 
            font: normal bold 15px/1 "Open Sans", sans-serif;
            word-wrap: break-word;
                }
        </style>
      </head>
      <body>

       <header>
              <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
              <p class="h21">Skill-tech</p>
       </header>

       <div class="row">
              <section>
              <h1><%=forname%></h1>
              <p id='borde'>En el apartado siguiente podrá realizar cambios a las preguntas y respuestas de este formulario y cuando haya finalizado, dar click al boton "guardar" para guardar sus cambios.</p>
              </section>
              
       </div>
       <hr>
    <form method="POST" action="editpo"> 
        
        <div id="header"><h2>1. </h2><input type="text" name="editable1" placeholder="<%=preg[0]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit1" placeholder="<%=resp[0]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit2" placeholder="<%=resp[1]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit3" placeholder="<%=resp[2]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit4" placeholder="<%=resp[3]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select1">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="1" select>Respuesta 1</option>
                 <option value="2">Respuesta 2</option>
                 <option value="3">Respuesta 3</option>
                 <option value="4">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>2. </h2><input type="text" name="editable2" placeholder="<%=preg[1]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit5" placeholder="<%=resp[4]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit6" placeholder="<%=resp[5]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit7" placeholder="<%=resp[6]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit8" placeholder="<%=resp[7]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select2">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="5" select>Respuesta 1</option>
                 <option value="6">Respuesta 2</option>
                 <option value="7">Respuesta 3</option>
                 <option value="8">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>3. </h2><input type="text" name="editable3" placeholder="<%=preg[2]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit9" placeholder="<%=resp[8]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit10" placeholder="<%=resp[9]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit11" placeholder="<%=resp[10]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit12" placeholder="<%=resp[11]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select3">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="9" select>Respuesta 1</option>
                 <option value="10">Respuesta 2</option>
                 <option value="11">Respuesta 3</option>
                 <option value="12">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>4. </h2><input type="text" name="editable4" placeholder="<%=preg[3]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit13" placeholder="<%=resp[12]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit14" placeholder="<%=resp[13]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit15" placeholder="<%=resp[14]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit16" placeholder="<%=resp[15]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select4">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="13" select>Respuesta 1</option>
                 <option value="14">Respuesta 2</option>
                 <option value="15">Respuesta 3</option>
                 <option value="16">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>5. </h2><input type="text" name="editable5" placeholder="<%=preg[4]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit17" placeholder="<%=resp[16]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit18" placeholder="<%=resp[17]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit19" placeholder="<%=resp[18]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit20" placeholder="<%=resp[19]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select5">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="17" select>Respuesta 1</option>
                 <option value="18">Respuesta 2</option>
                 <option value="19">Respuesta 3</option>
                 <option value="20">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>6. </h2><input type="text" name="editable6" placeholder="<%=preg[5]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit21" placeholder="<%=resp[20]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit22" placeholder="<%=resp[21]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit23" placeholder="<%=resp[22]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit24" placeholder="<%=resp[23]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select6">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="21" select>Respuesta 1</option>
                 <option value="22">Respuesta 2</option>
                 <option value=23>Respuesta 3</option>
                 <option value="24">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>7. </h2><input type="text" name="editable7" placeholder="<%=preg[6]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit25" placeholder="<%=resp[24]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit26" placeholder="<%=resp[25]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit27" placeholder="<%=resp[26]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit28" placeholder="<%=resp[27]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select7">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="25" select>Respuesta 1</option>
                 <option value="26">Respuesta 2</option>
                 <option value="27">Respuesta 3</option>
                 <option value="28">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>8. </h2><input type="text" name="editable8" placeholder="<%=preg[7]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit29" placeholder="<%=resp[28]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit30" placeholder="<%=resp[29]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit31" placeholder="<%=resp[30]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit32" placeholder="<%=resp[31]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select8">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="29" select>Respuesta 1</option>
                 <option value="30">Respuesta 2</option>
                 <option value="31">Respuesta 3</option>
                 <option value="32">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>9. </h2><input type="text" name="editable9" placeholder="<%=preg[8]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit33" placeholder="<%=resp[32]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit34" placeholder="<%=resp[33]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit35" placeholder="<%=resp[34]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit36" placeholder="<%=resp[35]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select9">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="33" select>Respuesta 1</option>
                 <option value="34">Respuesta 2</option>
                 <option value="35">Respuesta 3</option>
                 <option value="36">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
        <div id="header"><h2>10. </h2><input type="text" name="editable10" placeholder="<%=preg[9]%>"><img class="imgedit" src="assets/editar.png"></div>
        <br>
        <label><input type="radio"
               name="agree" 
               value="yes" disabled><div id="evit"><input type="text" class="resp" name="respedit37" placeholder="<%=resp[36]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit38" placeholder="<%=resp[37]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit39" placeholder="<%=resp[38]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
        <br> 
        <label><input type="radio"
               name="agree" 
               value="no" disabled><div id="evit"><input type="text" class="resp" name="respedit40" placeholder="<%=resp[39]%>"></input><img class="imgedit" src="assets/editar.png"></div></label> 
               <h4 id="header4">Elija la nueva respuesta correcta:
                <select name="select10">
                 <option value="" selected disabled hidden>Selecciona una opción</option>
                 <option value="37" select>Respuesta 1</option>
                 <option value="38">Respuesta 2</option>
                 <option value="39">Respuesta 3</option>
                 <option value="40">Respuesta 4</option>
               </select></h4>
        <hr>
        <br>
    <footer>
       <input type="Submit" id="guardar" value="Guardar" class="Botona">
       <input type="reset" id="cancelar" value="Cancelar cambios" class="Botonb">
    </footer>
        
    </form> 

    </body>
    </html>
