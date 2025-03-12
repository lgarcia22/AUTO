//    function toUpperCase(id) {
//        var textbox = document.getElementById(id);
//        textbox.value = textbox.value.toUpperCase();
//}

//function convierteTextoAMayusculas(s, e) {
//    s.inputElement.value = s.inputElement.value.toUpperCase();
//}


function checkScreenSize() {
    var isMobile = window.innerWidth <= 500;
    if (isMobile) {
        var viewer = ASPxClientControl.GetControlCollection().GetByName("ASPxWebDocumentViewer1");
        if (viewer && typeof viewer.MobileMode === 'function') {
            viewer.MobileMode(true);
        }
    }
}

function onDocumentViewerInit() {
    checkScreenSize();
}

// Run the function on page load
window.onload = function () {
    onDocumentViewerInit();
};

// Optionally, you can also add an event listener for window resize
window.onresize = function () {
    checkScreenSize();
};

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
    //} else if (id.length === 8 && isAlphanumeric(id)) {
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

function CustomValidateCelular(s, e) {
    var celular = s.GetText();
    if (celular.length < 8 || !/^\d+$/.test(celular)) {
        e.isValid = false;
        e.errorText = "El campo debe contener números y 8 dígitos.";
    } else {
        e.isValid = true;
    }
}

    function OnCountryChanged(selectedValue) {
        cmbCity.PerformCallback(selectedValue);
         }
    function OnCountryChanged2(selectedValue) {
        cmbCity2.PerformCallback(selectedValue);
         }
    function ShowRelacionado() {
        Relacionado.Show();
         }
    function ShowEnviar() {
        Enviar.Show();
        //tbcorreo2.Focus();
    }
 
    function onClick(s, e) {
        callback.PerformCallback(fileNameLabel.GetText());
         }
    function onCallbackComplete(s, e) {
             if (e.result == "OK") {
        fileNameLabel.SetText(null);
    deleteFileButton.SetVisible(false);
    AddFileButton.SetVisible(false);
             }
         }
function UpdateUploadButton() {
    var isAnyFileSelected = false;
    for (var i = 0; i < uploadControl.GetFileInputCount(); i++) {
        if (uploadControl.GetText(i) != "") { isAnyFileSelected = true; break; }
    }
    btnUploadViaPostback.SetEnabled(isAnyFileSelected);
    //        /* btnUploadViaCallback.SetEnabled(isAnyFileSelected);*/
    //}
}
//function btnEnviarCodigo_Click(s, e) {
//    var campos = [
//        tbNombre.GetText(),
//        tbApellido.GetText(),
//        tbCorreo.GetText(),
//        tbConfirmCorreo.GetText(),
//        tbDependencia.GetText(),
//        CmbCountry.GetText(),
//        //CmbTipoDeclaracion.GetText(),
//        tbIdentidad.GetText()
//    ];

//    var camposVacios = campos.some(function (valor) {
//        return valor === '' || valor === null;
//    });

