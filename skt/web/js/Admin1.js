    function validarFormulario() {
        var tipoUsuario = document.getElementById('tipousu').value;
        var email = document.getElementById('Email').value;
        var password = document.getElementById('Pasword').value;
        const textoInput = document.getElementById('Nombrepr');
        var formatoPass= /^.*(?=.{8,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!#$%&? "]).*$/;
        const valorInput = textoInput.value;
        const soloLetras = /^[A-Za-z]+$/;
        var formulario = document.querySelector('.form');
        var botonRegistro = document.querySelector('.Botona');
        // Validaciones
        if (tipoUsuario === "" || valorInput === "" || email === "" || password === "") {
            mostrarAlerta('Error', 'Todos los campos son obligatorios', 'error');
            return;
        }
        if (!formatoPass.test(password)) {
            mostrarAlerta('Error', 'El formato de la contraseña no es válido. Debe contener 8 caracteres y al menos un número, una letra y un carácter único, como!#$%&?', 'error');
        return;
    }
        if (!esCorreoValido(email)) {
            mostrarAlerta('Error', 'Ingrese un correo electrónico válido', 'error');
            return;
        }
        if (!soloLetras.test(valorInput)) {
            mostrarAlerta('Error', 'El nombre solo puede tener letras', 'error');
            return;
          }
        if(valorInput.legth <4 ){
            mostrarAlerta('Error', 'El nombre no puede terner menos de 4 letras ni ser mayor a 50', 'error');
        }
        if(50 < valorInput.legth){
            mostrarAlerta('Error', 'El nombre no puede terner menos de 4 letras ni ser mayor a 50', 'error');
        }
        if (email.length > 200) {
            mostrarAlerta('Error', 'El campo de correo no puede tener más de 200 caracteres', 'error');
    }
        if (24 < password.length) {
            mostrarAlerta('Error', 'La contraseña debe tener más de 8 caracteres pero menos de 24', 'error');
    }
        mostrarAlerta('Éxito', 'Usuario registrado correctamente', 'success');
        formulario.submit();
    }

    // Función para mostrar alertas de SweetAlert2
    function mostrarAlerta(titulo, mensaje, icono) {
        Swal.fire({
            title: titulo,
            text: mensaje,
            icon: icono,
        });
    }
    function esCorreoValido(correo) {
        var expresionCorreo = /^\w+([.-]?\w+)*@\w+([.-]?\w+)*(\.\w{2,})+$/;
        return expresionCorreo.test(correo);
    }