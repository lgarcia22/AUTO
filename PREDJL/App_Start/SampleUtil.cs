using System.Web;
using System.Net.Mail;
using System.Configuration;
using System;
using System.IO;
using Glimpse.Core.Extensibility;

namespace PREDJL.App_Start
{
    public class SampleUtil
    {
        public static HttpContext Context
        {
            get
            {
                return HttpContext.Current;
            }
        }
        //private static SmtpClient ConfigureSmtpClient()
        //{
        //    // Configuración del cliente SMTP
        //    SmtpClient client = new SmtpClient
        //    {
        //        Host = ConfigurationManager.AppSettings["emailServiceHost"],
        //        Port = int.Parse(ConfigurationManager.AppSettings["emailServicePort"]),
        //        EnableSsl = bool.Parse(ConfigurationManager.AppSettings["emailServiceEnableSsl"]),
        //        Credentials = new System.Net.NetworkCredential(
        //            ConfigurationManager.AppSettings["emailServiceUserName"],
        //            ConfigurationManager.AppSettings["emailServicePassword"]
        //        )
        //    };
        //    return client;
        //}
        private static SmtpClient ConfigureSmtpClient()
        {
            var host = ConfigurationManager.AppSettings["SMTPNAME"];
            var username = ConfigurationManager.AppSettings["emailServiceUserName"];
            var password = ConfigurationManager.AppSettings["emailServicePassword"];
            var port = int.Parse(ConfigurationManager.AppSettings["SMTPPORT"]);

            SmtpClient smtp = new SmtpClient
            {
                Host = host,
                Port = port,
                EnableSsl = false,
                UseDefaultCredentials = false,
                Credentials = new System.Net.NetworkCredential(username, password),
                DeliveryMethod = SmtpDeliveryMethod.Network
            };

            return smtp;
        }

        private static MailMessage CreateMailMessage(string from, string to, string subject, string body, string cc, MemoryStream stream, string attachmentName)
        {
            MailMessage message = new MailMessage
            {
                From = new MailAddress(from, "Tribunal Superior de Cuentas"),
                Subject = subject,
                Body = body,
                IsBodyHtml = true
            };

            message.To.Add(new MailAddress(to));

            if (!string.IsNullOrEmpty(cc))
            {
                string[] ccId = cc.Split(',');
                foreach (string ccEmail in ccId)
                {
                    message.CC.Add(new MailAddress(ccEmail));
                }
            }

            if (stream != null)
            {
                stream.Seek(0, SeekOrigin.Begin);
                Attachment attachedDoc = new Attachment(stream, attachmentName, "application/pdf");
                message.Attachments.Add(attachedDoc);
            }

            return message;
        }


        //private static MailMessage CreateMailMessage(string from, string to, string subject, string body, string cc, MemoryStream stream, string attachmentName)
        //{
        //    MailMessage mailMessage = new MailMessage
        //    {
        //        From = new MailAddress(from),
        //        Subject = subject,
        //        Body = body,
        //        IsBodyHtml = true
        //    };
        //    mailMessage.To.Add(new MailAddress(to));

        //    if (!string.IsNullOrEmpty(cc))
        //    {
        //        mailMessage.CC.Add(new MailAddress(cc));
        //        //mailMessage.Body += "<br/><br/>Por favor vea el adjunto.";
        //    }

        //    if (stream != null)
        //    {
        //        stream.Position = 0;
        //        Attachment attachment = new Attachment(stream, attachmentName, "application/pdf");
        //        mailMessage.Attachments.Add(attachment);
        //    }

        //    return mailMessage;
        //}

        //private static MailMessage CreateMailMessage(string from, string to, string subject, string body, string cc, MemoryStream stream, string attachmentName)
        //{
        //    MailMessage mailMessage = new MailMessage
        //    {
        //        From = new MailAddress(from),
        //        Subject = subject,
        //        Body = body,
        //        IsBodyHtml = true
        //    };
        //    mailMessage.To.Add(new MailAddress(to));

        //    if (!string.IsNullOrEmpty(cc))
        //    {
        //        mailMessage.CC.Add(new MailAddress(cc));
        //        mailMessage.Body += "<br/><br/>Por favor vea el adjunto.";
        //    }