//    if (camposVacios) {
//        Swal.fire({
//            title: "¡Alerta!",
//            text: "Debe llenar los datos requeridos del formulario para hacer el envio del código de verificación",
//            icon: "warning",
//            confirmButtonColor: "#1F497D",
//        });
//    } else {
//        // Enviar el token al correo
//        var email = tbCorreo.GetText();
//        if (validarFormatoCorreo(email)) {
//            // Llamar al servidor para enviar el token
//            ASPxCallback_EnviarToken.PerformCallback(email);
//            popupToken.Show();
//        } else {
//                  Swal.fire({
//            title: "¡Alerta!",
//            text: "Por favor ingrese un correo electrónico válido.",
//            icon: "warning",
//            confirmButtonColor: "#1F497D",
//        });
//            //alert('Por favor ingrese un correo electrónico válido.');
//        }
//    }
//}
function btnEnviarCodigo_Click(s, e) {
    // Lista de campos a validar
    var campos = [
        { control: tbNombre, valor: tbNombre.GetText(), mensaje: "Los Nombres son requeridos y solo pueden contener letras y espacios." },
        { control: tbApellido, valor: tbApellido.GetText(), mensaje: "Los Apellidos son requeridos y solo pueden contener letras y espacios." },
        { control: tbIdentidad, valor: tbIdentidad.GetText(), mensaje: "El campo de identidad es requerido y solo puede contener números." },
        { control: tbCelular, valor: tbCelular.GetText(), mensaje: "El campo de teléfono es requerido y solo puede contener números." },
        { control: tbCorreo, valor: tbCorreo.GetText(), mensaje: "El correo electrónico es requerido y debe tener un formato válido." },
        { control: tbConfirmCorreo, valor: tbConfirmCorreo.GetText(), mensaje: "La confirmación del correo electrónico es requerida." },
        { control: tbDependencia, valor: tbDependencia.GetText(), mensaje: "La dependencia es requerida." },
        { control: CmbCountry, valor: CmbCountry.GetText(), mensaje: "El país es requerido." }
    ];

    // Revisa si alguno de los campos está vacío o es null
    var camposVacios = campos.some(function (campo) {
        return campo.valor === '' || campo.valor === null;
    });

    if (camposVacios) {
        Swal.fire({
            title: "¡Alerta!",
            text: "Debe llenar los datos requeridos del formulario para hacer el envío del código de verificación.",
            icon: "warning",
            confirmButtonColor: "#1F497D",
        });
        return; // Detener la ejecución si hay campos vacíos
    }

    // Validar que el campo tbNombre solo contenga letras y espacios
    var valorNombre = tbNombre.GetText();
    if (!validarSoloLetras(valorNombre)) {
        mostrarErrorYEnfocar(tbNombre, "Los Nombres del Empleado solo pueden contener letras y espacios.");
        return;
    }

    // Validar que el campo tbApellido solo contenga letras y espacios
    var valorApellido = tbApellido.GetText();
    if (!validarSoloLetras(valorApellido)) {
        mostrarErrorYEnfocar(tbApellido, "Los Apellidos del Empleado solo pueden contener letras y espacios.");
        return;
    }

    // Validar que el campo tbIdentidad solo contenga números
    var valorIdentidad = tbIdentidad.GetText();
    if (!validarFormatoIDN(valorIdentidad)) {
        mostrarErrorYEnfocar(tbIdentidad, "El campo de identidad solo puede contener números.");
        return;
    }

    // Validar que el campo tbCelular solo contenga números
    var valorCelular = tbCelular.GetText();
    if (!validarSoloNumeros(valorCelular)) {
        mostrarErrorYEnfocar(tbCelular, "El campo de teléfono solo puede contener números.");
        return;
    }

    // Validar que el campo tbCelular tenga al menos 8 dígitos
    if (valorCelular.length < 8) {
        mostrarErrorYEnfocar(tbCelular, "El número de teléfono debe tener al menos 8 dígitos.");
        return;
    }

    // Validar el formato del correo electrónico
    var email = tbCorreo.GetText();
    if (!validarFormatoCorreo(email)) {
        mostrarErrorYEnfocar(tbCorreo, "Por favor ingrese un correo electrónico válido.");
        return;
    }

    // Si todas las validaciones pasan, enviar el token al correo
    ASPxCallback_EnviarToken.PerformCallback(email);
    popupToken.Show();
}

// Función para mostrar un mensaje de error y enfocar el campo correspondiente
function mostrarErrorYEnfocar(control, mensaje) {
    Swal.fire({
        title: "¡Error!",
        text: mensaje,
        icon: "error",
        confirmButtonColor: "#1F497D",
    }).then(() => {
        control.SetFocus(); // Enfocar el campo
    });
}

