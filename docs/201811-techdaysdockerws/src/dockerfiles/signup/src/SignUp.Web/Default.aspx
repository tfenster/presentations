<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SignUp.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Have you heard about the NAV TechDays conference?</h1>
        <p class="lead">The number one tech conference for NAV and Business Central!</p>
        <div style="text-align: right">
            <!-- v2 -->
            <a href="https://www.navtechdays.com/" target="_blank">
                <img src="https://www.navtechdays.com/templates/default_site/2018.group/images/logo_white_2018.svg"/>
            </a>
        </div>
    </div>

    <div class="row">
        <div class="col-md-12">
            <h2>Interested? Get the newsletter!</h2>
            <p>
                Give us your details and we&#39;ll keep you posted.</p>
            <p>
                It only takes 30 seconds to sign up.
            </p>
            <p>
                And we probably won't spam you very much.
            </p>
            <p>
                <a class="btn btn btn-primary btn-lg" href="SignUp.aspx">Sign Up &raquo;</a>
            </p>
        </div>
    </div>

</asp:Content>