        //    if (stream != null)
        //    {
        //        stream.Position = 0;
        //        Attachment attachment = new Attachment(stream, attachmentName, "application/pdf");
        //        mailMessage.Attachments.Add(attachment);
        //    }

        //    return mailMessage;
        //}

        public static string GetFileDirectory()
        {
            // Dim dir As String = "C:\APPS WEB INTERNAS\APPS JHMEDINA\SDCE\Files" ' "C:\inetpub\wwwroot\PAGINA_WEB_TSC\SDCE\Files" 'Context.Server.MapPath("~/Files/")
            //string dir = @"C:\inetpub\wwwroot\APP_TSC\SISEDEC\Files\"; // Context.Server.MapPath("~/Files/")
            string dir = Context.Server.MapPath("~/Files/");
           

            if (!System.IO.Directory.Exists(dir))
                System.IO.Directory.CreateDirectory(dir);
            return dir;
        }

        public static bool EnviarCorreo(string Desde, string Subject, string ToEmail, string Body)
        {
            _ = new SmtpClient("SMTPNAME", 2525)
            {
                Credentials = new System.Net.NetworkCredential("sistemadjonline@tsc.gob.hn", "P@SsW0rd"),
                DeliveryMethod = SmtpDeliveryMethod.Network
            };
            _ = new MailMessage("sistemadjonline@tsc.gob.hn", ToEmail)
            {
                Subject = Subject,
                Body = Body
            };
            return true;
        }

        public static bool EnviarCorreo1(string Desde = "", string Subject = "", string ToEmail = "", string Body = "")
        {
            if (Desde is null)
            {
                throw new ArgumentNullException(nameof(Desde));
            }

            string from = ConfigurationManager.AppSettings["emailServiceUserName"];
            string tto = ToEmail;
            string host = ConfigurationManager.AppSettings["SMTPNAME"];
            string username = ConfigurationManager.AppSettings["emailServiceUserName"];
            string password = ConfigurationManager.AppSettings["emailServicePassword"];
            MailMessage Message = new MailMessage();
            SmtpClient Smtp = new SmtpClient();
            System.Net.NetworkCredential SmtpUser = new System.Net.NetworkCredential();

            Message.From = new MailAddress(from, "Tribunal Superior de Cuentas");
            Message.To.Add(new MailAddress(tto));
            Message.IsBodyHtml = true;

            Message.Subject = Subject;
            Message.Body = Body;
            SmtpUser.UserName = username;
            SmtpUser.Password = password;
            Smtp.EnableSsl = false;

            Smtp.UseDefaultCredentials = false;
            Smtp.Credentials = SmtpUser;
            Smtp.Host = host;
            Smtp.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPORT"]);
            Smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            Smtp.Send(Message);
            return true;

        } 
        public static bool EnviarCorreo2(MemoryStream stream,string Desde = "", string Subject = "", string ToEmail = "", string Body = "")
        {
            if (Desde is null)
            {
                throw new ArgumentNullException(nameof(Desde));
            }

            

            string from = ConfigurationManager.AppSettings["emailServiceUserName"];
            string tto = ToEmail;
            string host = ConfigurationManager.AppSettings["SMTPNAME"];
            string username = ConfigurationManager.AppSettings["emailServiceUserName"];
            string password = ConfigurationManager.AppSettings["emailServicePassword"];
            MailMessage Message = new MailMessage();
            stream.Seek(0, System.IO.SeekOrigin.Begin);
            Attachment attachedDoc = new Attachment(stream, "Pre-Registro.pdf", "application/pdf");

            SmtpClient Smtp = new SmtpClient();
            System.Net.NetworkCredential SmtpUser = new System.Net.NetworkCredential();

            Message.From = new MailAddress(from, "Tribunal Superior de Cuentas");
            Message.To.Add(new MailAddress(tto));
            Message.IsBodyHtml = true;
            Message.Attachments.Add(attachedDoc);

            Message.Subject = Subject;
            Message.Body = Body;
            SmtpUser.UserName = username;
            SmtpUser.Password = password;
            Smtp.EnableSsl = false;

            Smtp.UseDefaultCredentials = false;
            Smtp.Credentials = SmtpUser;
            Smtp.Host = host;
            Smtp.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPORT"]);
            Smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
            Smtp.Send(Message);
            return true;
        }


