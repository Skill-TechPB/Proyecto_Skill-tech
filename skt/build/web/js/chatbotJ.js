document.addEventListener('DOMContentLoaded', () => {
    const chatbotToggler = document.querySelector(".chatbot-toggler");
    const closeBtn = document.querySelector(".close-btn");
    const chatbox = document.querySelector(".chatbox");
    const chatInput = document.querySelector(".chat-input textarea");
    const sendChatBtn = document.querySelector(".chat-input span");

    const opciones = ["Opción 1", "Opción 2", "Opción 3", "Opción 4", "Opción 5", "Formulario"];

    const createChatLi = (message, className) => {
        // Create a chat <li> element with passed message and className
        const chatLi = document.createElement("li");
        chatLi.classList.add("chat", `${className}`);
        let chatContent = className === "outgoing" ? `<p>${message}</p>` : `<span class="material-symbols-outlined">person</span><p>${message}</p>`;
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
                    respondWithOption4Message();
                    break;
                case 4:
                    respondWithOption5Message();
                    break;
                case 6:
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
        const response = "Los datos que representan, en otras palabras, las gráficas y reportes de los profesores solamente son exclusivos para los registros de los alumnos que hayan tenido clase con ello, es decir que son datos individuales. Mientras que las gráficas y reportes del jefe de academia son datos generales ( de todo el sistema).";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithAnotherAnimal = () => {
        const response ="Inmediatamente, una vez que xd guardaron los cambios, estos automáticamente se actualizan.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption3Message = () => {
        const response = "Las veces que se requiera, no hay un límite.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption4Message = () => {
        const response = "No, se pueden modificar todas las preguntas, respuestas, y opciones de respuesta, o simplemente se puede editar solo uno de ellos.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption5Message = () => {
        const response = "No, solamente el Jefe de Academia puede ver la bitácora de cambios de los formularios.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }
    const respondWithForm = () => {
        const formHTML = `
            <form id="chatbot-form" action="" method="post">
                <h2>Formulario de Contacto</h2>
                <label for="email">Correo electrónico:</label><br>
                <input type="email" id="email" name="emailch" required><br><br>
                <label for="description">Descripción del problema o sugerencia:</label><br>
                <textarea id="description" name="descriptionch" rows="4" cols="50" required></textarea><br><br>
                <input type="submit" value="Enviar">
            </form>
        `;
        const botChatLi = createChatLi(formHTML, "incoming");
        chatbox.appendChild(botChatLi);

        // Handle form submission
        const form = document.getElementById("chatbot-form");
        form.addEventListener("submit", (event) => {
            event.preventDefault();

            const formData = new FormData(form);
            const email = formData.get("email");
            const description = formData.get("description");

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
