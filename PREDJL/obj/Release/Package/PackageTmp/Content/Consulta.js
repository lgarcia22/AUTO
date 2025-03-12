function CustomValidateID(s, e) {
    var id = e.value;
    if (!isValidID(id)) {
        e.isValid = false;
        if (hasSpecialCharacters(id)) {
            e.errorText = "No debe contener caracteres especiales.";
        } else {
            e.errorText = "El Número de identificación es incorrecto.";
        }
    }
}

function toUpperCase(id) {
    var textbox = document.getElementById(id);
    textbox.value = textbox.value.toUpperCase();
}

function soloNumerosYLetras(e) {
    var key = e.keyCode || e.which;
    var tecla = String.fromCharCode(key);
    var patron = /^[a-zA-Z0-9\s]$/; // Permite letras, números y espacios

    if (!patron.test(tecla)) {
        return false;
    }

    return true;
}
//function isValidID(id) {
//    // Primero verificamos si tiene caracteres especiales
//    if (hasSpecialCharacters(id)) {
//        return false;
//    }

//    if (id.length == 13 && isNumeric(id)) {
//        // Validación para el Documento Nacional de Identificación (DNI)
//        return true;
//    } else if (id.length >= 6 && id.length <= 9 && isAlphanumeric(id)) {
//        // Validación para el pasaporte
//        return true;
//    } else if (id.length == 8 && isAlphanumeric(id)) {
//        // Validación para el carnet de residencia
//        return true;
//    }
//    return false;
//}
function isValidID(id) {
    // Check if id is null or undefined
    if (!id) {
        return false;
    }

    // Verify if it has special characters
    if (hasSpecialCharacters(id)) {
        return false;
    }

    // Validate ID based on its length and type
    if (id.length === 13 && isNumeric(id)) {
        // Validation for Documento Nacional de Identificación (DNI)
        return true;
    } else if (id.length >= 6 && id.length <= 9 && isAlphanumeric(id)) {
        // Validation for passport
        return true;
    }
    //else if (id.length === 8 && isAlphanumeric(id)) {
    //    // Validation for residency card
    //    return true;
    //}

    // If none of the conditions match, return false
    return false;
}

function isNumeric(value) {
    return /^\d+$/.test(value);
}

function isAlphanumeric(value) {
    return /^[a-zA-Z0-9]+$/.test(value);
}

function hasSpecialCharacters(value) {
    var result = /[^a-zA-Z0-9]/.test(value);
    return result;
}


function btnEnviarCodigo_Click(s, e) {
    var numeroIdentidad = tbIdentidad.GetText();
    if (numeroIdentidad.trim() === '') {
        Swal.fire({
            title: "¡Alerta!",
            text: "Por favor ingrese el número de identificación nacional, número de pasaporte o carnet de residencia para continuar.",
            icon: "warning",
            confirmButtonColor: "#1F497D"
        });
        return;
    }

    ASPxCallback_EnviarToken.PerformCallback(numeroIdentidad, function (result) {
        if (result === "Token enviado") {
            popupToken.Show();
        } else {
            Swal.fire({
                title: "¡Alerta!",
                text: result,
                icon: "warning",
                confirmButtonColor: "#1F497D"
            });
        }
    });
}

function btnVerificarToken_Click(s, e) {
    var inputToken = tbToken.GetText();
    ASPxCallback_VerificarToken.PerformCallback(inputToken);
    tbToken.SetText('');
}

function TokenVerificationComplete(result) {
    try {
        var resultData = JSON.parse(result);
        var lblNombreUsuario = document.getElementById('lblNombreUsuario');
        var lblEstadoUsuario = document.getElementById('lblEstadoUsuario');
        var lblObs = document.getElementById('lblObs');
        var progressBarFill = document.getElementById('progress-bar-fill');
        var estadoColor = {
            "Pre-Registrado": "gray",
            "Procesando": "#FAC21A",
            "Rechazado": "red",
            "Requiere Documentación": "orangered",
            "Registrado": "green"
           
        };
        var estadoAvance = {
            "Pre-Registrado": "25%",
            "Procesando": "100%",
            "Rechazado": "50%",
            "Requiere Documentación": "75%",
            "Registrado": "100%",
            
        };

        if (resultData.success) {
            if (lblNombreUsuario) lblNombreUsuario.innerText = resultData.nombreUsuario;
            if (lblEstadoUsuario) {
                lblEstadoUsuario.innerText = resultData.estadoUsuario;
                if (resultData.estadoUsuario.trim() === "Requiere Documentación" || resultData.estadoUsuario.trim() === "Solicitud Rechazada") {
                //if (resultData.estadoUsuario === "Requiere Documentación" || resultData.estadoUsuario === "Solicitud Rechazada") {
                    lblObs.style.display = "block";
                    lblObs.innerText = resultData.obs;
                } else if (resultData.estadoUsuario === "Pre-Registrado" || resultData.estadoUsuario === "Procesando" || resultData.estadoUsuario === "Registrado") {
                    lblObs.style.display = "none";
                }
                if (estadoColor[resultData.estadoUsuario]) {
                    progressBarFill.style.backgroundColor = estadoColor[resultData.estadoUsuario];
                    progressBarFill.style.width = estadoAvance[resultData.estadoUsuario];
                    progressBarFill.innerText = estadoAvance[resultData.estadoUsuario];
                }
            }

            tbIdentidad.SetText('');
            popupToken.Hide();
            popupUserStatus.Show();
        } else {
            Swal.fire({
                title: "¡Alerta!",
                text: resultData.message,
                icon: "error",
                confirmButtonColor: "#1F497D"
            });
            if (resultData.message === "Código de verificación incorrecto.") {
                tbToken.SetText('');
            } else if (resultData.message === "El código de verificación ha expirado.") {
                popupToken.Hide();
                tbToken.SetText('');
            } else {
                popupToken.Hide();
                tbToken.SetText('');
            }
        }
    } catch (e) {
        Swal.fire({
            title: "¡Error!",
            text: "Error en la verificación del código. Por favor, inténtelo de nuevo.",
            icon: "error",
            confirmButtonColor: "#1F497D"
        });
    }
}

function validarFormatoCorreo(correo) {
    var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(correo);
}

function validarFormatoIDN(valor) {
    var regex = /^\d{13}$/;
    return regex.test(valor);
}
