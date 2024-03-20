function valid1() {
    var p1=document.getElementsByName('p1');
    var p2=document.getElementsByName('p2');
    var p3=document.getElementsByName('p3');
    var p4=document.getElementsByName('p4');
    var p5=document.getElementsByName('p5');
    var p6=document.getElementsByName('p6');
    var p7=document.getElementsByName('p7');
    var p8=document.getElementsByName('p8');
    var p9=document.getElementsByName('p9');
    var p10=document.getElementsByName('p10');
    var ExpRegSoloNumeros="^[0-1]+$";
    let lent1 =[1,1,1,1,1,1,1,1,1,1];
    let titulos = ["Pregunta 1","Pregunta 2","Pregunta 3","Pregunta 4","Pregunta 5","Pregunta 6","Pregunta 7","Pregunta 8","Pregunta 9","Pregunta 10",]
    let memory="" ;
    let memory2="" ;
    let memory3="" ;
    let memory4="" ;
    let memory5="" ;
    let memory6="" ;
    let memory7="" ;
    let memory8="" ;
    let memory9="" ;
    let memory10="" ;    
    for(i=0; i<p1.length; i++){
        if(p1[i].checked){
             memory=p1[i].value;
        }
        if(p2[i].checked){
             memory2=p2[i].value;
        }        
        if(p3[i].checked){
             memory3=p3[i].value;
        }        
        if(p4[i].checked){
             memory4=p4[i].value;
        }        
        if(p5[i].checked){
             memory5=p5[i].value;
        }        
        if(p6[i].checked){
             memory6=p6[i].value;
        }        
        if(p7[i].checked){
             memory7=p7[i].value;
        }        
        if(p8[i].checked){
            memory8=p8[i].value;
        }        
        if(p9[i].checked){
             memory9=p9[i].value;
        }        
        if(p10[i].checked){
             memory10=p10[i].value;
        } 
    }
    let campos = [memory,memory2,memory3,memory4,memory5,memory6,memory7,memory8,memory9,memory10];
    let lent2 =[memory.length,memory2.length,memory3.length,memory4.length,memory5.length,memory6.length,memory7.length,memory8.length,memory9.length,memory10.length];
    for(j=0; j<campos.length; j++){
        if(campos[j]===""){
            Swal.fire(titulos[j], titulos[j]+ " no esta respondida", "error");
        return f}
        if(campos[j].match(ExpRegSoloNumeros)=== null){
            Swal.fire(titulos[j], titulos[j]+ " no tiene el valor correcto", "error");
        return f}
        if(lent1[j]<lent2[j]){
                    Swal.fire(titulos[j], titulos[j]+ " tiene mas valores de los aceptados", "error");
        return f}
    }
    for (var h = 0; h<=10 ; h++) {
    	if(campos[h]!=="" && lent2[h]<=lent1[h] && campos[h].match(ExpRegSoloNumeros)!== null && lent1[h]===lent2[h]){
        Swal.fire({
            icon:"success",
            title: "Perfecto",
            text: "Has responddo todas las preguntas"
        }).then((result) => {
        if (result.value) {
        document.getElementById('Envio').value = 'Continuar';
        document.getElementById('Envio').type = 'submit';
        document.getElementById('Envio').onclick = "" ;
        }
    }); 
   
        } 
    }
}

