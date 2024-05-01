document.addEventListener('DOMContentLoaded', () => {
    const chatbotToggler = document.querySelector(".chatbot-toggler");
    const closeBtn = document.querySelector(".close-btn");
    const chatbox = document.querySelector(".chatbox");
    const chatInput = document.querySelector(".chat-input textarea");
    const sendChatBtn = document.querySelector(".chat-input span");

    const opciones = ["Opción 1", "Opción 2", "Opción 3", "Opción 4", "Opción 5", "Opción 6", "Formulario"];

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
                case 5:
                    respondWithOption6Message();
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
        const response = "Lamentamos informarte que si tú año de cuarto semestre no corresponde al año actual, no podrás ingresar al sistema.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithAnotherAnimal = () => {
        const response ="A partir del fin del periodo de tu cuarto semestre, tendrás 2 semanas para responder ambos formularios.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption3Message = () => {
        const response = "No, Skill-tech para poder cumplir su propósito necesita que tú respondas todas las preguntas de ambos formularios.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption4Message = () => {
        const response = "No, si abandonas el sistema cuando estés contestando un formulario, cuando inicies sesión de nuevo, tendrás que responderlo desde cero.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }

    const respondWithOption5Message = () => {
        const response = "No, si tú concluyes el primer formulario y sales del sitio, cuando inicies sesión, solamente tendrás que contestar el formulario que no respondiste.";
        const botChatLi = createChatLi(response, "incoming");
        chatbox.appendChild(botChatLi);
    }
    
    const respondWithOption6Message = () => {
        const response = "No, solamente existe una oportunidad de resolver los formularios.";
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