        //public static void EnviarCorreo(Stream pdfStream, string subject, string toEmail, string body, string ccEmail)
        //{
        //    var message = new MailMessage();
        //    message.To.Add(new MailAddress(toEmail));

        //    if (!string.IsNullOrEmpty(ccEmail))
        //    {
        //        message.CC.Add(new MailAddress(ccEmail));
        //    }

        //    message.Subject = subject;
        //    message.Body = string.IsNullOrEmpty(body) ? "Por favor vea el adjunto." : body;

        //    // Código para adjuntar el PDF
        //    var attachment = new Attachment(pdfStream, "Pre-Registro.pdf", "application/pdf");
        //    message.Attachments.Add(attachment);

        //    // Código para enviar el correo (usando SmtpClient, etc.)
        //}
        //public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "")
        //{
        //    try
        //    {
        //        var from = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        SmtpClient Smtp = ConfigureSmtpClient();
        //        MailMessage Message = CreateMailMessage(from, ToEmail, Subject, Body, cc, stream);
        //        Smtp.Send(Message);
        //        return true;
        //    }
        //    catch (Exception)
        //    {
        //        return false; // Indica que el correo no se envió con éxito
        //    }
        //}

        //public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "")
        //{
        //    try
        //    {
        //        var from = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        SmtpClient Smtp = ConfigureSmtpClient();

        //        // Enviar correo principal con plantilla y adjunto
        //        MailMessage mainMessage = CreateMailMessage(from, ToEmail, Subject, Body, null, stream);
        //        Smtp.Send(mainMessage);


        //        // Enviar correo de copia (CC) solo con el adjunto
        //        if (!string.IsNullOrEmpty(cc))
        //        {
        //            MailMessage ccMessage = CreateMailMessage(from, cc, Subject, "Por favor vea el adjunto.", null, stream);
        //            Smtp.Send(ccMessage);
        //        }

        //        return true;
        //    }
        //    catch (Exception)
        //    {
        //        return false; // Indica que el correo no se envió con éxito
        //    }
        //}
        //public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "", string attachmentName = "")
        //{
        //    try
        //    {
        //        var from = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        SmtpClient Smtp = ConfigureSmtpClient();

        //        // Create the main mail message
        //        MailMessage mainMessage = CreateMailMessage(from, ToEmail, Subject, Body, cc, stream, attachmentName);

        //        // Send the email
        //        Smtp.Send(mainMessage);

        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log or handle the exception as needed
        //        Console.WriteLine(ex.Message);
        //        return false; // Indicate that the email was not sent successfully
        //    }
        //}

        //public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "",  string attachmentName = "")
        //{
        //    try
        //    {
        //        var from = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        SmtpClient Smtp = ConfigureSmtpClient();

        //        // Create the main mail message
        //        MailMessage mainMessage = CreateMailMessage(from, Subject, ToEmail, Body, null, stream, attachmentName);

        //        // Add CC recipient with a different body text
        //        if (!string.IsNullOrEmpty(cc))
        //        {
        //            mainMessage.CC.Add(new MailAddress(cc));
        //            mainMessage.Body += "<br/><br/>Por favor vea el adjunto.";
        //        }

        //        // Send the email
        //        Smtp.Send(mainMessage);

        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log or handle the exception as needed
        //        Console.WriteLine(ex.Message);
        //        return false; // Indicate that the email was not sent successfully
        //    }
        //}
        //public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "", string attachmentName = "")
        //{
        //    try
        //    {
        //        var from = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        SmtpClient Smtp = ConfigureSmtpClient();

        //        // Create the main mail message
        //        MailMessage mainMessage = CreateMailMessage(from, ToEmail, Subject, Body, cc, stream, attachmentName);

        //        if (!string.IsNullOrEmpty(cc))
        //        {
        //            mainMessage.CC.Add(new MailAddress(cc));
        //            mainMessage.Body = "<br/><br/>Por favor vea el adjunto.";
        //        }
        //        //Send the email
        //            Smtp.Send(mainMessage);

        //        return true;
        //    }
        //    catch (Exception ex)
        //    {
        //        // Log or handle the exception as needed
        //        Console.WriteLine(ex.Message);
        //        return false; // Indicate that the email was not sent successfully
        //    }
        //}