// Función para mostrar un mensaje de error y enfocar el campo correspondiente
function mostrarErrorYEnfocar(control, mensaje) {
    Swal.fire({
        title: "¡Error!",
        text: mensaje,
        icon: "error",
        confirmButtonColor: "#1F497D",
    }).then(() => {
        control.SetFocus(); // Enfocar el campo
    });
}
    function btnVerificarToken_Click(s, e) {
               // Verificar el token ingresado
        var inputToken = tbToken.GetText();

        // Validamos si el código ha sido ingresado
        if (tbToken.GetText() === "") {
            Swal.fire({
                title: "¡Alerta!",
                text: "El código de verificación es obligatorio. Por favor, ingrese el código enviado a su correo.",
                icon: "warning",
                confirmButtonColor: "#1F497D",
            });
            // No llamamos a popupToken.Show() porque ya está visible
            return; // Detenemos la ejecución si el campo está vacío
        }

        // Realizar la llamada de verificación
        //ASPxCallback_VerificarToken.PerformCallback();
    ASPxCallback_VerificarToken.PerformCallback(inputToken);
    }

    function TokenVerificationComplete(result) {
    if (result === "success") {
    popupToken.Hide();
    ckPolitica.SetVisible(true); // Hacer visible el checkbox después de la verificación exitosa
    ckPolitica.SetChecked(false);
    btnEnviarCodigo.SetVisible(false); // Ocultar el botón después de la verificación exitosa
    tbToken.SetText('');
    } else if (result === "incorrect") {
        Swal.fire({
            title: "¡Alerta!",
            text: "Código de verificación incorrecto. Por favor, inténtelo de nuevo.",
            icon: "warning",
            confirmButtonColor: "#1F497D",
        });
        //alert('Código de verificación incorrecto. Por favor, inténtelo de nuevo.');
    tbToken.SetText('');
                   // No cerramos el popupToken si el código es incorrecto
    } else if (result === "expired") {
        Swal.fire({
            title: "¡Alerta!",
            text: "El código de verificación ha expirado. Por favor, solicite un nuevo código.",
            icon: "warning",
            confirmButtonColor: "#1F497D",
        });
        //alert('El código de verificación ha expirado. Por favor, solicite un nuevo código.');
    popupToken.Hide(); // Cerrar el popupToken si el código ha expirado
    tbToken.SetText('');
    } else {
        Swal.fire({
            title: "¡Alerta!",
            text: "Error en la verificación del código. Por favor, inténtelo de nuevo.",
            icon: "warning",
            confirmButtonColor: "#1F497D",
        });
        //alert('Error en la verificación del código. Por favor, inténtelo de nuevo.');
    popupToken.Hide(); // Cerrar el popupToken en caso de error general
    tbToken.SetText('');
               }
           }

        //function Guardar_Datos_Complete(s, e) {
        //    var respuestaJSON = e.result;
        //    var respuesta = JSON.parse(respuestaJSON);
        //    var Retorno = respuesta.Retorno;
        //    var Mens = respuesta.Mensaje;

        //    //console.log('Respuesta:', respuesta); // Debug: Imprimir la respuesta en consola

        //    if (Retorno == 1) {
        //        Enviar.Hide();
        //        //Lbl_msg.SetText(Mens);
        //        setTimeout(function () {
        //            Relacionado.Show();
        //        }, 100);
        //        //Relacionado.Show();
        //        ckPolitica.SetVisible(false); // Ocultar el checkbox después de mostrar el comprobante
        //        ckPolitica.SetChecked(false);
        //        ASPxButton2.SetEnabled(false);
        //        // Si es necesario, podrías agregar una notificación o cambiar el texto del botón
        //        //ASPxButton2.SetText('Procesando...');
        //        btnEnviarCodigo.SetVisible(true); // Hacer visible el botón después de mostrar el comprobante
        //        SetCampos();
        //    } else {
        //        ckPolitica.SetChecked(false);
        //        Enviar.Hide();
        //        if (Mens.includes('Su usuario ya existe. Puede contactarnos llamando al número 2230-8789 o enviando un correo electrónico a dj@tsc.gob.hn o mesadeayudadj@tsc.gob.hn')) {
        //            //console.log('Correo electrónico ya existe.'); // Debug: Imprimir mensaje en consola
        //            btnEnviarCodigo.SetVisible(true);
        //            ckPolitica.SetVisible(false);
        //        }
        //        Swal.fire({
        //            title: "¡Alerta!",
        //            html: Mens,
        //            icon: "error",
        //            confirmButtonColor: "#1F497D",
        //        }).then(() => {
        //            // Acción después de cerrar la alerta
        //            if (Mens.includes("El correo electrónico ya existe")) {
        //                btnEnviarCodigo.SetVisible(true);
        //                ckPolitica.SetVisible(false);
        //            }
        //        });
        //    }
        //}





           // Añade un event listener para asegurarte de que los elementos se manipulen después de que el DOM esté completamente cargado
           window.onload = function () {
               if (btnEnviarCodigo) {
        console.log('btnEnviarCodigo is loaded');
               } else {
        console.error('btnEnviarCodigo is not found');
               }

    if (ckPolitica) {
        console.log('ckPolitica is loaded');
               } else {
        console.error('ckPolitica is not found');
               }
           };

    //function ClosePopupRelacionado(s, e) {
    //            //Mostrar cuadro de diálogo de confirmación
    //           var confirmar = confirm("¿Está seguro de cerrar el comprobante? Asegúrese de haberlo descargado primero.");

    ////Si el usuario hace clic en "OK", se permite que el evento de cierre continúe en el servidor
    //if (confirmar) {
    //    //Puedes establecer alguna bandera aquí o simplemente permitir que el evento continúe
    //    e.processOnServer = true;
    //Relacionado.Hide();
    //           }
    ////Si el usuario hace clic en "Cancelar", se cancela el evento de cierre
    //else {
    //    //Detener el procesamiento del evento de cierre
    //    e.processOnServer = false;
    //Relacionado.Show();
    //           }
    //       }
