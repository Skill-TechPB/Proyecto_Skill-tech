        function validarToken() {
            var token = document.getElementById('Token').value;

            if (token.trim() === '') {
                mostrarAlertaError('El campo Token no puede estar vacío.');
                return false;
            } else if (!/^[A-Z]{5}$/.test(token)) {
                mostrarAlertaError('El token debe contener solo letras en mayuscula y tener una longitud de 5 caracteres.');
                return false;
            } else {
                    mostrarExito();
                return true;
            }
        }

        function mostrarAlertaError(mensaje) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: mensaje,
                confirmButtonColor: '#d33',
                confirmButtonText: 'Aceptar'
            });
        }
        function mostrarExito(){         
        Swal.fire({
                icon: 'warning',
                text: 'Verificando token',
                showConfirmButton: false,
                timer: 2000,
                 didClose: () => {
                    document.getElementById("formsa").submit();
                }
            });
        }