        public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "", string attachmentName = "")
        {
            if (stream == null || string.IsNullOrWhiteSpace(ToEmail))
            {
                ErrorLogger.LogError(new ArgumentException("El archivo y el correo electrónico de destino no deben ser nulos o vacíos."));
                return false;
            }

            try
            {
                var from = ConfigurationManager.AppSettings["emailServiceUserName"];
                SmtpClient Smtp = ConfigureSmtpClient();

                MailMessage mainMessage = CreateMailMessage(from, ToEmail, Subject, Body, cc, stream, attachmentName);

                if (!string.IsNullOrEmpty(cc))
                {
                    mainMessage.CC.Add(new MailAddress(cc));
                    mainMessage.Body = "<br/><br/>Por favor vea el adjunto.";
                }

                Smtp.Send(mainMessage);
                return true;
            }
            catch (FormatException formatEx)
            {
                ErrorLogger.LogError(new Exception($"Formato de correo inválido: {ToEmail}", formatEx));
            }
            catch (SmtpException smtpEx)
            {
                ErrorLogger.LogError(new Exception($"Error SMTP al enviar el correo a {ToEmail}", smtpEx));
            }
            catch (Exception ex)
            {
                ErrorLogger.LogError(new Exception($"Error desconocido al enviar el correo a {ToEmail}", ex));
            }

            return false; // Indica que el correo no se envió con éxito
        }