function ClosePopupRelacionado(s, e) {
    // Mostrar cuadro de diálogo de confirmación usando SweetAlert
    Swal.fire({
        title: "¿Está seguro de cerrar el comprobante?",
        text: "Asegúrese de haberlo descargado primero.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#3085d6",
        cancelButtonColor: "#d33",
        confirmButtonText: "Sí, cerrar",
        cancelButtonText: "Cancelar"
    }).then((result) => {
        // Si el usuario hace clic en "Sí, cerrar"
        if (result.isConfirmed) {
            e.processOnServer = true;
            Relacionado.Hide();
        }
        // Si el usuario hace clic en "Cancelar"
        else {
            e.processOnServer = false;
            Relacionado.Show();
        }
    });
}



    function SetCampos() {
        tbNombre.SetText(''),
        tbApellido.SetText(''),
        tbCorreo.SetText(''),
        tbConfirmCorreo.SetText(''),
        tbDependencia.SetText(''),
        tbFechaIngreso.SetText(''),
        tbCelular.SetText(''),
        CmbCountry.SetText(''),
        //CmbTipoDeclaracion.SetText(''),
        tbIdentidad.SetText(''),
        ckPolitica.SetChecked(false);
               
     }


    function validarFormatoCorreo(correo) {
               var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    return regex.test(correo);
           }


function validarFormatoIDN(valor) {
    // DNI: 13 dígitos numéricos
    if (/^\d{13}$/.test(valor)) {
        return true;
    }
    // Pasaporte o carnet de residencia: 9 caracteres alfanuméricos
    if (/^[a-zA-Z0-9]{6,9}$/.test(valor)) {
        return true;
    }
    return false;
}

