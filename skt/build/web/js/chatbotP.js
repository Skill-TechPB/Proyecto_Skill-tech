document.addEventListener('DOMContentLoaded', () => {
    const chatbotToggler = document.querySelector(".chatbot-toggler");
    const closeBtn = document.querySelector(".close-btn");
    const chatbox = document.querySelector(".chatbox");
    const chatInput = document.querySelector(".chat-input textarea");
    const sendChatBtn = document.querySelector(".chat-input span");

    const opciones = ["Opción 1", "Opción 2", "Opción 3", "Formulario"];

    const createChatLi = (message, className) => {
        // Create a chat <li> element with passed message and className
        const chatLi = document.createElement("li");
        chatLi.classList.add("chat", `${className}`);
        let chatContent = className === "outgoing" ? `<p>${message}</p>` : `<span class="material-symbols-outlined"><img src="assets/usuario.png" class="imgbot"></span><p>${message}</p>`;
        chatLi.innerHTML = chatContent;
        return chatLi; // return chat <li> element
    }

    const handleChat = () => {
        const userMessage = chatInput.value.trim(); // Get user entered message
        if (!userMessage) return;

        // Display user's message in the chatbox
        const userChatLi = createChatLi(userMessage, "outgoing");
        chatbox.appendChild(userChatLi);

        // Check if user message is a number corresponding to an option
        const optionIndex = parseInt(userMessage) - 1;
        if (!isNaN(optionIndex) && optionIndex >= 0 && optionIndex < opciones.length) {
            // If user message is a valid option number, respond accordingly
            switch (optionIndex) {
                case 0:
                    respondWithDog();
                    break;
                case 1:
                    respondWithAnotherAnimal();
                    break;
                case 2:
                    respondWithOption3Message();
                    break;
                case 3:
                    respondWithForm();
                    break;
                default:
                    respondWithErrorMessage();
                    break;
            }
        } else {
            // If user message is not a valid option number, display error message
            respondWithErrorMessage();
        }

        // Scroll to the bottom of the chatbox
        chatbox.scrollTo(0, chatbox.scrollHeight);

        // Clear the input textarea
        chatInput.value = "";
    }

    const respondWithDog = () => {
        const response = "No, solamente usted puede acceder a sus gráficas.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithAnotherAnimal = () => {
        const response ="Cada año, cuando los alumnos de cuarto semestre concluyan su semestre y accedan al sistema.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption3Message = () => {
        const response = "Cada generación tendrá sus propias gráficas y reportes correspondientes, pudiendo acceder a ell@s mediante el apartado de generaciones.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithForm = () => {
        const formHTML = `
            <form id="chatbot-form" action="regsop" method="post">
                <h2>Formulario de Contacto</h2>
                <label for="email">Correo electrónico:</label><br>
                <input type="email" id="email" name="email" required><br><br>
                <label for="description">Descripción del problema o sugerencia:</label><br>
                <textarea id="description" name="description" rows="4" cols="50" required></textarea><br><br>
                <select name="tipo" id="tipo">
                <option value="" selected disabled hidden>Selecciona una opción</option>
                <option value="1">Falla en el programa</option>
                <option value="2">Sugerencia</option>
                <input type="submit" value="Enviar">
            </form>
        `;
        const botChatLi = createChatLi(formHTML, "incoming");
        chatbox.appendChild(botChatLi);

        // Handle form submission
        const form = document.getElementById("chatbot-form");
        form.addEventListener("submit", (event) => {
            event.preventDefault();

            // Get form data
            const email = document.getElementById("email").value;
            const description = document.getElementById("description").value;
            const tipo = document.getElementById("tipo").value;

            // Create JSON object
            const formData = {
                email: email,
                description: description,
                tipo: tipo
            };

            // Envío del formulario al servlet
            fetch(form.action, {
                method: form.method,
                headers: {
                    "Content-Type": "application/json"
                },
                body: JSON.stringify(formData)
            })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Error al enviar el formulario');
                }
                return response.text();
            })
            .then(data => {
                // Aquí podrías manejar la respuesta del servlet, si es necesario
                console.log(data);
            })
            .catch(error => {
                console.error('Error:', error);
            });

            // Simulate form submission (you can replace this with actual form submission logic)
            const responseMessage = `¡Gracias por tu mensaje! Hemos recibido tu correo: ${email} y la descripción del problema o sugerencia: ${description}.`;
            const responseChatLi = createChatLi(responseMessage, "incoming");
            chatbox.appendChild(responseChatLi);

            // Remove the form message from the chatbox
            chatbox.removeChild(botChatLi);

            // Scroll to the bottom of the chatbox
            chatbox.scrollTo(0, chatbox.scrollHeight);

            // Clear the form
            form.reset();
        });
    }

    const respondWithErrorMessage = () => {
        const errorMessage = "Opción no válida. Por favor, elige una opción disponible.";
        const botChatLi = createChatLi(errorMessage, "incoming");
        chatbox.appendChild(botChatLi);
    }

    chatInput.addEventListener("keydown", (e) => {
        // If Enter key is pressed without Shift key, handle the chat
        if (e.key === "Enter" && !e.shiftKey) {
            e.preventDefault();
            handleChat();
        }
    });

    sendChatBtn.addEventListener("click", handleChat);
    closeBtn.addEventListener("click", () => document.body.classList.remove("show-chatbot"));
    chatbotToggler.addEventListener("click", () => document.body.classList.toggle("show-chatbot"));

});