        private static string GetEmailBody(string token)
        {
            string templatePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "CodigoVerificacion.html");
            string body = File.ReadAllText(templatePath);
            body = body.Replace("{{token}}", token);
            return body;
        }

        //public static bool SendToken(string email, string token)
        //{
        //    try
        //    {
        //        var from = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        SmtpClient smtp = ConfigureSmtpClient();
        //        string body = GetEmailBody(token);


        //        MailMessage message = CreateMailMessage(from, email, "Su token de verificación", body, null, null, null);
        //        smtp.Send(message);
        //        return true;
        //    }
        //    catch (Exception)
        //    {
        //        return false; // Indica que el correo no se envió con éxito
        //    }
        //}

        public static bool SendToken(string email, string token)
        {
            if (string.IsNullOrWhiteSpace(email) || string.IsNullOrWhiteSpace(token))
            {
                ErrorLogger.LogError(new ArgumentException("El correo electrónico y el token no deben ser nulos o vacíos."));
                return false;
            }

            try
            {
                var from = ConfigurationManager.AppSettings["emailServiceUserName"];
                SmtpClient smtp = ConfigureSmtpClient();
                string body = GetEmailBody(token);

                MailMessage message = CreateMailMessage(from, email, "Su token de verificación", body, null, null, null);
                smtp.Send(message);
                return true;
            }
            catch (FormatException formatEx)
            {
                ErrorLogger.LogError(new Exception($"Formato de correo inválido: {email}", formatEx));
            }
            catch (SmtpException smtpEx)
            {
                ErrorLogger.LogError(new Exception($"Error SMTP al enviar el correo a {email}", smtpEx));
            }
            catch (Exception ex)
            {
                ErrorLogger.LogError(new Exception($"Error desconocido al enviar el correo a {email}", ex));
            }

            return false; // Indica que el correo no se envió con éxito
        }

        //public static void SendEmails(string emailList)
        //{
        //    try
        //    {
        //        var emails = emailList.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

        //        foreach (var email in emails)
        //        {
        //            if (!SendNotification(email))
        //            {
        //                // Manejo del error si el correo no se envía
        //                ErrorLogger.LogError(new Exception($"Error al enviar el correo a {email}"));
        //                // Aquí podrías registrar el error de alguna otra manera si lo deseas
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ErrorLogger.LogError(ex);
        //        // Manejo adicional de errores si es necesario
        //    }
        //}
        public static void SendEmails(string emailList)
        {
            if (string.IsNullOrWhiteSpace(emailList))
            {
                ErrorLogger.LogError(new ArgumentException("La lista de correos no debe ser nula o vacía."));
                return;
            }

            var emails = emailList.Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            int maxRetryAttempts = 3;
            int delayBetweenRetries = 2000; // 2000 milliseconds (2 seconds)

            foreach (var email in emails)
            {
                int retryAttempt = 0;
                bool isSuccess = false;

                while (retryAttempt < maxRetryAttempts && !isSuccess)
                {
                    try
                    {
                        if (!SendNotification(email))
                        {
                            throw new InvalidOperationException($"Error al enviar el correo a {email}");
                        }
                        isSuccess = true; // If SendNotification succeeds, mark as success
                    }
                    catch (FormatException formatEx)
                    {
                        ErrorLogger.LogError(new Exception($"Formato de correo inválido: {email}", formatEx));
                        break; // Exit loop on FormatException as it won't succeed on retry
                    }
                    catch (SmtpException smtpEx)
                    {
                        retryAttempt++;
                        if (retryAttempt >= maxRetryAttempts)
                        {
                            ErrorLogger.LogError(new Exception($"Error SMTP al enviar el correo a {email} después de {maxRetryAttempts} intentos", smtpEx));
                        }
                        else
                        {
                            ErrorLogger.LogError(new Exception($"Error SMTP al enviar el correo a {email}. Reintentando... ({retryAttempt}/{maxRetryAttempts})", smtpEx));
                            System.Threading.Thread.Sleep(delayBetweenRetries); // Delay before retrying
                        }
                    }
                    catch (Exception ex)
                    {
                        ErrorLogger.LogError(new Exception($"Error desconocido al enviar el correo a {email}", ex));
                        break; // Exit loop on general exception
                    }
                }
            }
        }


        public static bool SendNotification(string email)
        {
            try
            {
                var from = ConfigurationManager.AppSettings["emailServiceUserName"];
                SmtpClient smtp = ConfigureSmtpClient();
                string body = GetBody();

                MailMessage message = CreateMailMessage(from, email, "Notificación de Creación Usuario", body, null, null, null);
                smtp.Send(message);
                return true;
            }
            catch (Exception)
            {
                return false; // Indica que el correo no se envió con éxito
            }
        }

        private static string GetBody()
        {
            string templatePath = Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "MensajeCorreo.html");
            string body = File.ReadAllText(templatePath);
            // Reemplaza cualquier marcador de posición en la plantilla con el mensaje real
         
            return body;
        }

        //public static bool EnviarCorreo(MemoryStream stream, string Subject = "", string ToEmail = "", string Body = "", string cc = "")
        //{
        //    try
        //    {
        //        var from = "";
        //        var tto = "";
        //        var host = "";
        //        var username = "";
        //        var password = "";
        //        from = System.Configuration.ConfigurationManager.AppSettings["emailServiceUserName"];
        //        tto = ToEmail;
        //        host = ConfigurationManager.AppSettings["SMTPNAME"];
        //        username = ConfigurationManager.AppSettings["emailServiceUserName"];
        //        password = ConfigurationManager.AppSettings["emailServicePassword"];
        //        MailMessage Message = new MailMessage();
        //        stream.Seek(0, System.IO.SeekOrigin.Begin);
        //        Attachment attachedDoc = new Attachment(stream, "Pre_Registro.pdf", "application/pdf");


        //        SmtpClient Smtp = new SmtpClient();
        //        System.Net.NetworkCredential SmtpUser = new System.Net.NetworkCredential();
        //        Message.From = new MailAddress(from, "Declaración Jurada en Linea");
        //        string[] CCId = cc.Split(',');
        //        foreach (string CCEmail in CCId)
        //        {
        //            Message.CC.Add(new MailAddress(CCEmail));
        //        }
        //        Message.To.Add(new MailAddress(tto));
        //        Message.IsBodyHtml = true;
        //        Message.Subject = Subject;
        //        Message.Body = Body;
        //        Message.Attachments.Add(attachedDoc);
        //        SmtpUser.UserName = username;
        //        SmtpUser.Password = password;
        //        Smtp.EnableSsl = false;
        //        // Message.Subject.d

        //        Smtp.UseDefaultCredentials = false;
        //        Smtp.Credentials = SmtpUser;
        //        Smtp.Host = host;
        //        Smtp.Port = int.Parse(ConfigurationManager.AppSettings["SMTPPORT"]);
        //        Smtp.DeliveryMethod = SmtpDeliveryMethod.Network;
        //        Smtp.Send(Message);
        //        return true;

        //    }
        //    catch (Exception ex)
        //    {
        //        return false; // Indica que el correo no se envió con éxito


        //    }




        //}
    }
}