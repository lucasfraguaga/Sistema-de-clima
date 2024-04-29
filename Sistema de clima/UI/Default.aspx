<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UI._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <section class="row" aria-labelledby="aspnetTitle">
            &quot;Hola mundo&quot;<br />
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="Button" />
    </section>

    </main>

</asp:Content>
