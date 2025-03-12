<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ReportDenuncia.aspx.cs" Inherits="PREDJL.Reportes.ReportDenuncia" %>

<%@ Register assembly="DevExpress.XtraReports.v21.2.Web.WebForms, Version=21.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraReports.Web" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

       <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
       <meta name="viewport" content="width=device-width, user-scalable=no, maximum-scale=1.0, minimum-scale=1.0" />
      <!-- mobile metas -->
      <meta name="viewport" content="width=device-width, initial-scale=1"/>
      <meta name="viewport" content="initial-scale=1, maximum-scale=1"/>
    <title>Copia de Denuncia</title>
      <link href="../css/responsive.css" rel="stylesheet" />
    <link href="../Content/Content.css" rel="stylesheet" />
    <link href="../Content/Layout.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
     <dx:ASPxFormLayout runat="server" ID="formDenuncia" CssClass="formLayout">
         <SettingsAdaptivity AdaptivityMode="SingleColumnWindowLimit" SwitchToSingleColumnAtWindowInnerWidth="700" />
            <Items>
                <dx:LayoutItem ShowCaption="False">
                            <LayoutItemNestedControlCollection>
                                <dx:LayoutItemNestedControlContainer>
                                            <dx:ASPxWebDocumentViewer ID="ASPxWebDocumentViewer1" runat="server" ReportTypeName="PREDJL.DenunciaReport" Width="100%" Height="900px" RightToLeft="True" ColorScheme="softblue" SettingsExport-ShowPrintNotificationDialog="False">
      
                                          </dx:ASPxWebDocumentViewer>
                                   
                                </dx:LayoutItemNestedControlContainer>
                            </LayoutItemNestedControlCollection>
                  </dx:LayoutItem>
                </Items>
         </dx:ASPxFormLayout>
       
   <%-- <div width="80%">

         
        </div>--%>
                 <%-- <dx:ASPxDocumentViewer ID="ASPxDocumentViewer1" runat="server" Height="1100px" ReportTypeName="PREDJL.DenunciaReport" Width="100%" MobileMode="True">
            <settingsreportviewer printusingadobeplugin="False" />

            </dx:ASPxDocumentViewer>--%>
   
    </form>
</body>
</html>
