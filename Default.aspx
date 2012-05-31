<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="Default.aspx.cs" Inherits="Flick._Default" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">


    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div>
                    <div class = 'container'>
                        <asp:Label style="position:relative;" ID="resultsLocation" runat="server" Text=""></asp:Label>
                        <div id="droppable" class="savearea">
                            <div style="margin:0 auto;">
                            </div>
                            <h2 style="margin-top: 5px;">
                                Drag Here</h2>
                            <p>
                                ...to save</p>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." 
                        onselectedindexchanged="GridView1_SelectedIndexChanged"
                        Width="100px"
                        GridLines="None">
                                <Columns>
                                    <asp:TemplateField HeaderText="recent" >
                                        <ItemTemplate>
                                            <a id="A1" class="group" href='<%# Eval("mainimg")%>' runat="server">
                                            <img src='<%# Eval("image")%>' runat="server" 
                         style="height: 50%; width: 50%;"> </a>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>
                </div>
                <div>
                    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:DB_42245_imagetagConnectionString1 %>" 
            ProviderName="<%$ ConnectionStrings:DB_42245_imagetagConnectionString1.ProviderName %>" 
            
            
                        SelectCommand="SELECT TOP 6 [image], [mainimg], [tag], [id] FROM [saves] Order BY [id] DESC">
                    </asp:SqlDataSource>
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="searchButton" 
                        style="text-align: center">
                        <p>
                            <asp:TextBox ID="searchBox" runat="server" class="textbox" 
                                Text="enter a search term" Width="161px"></asp:TextBox>
                        </p>
                        <p>
                            <asp:Button ID="searchButton" runat="server" OnCommand="leftButton_Click" 
                                Text="Search Flickr..." />
                        </p>
                    </asp:Panel>
                </div>
            
    <br />
        <div style="display:none;">
            <asp:Panel ID="Panel2" runat="server" DefaultButton="Button1" >
                <asp:TextBox ID="linkHidden" runat="server"></asp:TextBox>
                <asp:TextBox ID="thumbHidden" runat="server"></asp:TextBox>
                <asp:Button ID="Button1" runat="server" Text="Button" OnCommand="Button1_Click"  />
            </asp:Panel>
        </div>
    
    </div>
    <div class="csharp">
    </div>


    </ContentTemplate>
        </asp:UpdatePanel>
    <br />
    <div class="about">
        <h3>
            About:
        </h3>
            <p>
            Demo exercise in parsing XML using both client and server side code.
            Implementation of JQuery_UI using 'draggable' & 'droppable' to 
            create an interface.
            <br />

            <ul>
                <li>Search for images asychronously from flickr <b>Ajax</b></li>
                <li>Parse the xml server side for links and images <b>C#</b>,<b> DOM </b></li>
                <li>Click and drag resulting thumbnails to sort <b>Jquery_Ui</b></li>
                <li>Drag & drop to save to database <b>Javascript</b> & <b>SQL</b></li>
                <li>All done as a learning exercise in <b>.net 4</b></li>
                <li>Click saved images to view full size <b>Fancybox for JQuery</b></li>
            </ul>
        </p>
    
    </div>

</asp:Content>
