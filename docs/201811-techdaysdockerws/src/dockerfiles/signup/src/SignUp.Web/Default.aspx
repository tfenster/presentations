<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SignUp.Web._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Have you heard about the MVPDays virtual conference?</h1>
        <p class="lead">A simple, interactive and fun way to learn about technology from MS MVPs.</p>
        <div style="text-align: right">
            <!-- v2 -->
            <a href="http://mvpdays.com/" target="_blank">
                <img src="http://www.mvpdays.com/wp-content/uploads/2015/05/smallmvpdays.jpg"/>
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
