   function validarFormulariolog() {
    var email = document.getElementById('LEmail').value;
    var contraseña = document.getElementById('LContraseña').value;
    var formatoEmail = /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,10})+$/;
    if (email.trim() === '' || contraseña.trim() === '') {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'Por favor, completa todos los campos.'
        });
        return false;
    } else if (!formatoEmail.test(email)) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'El formato del correo electrónico no es válido.'
        });
        return false;
    }else if (email.length > 200) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'El campo de correo no puede tener más de 200 caracteres.'
        });
        return false;
    } else if (contraseña.length < 8) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'La contraseña debe tener más de 8 caracteres pero menos de 24.'
        });
        return false;
    } else if (24 < contraseña.length) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'La contraseña debe tener más de 8 caracteres pero menos de 24.'
        });
        return false;
    } else {
        Swal.fire({
                icon: 'warning',
                title: 'Buscando cuenta',
                text: 'Espere porfavor',
                showConfirmButton: false,
                timer: 2000,
                 didClose: () => {
                    document.getElementById("formlog").submit();
                }
            });
    }
}
   
   
   
   function validarFormulario() {
        var email = document.getElementById("Email").value;
        var contraseña = document.getElementById("Contraseña").value;
        var egreso = document.getElementById("egreso").value;
        var condiciones = document.getElementById("condiciones").checked;
        var numExp = /^[0-9]+$/;
        var emailExp = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        var formatoPass= /^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#$%&? "]).*$/;
        
        if (email.trim() === '' || contraseña.trim() === '' || egreso.trim() === '' || !condiciones) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Por favor, completa todos los campos y acepta los términos y condiciones.'
            });
        }else if (contraseña.length < 8) {
    Swal.fire({
        icon: 'error',
        title: 'Error',
        text: 'La contraseña debe tener al menos 8 caracteres pero menos de 24.'
            });
        } else if (24 < contraseña.length) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'La contraseña debe tener más de 8 caracteres pero menos de 24.'
        });
        return false;
    }else if (email.length > 200) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'El campo de correo no puede tener más de 200 caracteres.'
        });
        return false;
    }else if (!email.match(emailExp)) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Ingresa una dirección de correo electrónico válida.'
            });
        } else if (!egreso.match(numExp)) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'El campo "Año de Egreso" solo debe contener números.'
            });
        }  else if (egreso.length !== 4) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'El campo "Año de Egreso" debe tener exactamente 4 caracteres.'
            });
        }  else if (parseInt(egreso) >= new Date().getFullYear()) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'El año de egreso no puede ser mayor, ni igual al año actual.'
            });
        } else if (parseInt(egreso) < new Date().getFullYear() - 3) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'El año de egreso no puede ser mayor, ni igual al año actual.'
            });
        } else if (!formatoPass.test(contraseña)) {
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: 'El formato de la contraseña no es válido. Debe contener 8 caracteres y al menos un número, una letra y un carácter único, como!#$%&?'
        });
        return false;
    }else {
            Swal.fire({
                icon: 'success',
                title: 'Éxito',
                text: 'Formulario enviado correctamente.',
                showConfirmButton: false,
                timer: 2000,
                 didClose: () => {
                    document.getElementById("regis").submit();
                }
            });
        }
    }
    
    function findGetParameter(parameterName) {
        var result = null,
            tmp = [];
        var items = location.search.substr(1).split("&");
        for (var index = 0; index < items.length; index++) {
            tmp = items[index].split("=");
            if (tmp[0] === parameterName) result = decodeURIComponent(tmp[1]);
        }
        return result;
    }
    function validaErrorLogin(){
        if (findGetParameter('msg')!==null){
             Swal.fire({
                icon: 'error',
                title: 'Error',
                text: 'Su cuenta está desactivada o el usuario no esta registrado, contacte con el administrador.'
            });
        }
    }
    window.onload = function(){
        validaErrorLogin(); 
    };
    