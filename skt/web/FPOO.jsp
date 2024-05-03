    <%@page contentType="text/html" pageEncoding="UTF-8"%>
    <%@page import="java.sql.Connection" %>
    <%@page import="java.sql.Statement" %>
    <%@page import="java.sql.ResultSet" %>
    <%@page import="java.io.*" %>
    <%@page import="Conexion.Conexion" %>
    <%@page import="javax.servlet.http.HttpSession"%>
    <% HttpSession sesion = request.getSession(true); %>
    <%String tipou = (String) sesion.getAttribute("tipou");%>
    <%int idUsuario = (int) sesion.getAttribute("usu_id");%>
    <% if(sesion.isNew() || sesion==null){
    response.sendRedirect("index.html");
    return;}
    %>
    <%
    if (tipou == null || tipou.equals("1") || tipou.equals("4") || tipou.equals("2")) {
    response.sendRedirect("index.html");
    return;}%>
    <!DOCTYPE html>
    <%!
    Conexion pal;
    Connection con;
    Statement stmt;
    ResultSet rs, rs2, rs3, rs4, rs5, rs6;
    String[] preg = new String[10];
    String[] resp = new String[40];
    String[] vals = new String[40];
    String[] tema = new String[3];
    String ruta = "",content = "";
    int a = 0, b = 0, c=0, d=0;
    int banderitaPoo=0, banderitaBD=0, reg=0, regpro=0, idegr=0;
    %>
    <% 
    pal = new Conexion();
    con = pal.getConnection();
    stmt = con.createStatement();
    rs2 = stmt.executeQuery("SELECT egr_bandPOO, egr_banBD from egresado where usu_id = "+idUsuario+"");
    if(rs2.next()){
    banderitaPoo= rs2.getInt("egr_bandPOO");
    banderitaBD = rs2.getInt("egr_banBD");
                }
    if(banderitaPoo == 1 && banderitaBD == 0){
    response.sendRedirect("FBD.jsp");
    }else{
    if(banderitaPoo == 1 && banderitaBD == 1){
    response.sendRedirect("agradecimiento.jsp");
    }
    }
        
    rs = stmt.executeQuery("select for_url from formulario where for_id=1");
    
    while(rs.next()){
    ruta =rs.getString("for_url");
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
    }a=0;
    //Valores
    b=preg.length+resp.length;
    for(int i=0; i<vals.length;i++ ){
    vals[i]=gene[b];
    b=b+1;
    }b=0;
    //tematica
    d=preg.length+resp.length+vals.length;
    for(int i=0; i<tema.length;i++ ){
    tema[i]=gene[d];
    d=d+1;
    }d=0;
    lector.close();
    }catch(IOException ex){
    ex.printStackTrace(System.out);
    }
    //Arreglo de profe
    rs3 = stmt.executeQuery("select count(*) as Registros from profesor inner join pro_asi on profesor.pro_id=pro_asi.pro_id where pro_asi.asi_id=0");
    while(rs3.next()){
    reg =rs3.getInt("Registros");
    }
    rs4 = stmt.executeQuery("select pro_nombre, profesor.pro_id from profesor inner join pro_asi on profesor.pro_id=pro_asi.pro_id where pro_asi.asi_id=0");
    String[] prof= new String[reg];
    int[] idpro = new int[reg];
    c=0;
    while(rs4.next()){
    prof[c]=rs4.getString("pro_nombre");
    idpro[c]=rs4.getInt("profesor.pro_id");
    c=c+1;
    }c=0;
    %>
    <html>
    <head>
    <meta charset="utf-8" />
    <title>FPOO</title>
    <link rel="shortcut icon" href="./assets/logo1.png" />
    <link rel="stylesheet" href="css/formulario.css" />
    <link rel="stylesheet" href="css/popup.css">
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="js/valiForms.js"></script>
    <script src="js/popup.js"></script>
    </head>
    <body>
    <header>
           <h1 class="imglogo"><img src="./assets/logo1.png" /></h1>
           <p class="h21">Skill-tech</p>
    </header>
    <%
    rs5=stmt.executeQuery("select egr_id from egresado where usu_id="+idUsuario+"");
    if(rs5.next()){
    idegr=rs5.getInt("egr_id");
    }
    rs6 = stmt.executeQuery("select count(*) as Registros from egr_pro where egr_id="+idegr+"");
    while(rs6.next()){
    regpro=rs6.getInt("Registros");
    }
    if(regpro==0){
    %>
    <div id="popup-container" class="popup-container">
      <div class="popup">
        <form method="POST" action="resprop" class="form" id="formpro">
        <h2 class="h">A continuacion seleccione el profesor que le haya dado la materia de Programacion Intermedia:</h2>
        <select id="select-option" name="profe" class="profes">
        <option value="" selected disabled hidden>Selecciona una opción</option>
        <%
        for(int i=0; i<prof.length;i++){
        %>
        <option value=<%=idpro[i]%>><%=prof[i]%></option>
        <%}%>
        </select>
        <div class="pedri">
        <button type="submit" id="btn-continuar" class="conti">Continuar</button>
       </div>
        </form>
      </div>
    </div>
    <%}%>
    <div class="row">
           <section>
           <p class="tituform">Formulario de Programación Intermedia</p>
           <p class="borde">Instrucciones:<br> Responda las preguntas que se muestran a continuación, seleccionando la opción que crea más conveniente para cada pregunta.  Sus respuestas serán evaluadas tan pronto como de click al botón de enviar al final de este formulario.</p>
           </section>

    </div>
    <hr>         
    <form method="POST" action="resp" class="form">
       <div class="tm">
              <p class="sis">Temática 1:</p>
              <p class="tema"><%=tema[0]%></p>
       </div>
           <h2>1- <%=preg[0]%></h2>
           <br> 
           <label><input type="radio" class="cir"
                  name="p1" 
                  value="<%=vals[0]%>"><%=resp[0]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p1" 
                  value="<%=vals[1]%>"><%=resp[1]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p1" 
                  value="<%=vals[2]%>"><%=resp[2]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p1" 
                  value="<%=vals[3]%>"><%=resp[3]%></label>
           <br> 

           <br>
           <br>

           <h2>  2- <%=preg[1]%></h2>
           <br> 
           <label><input type="radio" class="cir"
                  name="p2" 
                  value="<%=vals[4]%>"><%=resp[4]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p2" 
                  value="<%=vals[5]%>"><%=resp[5]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p2" 
                  value="<%=vals[6]%>"><%=resp[6]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p2" 
                  value="<%=vals[7]%>"><%=resp[7]%></label>
           <br> 

           <br>
           <br>

           <h2>3- <%=preg[2]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p3" 
                  value="<%=vals[8]%>"><%=resp[8]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p3" 
                  value="<%=vals[9]%>"><%=resp[9]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p3" 
                  value="<%=vals[10]%>"><%=resp[10]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p3" 
                  value="<%=vals[11]%>"><%=resp[11]%></label>
           <br> 

           <br>
           <br>

           <h2>4- <%=preg[3]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p4" 
                  value="<%=vals[12]%>"><%=resp[12]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p4" 
                  value="<%=vals[13]%>"><%=resp[13]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p4" 
                  value="<%=vals[14]%>"><%=resp[14]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p4" 
                  value="<%=vals[15]%>"><%=resp[15]%></label>
           <br> 

           <br>
           <hr class="line">
           <br>
       <div class="tm">
              <p class="sis">Temática 2:</p>
              <p class="tema"><%=tema[1]%></p>
       </div>
           <h2>5- <%=preg[4]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p5" 
                  value="<%=vals[16]%>"><%=resp[16]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p5" 
                  value="<%=vals[17]%>"><%=resp[17]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p5" 
                  value="<%=vals[18]%>"><%=resp[18]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p5" 
                  value="<%=vals[19]%>"><%=resp[19]%></label>
           <br> 
      
           <br>
           <h2>6- <%=preg[5]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p6" 
                  value="<%=vals[20]%>"><%=resp[20]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p6" 
                  value="<%=vals[21]%>"><%=resp[21]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p6" 
                  value="<%=vals[22]%>"><%=resp[22]%></label>
           <br> 
           <label><input type="radio"  class="cir"
                  name="p6" 
                  value="<%=vals[23]%>"><%=resp[23]%></label>
           <br> 

           <br>
           <br>
           <h2>7- <%=preg[6]%></h2>
           <br> 
           
                  <label><input type="radio" class="cir"
                  name="p7" 
                  value="<%=vals[24]%>"><%=resp[24]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p7" 
                  value="<%=vals[25]%>"><%=resp[25]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p7" 
                  value="<%=vals[26]%>"><%=resp[26]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p7" 
                  value="<%=vals[27]%>"><%=resp[27]%></label>
           <br> 

           <br>

           <br>
           <hr class="line">
           <div class="tm">
              <p class="sis">Temática 3:</p>
              <p class="tema"><%=tema[2]%></p>
       </div>
           <h2>8- <%=preg[7]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p8" 
                  value="<%=vals[28]%>"><%=resp[28]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p8" 
                  value="<%=vals[29]%>"><%=resp[29]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p8" 
                  value="<%=vals[30]%>"><%=resp[30]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p8" 
                  value="<%=vals[31]%>"><%=resp[31]%></label>
           <br> 

           <br>

           <br>

           <h2>9- <%=preg[8]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p9" 
                  value="<%=vals[32]%>"><%=resp[32]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p9" 
                  value="<%=vals[33]%>"><%=resp[33]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p9" 
                  value="<%=vals[34]%>"><%=resp[34]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p9" 
                  value="<%=vals[35]%>"><%=resp[35]%></label>
           <br> 

           <br>
           <br>

           <h2>10- <%=preg[9]%></h2>
           <br> 
                  <label><input type="radio" class="cir"
                  name="p10" 
                  value="<%=vals[36]%>"><%=resp[36]%></label> 
           <br> 
           <label><input type="radio" class="cir"
                  name="p10" 
                  value="<%=vals[37]%>"><%=resp[37]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p10" 
                  value="<%=vals[38]%>"><%=resp[38]%></label>
           <br> 
           <label><input type="radio" class="cir"
                  name="p10" 
                  value="<%=vals[39]%>"><%=resp[39]%></label>
           <br> 
           <br>
           <hr class="line2">
           <br>
    <footer>
           <input type="button" onclick="valid1()" value="Enviar" id="Envio"> 
    </footer>

    </form> 

    <div class="animateme">
       <ul class="bg-bubbles">
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
         <li></li>
       </ul>
     </div>
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
           <p>Hola! 👋<br>¿Cómo puedo ayudarte?<br>1-¿Qué pasa si mi año de 4to semestre no es el actual?<br>2-¿Cuánto tiempo tengo para responder los formularios una vez que me he registrado?<br>3-Una vez, que estoy resolviendo los formularios, ¿Puedo dejar sin contestar  preguntas?<br>4-¿Se quedan guardadas mis opciones seleccionadas del formulario sí abandono el sistema?<br>5-Si termino de contestar el primer formulario y abandono el sistema, cuando inicie sesión  ¿Tendré que llenar de nuevo el formulario que contesté?<br>6-¿Puedo volver a contestar los formularios para obtener una mejor puntuación?<br>7-Formulario</p>
         </li>
       </ul>
       <div class="chat-input">
         <textarea id="user-input" placeholder="Introduce un mensaje..." spellcheck="false" required></textarea>
         <span id="send-btn" class="material-symbols-rounded">send</span>
       </div>
     </div>
     <script src="js/chatbotA.js"></script>
    <%
    con.close();
    stmt.close();
    rs.close();
    rs2.close();
    rs3.close();
    rs4.close();
    rs5.close();
    rs6.close();
    %>
    </body>
    </html>