function isValidString(value) {
    // Expresión regular que permite solo letras, "-" y "/"
    const regex = /^[a-zA-Z\-/]+$/;
    return regex.test(value);
}
function Terminos(s, e) {
    // Desactivar el botón si el checkbox no está marcado
    if (!s.GetChecked()) {
        ASPxButton2.SetEnabled(false);
        return; // Detener la ejecución adicional de la función
    }

    // Lista de campos a validar
    var campos = [
        tbNombre.GetText(),
        tbApellido.GetText(),
        tbCorreo.GetText(),
        tbDependencia.GetText(),
        CmbCountry.GetText(),
        tbIdentidad.GetText(),
        tbCelular.GetText(), // Asegúrate de que este es el ID correcto para el campo de teléfono
    ];

    // Revisa si alguno de los campos está vacío o es null
    var camposVacios = campos.some(function (valor) {
        return valor === '' || valor === null;
    });

    if (camposVacios) {
        Swal.fire({
            title: "¡Alerta!",
            text: "Debe de llenar los datos requeridos del formulario para enviar la solicitud del Auto Enrolamiento",
            icon: "warning",
            confirmButtonColor: "#1F497D",
        });
        ckPolitica.SetChecked(false);
        console.log(campos); // Esto imprimirá los valores de los campos, podrías quitarlo si no es necesario
        return;
    } else {
        // Validar que el campo tbIdentidad solo contenga números
        var valorIdentidad = tbIdentidad.GetText();
        if (!validarFormatoIDN(valorIdentidad)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de identidad solo puede contener números.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbIdentidad.SetFocus();
            ckPolitica.SetChecked(false);
            return;
        }

        // Validar que el campo tbCelular solo contenga números
        var valorCelular = tbCelular.GetText();
        if (!validarSoloNumeros(valorCelular)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de teléfono solo puede contener números.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbCelular.SetFocus();
            ckPolitica.SetChecked(false);
            return;
        }

        // Validar que el campo tbNombre solo contenga letras y espacios
        var valorNombre = tbNombre.GetText();
        if (!validarSoloLetras(valorNombre)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de nombre solo puede contener letras y espacios.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbNombre.SetFocus();
            ckPolitica.SetChecked(false);
            return;
        }

        // Validar que el campo tbApellido solo contenga letras y espacios
        var valorApellido = tbApellido.GetText();
        if (!validarSoloLetras(valorApellido)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de apellido solo puede contener letras y espacios.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbApellido.SetFocus();
            ckPolitica.SetChecked(false);
            return;
        }

        // Validar el formato del valor de identidad (si es necesario)
        if (!validarFormatoIDN(valorIdentidad)) {
            tbIdentidad.SetFocus();
            ckPolitica.SetChecked(false);
            return;
        }

        // Validar el formato del correo electrónico
        var correo = tbCorreo.GetText();
        if (!validarFormatoCorreo(correo)) {
            tbCorreo.SetFocus(); // Enfocar el campo de correo electrónico
            ckPolitica.SetChecked(false);
            return;
        }

        // Si todo está correcto, habilitar el botón y continuar
        ShowEnviar(); // Función para mostrar la opción de enviar o algo relacionado
        ASPxButton2.SetEnabled(true);
        console.log(campos);
    }
}
    //function Terminos(s, e) {
    //           // Desactivar el botón si el checkbox no está marcado
    //           if (!s.GetChecked()) {
    //    ASPxButton2.SetEnabled(false);
    //return; // Detener la ejecución adicional de la función
    //           }

    //// Lista de campos a validar
    //var campos = [
    //tbNombre.GetText(),
    //tbApellido.GetText(),
    //tbCorreo.GetText(),
    //tbDependencia.GetText(),
    //CmbCountry.GetText(),
    ////CmbTipoDeclaracion.GetText(),
    //tbIdentidad.GetText(),
    //];

    //// Revisa si alguno de los campos está vacío o es null
    //var camposVacios = campos.some(function (valor) {
    //               return valor === '' || valor === null;
    //           });

    //if (camposVacios) {
    //    Swal.fire({
    //        title: "¡Alerta!",
    //        text: "Debe de llenar los datos requeridos del formulario para enviar la solicitud del Auto Enrolamiento",
    //        icon: "warning",
    //        //showCancelButton: true,
    //        confirmButtonColor: "#1F497D",
    //        /*cancelButtonColor: "#d33",*/

    //    });
    //ckPolitica.SetChecked(false);
    ////alert("¡Alerta! Debe de llenar los datos requeridos del formulario para enviar la solicitud del Pre-registro");
    //console.log(campos); // Esto imprimirá los valores de los campos, podrías quitarlo si no es necesario
    //           }
    //else
    //{

    //               if (tbIdentidad.GetText() === '') {
    //    tbIdentidad.SetFocus();
    //ckPolitica.SetChecked(false);
    //return;
    //               }

    //var valor = tbIdentidad.GetText(); // Suponiendo que tbIdentidad.GetText() obtiene el valor del campo de entrada de texto

    //////// Validar el formato del valor
    //if (!validarFormatoIDN(valor)) {
    //    tbIdentidad.SetFocus();
    //ckPolitica.SetChecked(false);
    //return;
    //               }


    //var correo = tbCorreo.GetText();
    //if (!validarFormatoCorreo(correo)) {
    //    tbCorreo.SetFocus();// Enfocar el campo de correo electrónico
    //ckPolitica.SetChecked(false);
    //return;
    //               }


    //ShowEnviar(); // Función para mostrar la opción de enviar o algo relacionado
    //ASPxButton2.SetEnabled(true);
    //console.log(campos);
    //           }
               
    //       }

    //function BtnGuardar_Click(s, e) {

    //    ASPxCallback_Guardar_Datos.PerformCallback();
               
    //       }
