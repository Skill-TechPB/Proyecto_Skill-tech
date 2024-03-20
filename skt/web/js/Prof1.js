function validarFormulario() {
    const pregInputs = document.querySelectorAll('.preg');

    for (const pregInput of pregInputs) {
        const contenidoPreg = pregInput.value.trim();
         const caracteresEspecialesRegex = /^[a-zA-Z0-9\s()"'[\]¿?]*$/; 
        if (contenidoPreg.length >= 225 || !caracteresEspecialesRegex.test(contenidoPreg)) {
            mostrarError();
            return false;
        }
    }
    const respInputs = document.querySelectorAll('.resp');

    for (const respInput of respInputs) {
        const contenidoResp = respInput.value.trim();
        const caracteresEspecialesRegex = /^[a-zA-Z0-9\s()"'[\]¿?]*$/; 
        if (contenidoResp.length >= 225 || !caracteresEspecialesRegex.test(contenidoResp)) {
            mostrarError();
            return false;
        }
    }

    mostrarExito();
    return true;
}
function mostrarExito() {
    Swal.fire({
        icon: 'success',
        title: '¡Formulario válido!',
        text: 'Tus datos han sido validados correctamente.',
    }).then((result) => {
        if (result.isConfirmed) {
            const form = document.getElementById('myForm');
            form.submit();
        }
    });
}