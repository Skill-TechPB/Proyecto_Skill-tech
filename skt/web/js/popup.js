document.addEventListener("DOMContentLoaded", function() {
    const popupContainer = document.getElementById("popup-container");
    const btnContinuar = document.getElementById("btn-continuar");
    const selectOption = document.getElementById("select-option");
  
    // Mostrar el popup al cargar la página
    popupContainer.style.display = "block";
  
    // Deshabilitar el scroll de la página mientras se muestra el popup
    document.body.style.overflow = "hidden";
  
    // Agregar evento al botón "Continuar"
    btnContinuar.disabled = true; // Inicialmente deshabilitado
  
    btnContinuar.addEventListener("click", function() {
      // Ocultar el popup
      popupContainer.style.display = "none";
  
      // Habilitar el scroll de la página
      document.body.style.overflow = "auto";
    });
  
    // Agregar evento al menú desplegable
    selectOption.addEventListener("change", function() {
      // Verificar si se ha seleccionado alguna opción
      if (selectOption.value !== "") {
        // Habilitar el botón "Continuar" si se ha seleccionado una opción
        btnContinuar.disabled = false;
      } else {
        // Deshabilitar el botón "Continuar" si no se ha seleccionado ninguna opción
        btnContinuar.disabled = true;
      }
    });
  });