var isProcessing = false; // Indicador de estado para evitar ejecución múltiple
function BtnGuardar_Click(s, e) {
    // Verificar que no se esté procesando ya una solicitud
    if (!isProcessing) {
        isProcessing = true; // Indica que el proceso ha comenzado
        Enviar.Hide();
        ASPxButton2.SetEnabled(false);

        // Validar que el campo tbIdentidad solo contenga números
        var valorIdentidad = tbIdentidad.GetText();
        if (!validarFormatoIDN(valorIdentidad)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de identidad solo puede contener números.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbIdentidad.SetFocus();
            ckPolitica.SetChecked(false);
            isProcessing = false; // Reiniciar el estado de procesamiento
            return;
        }

        // Validar que el campo tbCelular solo contenga números
        var valorCelular = tbCelular.GetText();
        if (!validarSoloNumeros(valorCelular)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de teléfono solo puede contener números.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbCelular.SetFocus();
            ckPolitica.SetChecked(false);
            isProcessing = false; // Reiniciar el estado de procesamiento
            return;
        }

        // Validar que el campo tbNombre solo contenga letras y espacios
        var valorNombre = tbNombre.GetText();
        if (!validarSoloLetras(valorNombre)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de nombre solo puede contener letras y espacios.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbNombre.SetFocus();
            ckPolitica.SetChecked(false);
            isProcessing = false; // Reiniciar el estado de procesamiento
            return;
        }

        // Validar que el campo tbApellido solo contenga letras y espacios
        var valorApellido = tbApellido.GetText();
        if (!validarSoloLetras(valorApellido)) {
            Swal.fire({
                title: "¡Error!",
                text: "El campo de apellido solo puede contener letras y espacios.",
                icon: "error",
                confirmButtonColor: "#1F497D",
            });
            tbApellido.SetFocus();
            ckPolitica.SetChecked(false);
            isProcessing = false; // Reiniciar el estado de procesamiento
            return;
        }

        // Llamar al callback para procesar la solicitud
        ASPxCallback_Guardar_Datos.PerformCallback();
    }
}
//function BtnGuardar_Click(s, e) {
//    // Deshabilitar el botón para evitar múltiples clics
//    if (!isProcessing) {
//        isProcessing = true; // Indica que el proceso ha comenzado
//        Enviar.Hide();
//        ASPxButton2.SetEnabled(false);
//        //ASPxButton2.SetText('Procesando...');

//        // Llamar al callback para procesar la solicitud
//        ASPxCallback_Guardar_Datos.PerformCallback();
//    }
//}


function Guardar_Datos_Complete(s, e) {
    // Si el proceso ya fue completado, no ejecutar de nuevo
    if (isProcessing) {
        var respuestaJSON = e.result;
        var respuesta = JSON.parse(respuestaJSON);
        var Retorno = respuesta.Retorno;
        var Mens = respuesta.Mensaje;

        if (Retorno == 1) {
            Enviar.Hide();
            setTimeout(function () {
                Relacionado.Show();
            }, 100);
            ckPolitica.SetVisible(false);
            ckPolitica.SetChecked(false);
            btnEnviarCodigo.SetVisible(true);
            SetCampos();
        } else {
            ckPolitica.SetChecked(false);
            Enviar.Hide();
            if (Mens.includes('Su usuario ya existe. Puede contactarnos llamando al número 2230-8789 o enviando un correo electrónico a dj@tsc.gob.hn o mesadeayudadj@tsc.gob.hn')) {
                btnEnviarCodigo.SetVisible(true);
                ckPolitica.SetVisible(false);
            }
            Swal.fire({
                title: "¡Alerta!",
                html: Mens,
                icon: "error",
                confirmButtonColor: "#1F497D",
            }).then(() => {
                if (Mens.includes("El correo electrónico ya existe")) {
                    btnEnviarCodigo.SetVisible(true);
                    ckPolitica.SetVisible(false);
                }
            });
        }
        // Reiniciar el estado de procesamiento
        isProcessing = false;
    }
}

    function popup_Shown_comprobante(s, e) {
        callbackPane_comprobante.PerformCallback();
           }

        //para guardar los docuementos
        function Click_Add_Dtos(s, e) {
            ASPxCallback_Guardar_Dctos.PerformCallback();
            ASPxGridView1.PerformCallback();

        }

         
        function Guardar_Dctos_Complete(s, e) {
        ASPxGridView1.PerformCallback();
    /*   alert(e.result);*/

    fileNameLabel.SetText(null);
    deleteFileButton.SetVisible(false);
    AddFileButton.SetVisible(false);

    return;
        }

    //function onClick(s, e) {
    //    callback.PerformCallback(fileNameLabel.GetText());
    //        }
    //function onCallbackComplete(s, e) {
    //            if (e.result == "OK") {
    //    fileNameLabel.SetText(null);
    //                //deleteFileButton.SetVisible(false);
    //                //AddFileButton.SetVisible(false);
    //            }
    //        }

    //function onFileUploadComplete(s, e) {
    //            if (e.callbackData) {
    //                // Parsea la información almacenada en el sessionStorage
    //                var fileList = e.callbackData.split("|");

    //// Construye la tabla HTML
    //var tableHTML = '<table border="1" class="table table-striped" style="width:100%"><tr style="background-color: #156ab3; color: white;"><th>Nombre de archivo</th></tr>';

    //    for (var i = 0; i < fileList.length; i++) {
    //        // Utiliza un atributo de datos para almacenar el fileId en el ícono de eliminar
    //        tableHTML += '<tr><td>' + fileList[i] + '</td></tr>';
    //                }

    //    tableHTML += '</table>';

    //// Inserta la tabla en un contenedor HTML, por ejemplo, un div con el id "fileListContainer"
    //document.getElementById("fileListContainer").innerHTML = tableHTML;

    //// Almacena la información en el sessionStorage para que persista durante la sesión actual
    //sessionStorage.setItem("fileList", e.callbackData);
    //            }
    //        }

    //// Recupera la información almacenada al cargar la página
    //window.onload = function () {
    //            var storedFileList = sessionStorage.getItem("fileList");

    //if (storedFileList) {
    //    // Realiza el mismo proceso de construcción de la tabla al cargar la página
    //    onFileUploadComplete(null, { callbackData: storedFileList });

    //// Elimina la información del sessionStorage después de cargar la página
    //sessionStorage.removeItem("fileList");
    //            }
    //        }


    //function solonumeros(e) {

    //            var key;

    //if (window.event) // IE
    //{
    //    key = e.keyCode;
    //            }
    //else if (e.which) // Netscape/Firefox/Opera
    //{
    //    key = e.which;
    //            }

    //if (key < 48 || key > 57) {
    //                return false;
    //            }

    //return true;
    //        }

function soloLetrasYCaracteresEspeciales(e) {
    var key;

    // Obtener el código de la tecla presionada
    if (window.event) { // IE
        key = e.keyCode;
    } else if (e.which) { // Netscape/Firefox/Opera
        key = e.which;
    }

    // Verificar si es una letra (mayúscula o minúscula), un guion (-) o una barra (/)
    if (
        (key >= 65 && key <= 90) || // Letras mayúsculas (A-Z)
        (key >= 97 && key <= 122) || // Letras minúsculas (a-z)
        key === 45 || // Guion (-)
        key === 47 || // Barra (/)
        key === 8 || // Tecla de retroceso (Backspace)
        key === 46 || // Tecla de eliminar (Delete)
        key === 9 // Tecla de tabulación (Tab)
    ) {
        return true; // Permitir la tecla
    }

    return false; // Bloquear la tecla
}

function solonumeros(e) {
    var key;

    if (window.event) { // IE
        key = e.keyCode;
    } else if (e.which) { // Netscape/Firefox/Opera
        key = e.which;
    }

    if (key < 48 || key > 57) {
        return false;
    }

    return true;
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

//function validarNumeroTelefono(input) {
//    // Limpiar el valor del input para que solo contenga números
//    input.value = input.value.replace(/\D/g, '');
//}

//document.getElementById('tbCelular').addEventListener('input', function () {
//    validarNumeroTelefono(this);
//});

function validarSoloNumeros(valor) {
    // Expresión regular para verificar que el valor solo contenga números
    return /^\d+$/.test(valor);
}

function validarSoloLetras(valor) {
    // Expresión regular para verificar que el valor solo contenga letras y espacios
    return /^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$/.test(valor);
}
// Validar el formato del correo electrónico
function validarFormatoCorreo(email) {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
}

function CustomValidateNombre(s) {
    var nombre = s.GetText();
    if (!/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$/.test(nombre)) {
        s.SetIsValid(false);
        s.SetErrorText("El campo solo puede contener letras y espacios.");
    } else {
        s.SetIsValid(true);
    }
}

function CustomValidateApellido(s) {
    var apellido = s.GetText();
    if (!/^[A-Za-zÁÉÍÓÚáéíóúÑñ\s]+$/.test(apellido)) {
        s.SetIsValid(false);
        s.SetErrorText("El campo solo puede contener letras y espacios.");
    } else {
        s.SetIsValid(true);
    }
}

function soloLetrasYEspacios(e) {
    var key;
    if (window.event) { // IE
        key = e.keyCode;
    } else if (e.which) { // Netscape/Firefox/Opera
        key = e.which;
    }

    // Permitir letras, espacios y caracteres especiales (á, é, í, ó, ú, ñ, etc.)
    if (!(key >= 65 && key <= 90) && !(key >= 97 && key <= 122) && key !== 32 && key !== 209 && key !== 241) {
        return false;
    }
    return true;
}