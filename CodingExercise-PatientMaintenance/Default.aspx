<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="CodingExercise_PatientMaintenance.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <link href="Content/bootstrap.css" rel="stylesheet" />
    <title>Patient Maintenance</title>
</head>
<body>
    <form id="form1" runat="server">

        <div class="container-fluid">
        <div class="jumbotron" style="background-color:#F8C471; text-align:center;">
            <h1>Patient Maintenance</h1>
        </div>

        <div class="row">
        <div class="col-sm">
           
            <asp:EntityDataSource ID="EntityDataSource1" runat="server" ConnectionString="name=PatientRepositoryEntities" 
                DefaultContainerName="PatientRepositoryEntities" EnableFlattening="False" EntitySetName="Patients" 
                EntityTypeFilter="Patient" Select="it.[Id], it.[FirstName], it.[LastName], it.[Phone], it.[Email], it.[Gender], it.[Notes]">
            </asp:EntityDataSource>

            <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False" ShowFooter="true" DataKeyNames="Id" HorizontalAlign="Center" CssClass="table table-responsive-md"
                OnRowCommand = "gvPatients_RowCommand" 
                OnRowEditing="gvPatients_RowEditing"
                OnRowCancelingEdit="gvPatients_RowCancelingEdit"
                OnRowUpdating="gvPatients_RowUpdating"
                OnRowDeleting="gvPatients_RowDeleting">
                <Columns>
                    <asp:TemplateField HeaderText="First Name">
                        <ItemTemplate>
                            <asp:Label ID="lblFirstName" Text='<%# Bind("FirstName") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtFirstName" Text='<%# Bind("FirstName") %>' runat="server" placeholder="First Name" CssClass="form-control-sm"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqFirstName" runat="server" ControlToValidate="txtFirstName" Text="*" ErrorMessage="Required Field" ValidationGroup="EditValidation"/>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtFirstNameFooter" runat="server" placeholder="First Name" CssClass="form-control-sm"></asp:TextBox>
-                           <asp:RequiredFieldValidator ID="reqFirstNameFooter" runat="server" ControlToValidate="txtFirstNameFooter" Text="*" ErrorMessage="Required Field" ValidationGroup="AddValidation"/>
                        </FooterTemplate>
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Last Name">
                        <ItemTemplate>
                            <asp:Label ID="lblLastName" Text='<%# Bind("LastName") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtLastName" Text='<%# Bind("LastName") %>' runat="server"  placeholder="Last Name" CssClass="form-control-sm"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqLastName" runat="server" ControlToValidate="txtLastName" Text="*" ErrorMessage="Required Field" ValidationGroup="EditValidation"/>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtLastNameFooter" runat="server" placeholder="Last Name" CssClass="form-control-sm"></asp:TextBox>
-                           <asp:RequiredFieldValidator ID="reqLastNameFooter" runat="server" ControlToValidate="txtLastNameFooter" Text="*" ErrorMessage="Required Field" ValidationGroup="AddValidation"/>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone">
                        <ItemTemplate>
                            <asp:Label ID="lblPhone" Text='<%# Bind("Phone") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtPhone" Text='<%# Bind("Phone") %>' runat="server" placeholder="(xxx) xxx-xxxx" CssClass="form-control-sm"></asp:TextBox>
-                           <asp:RequiredFieldValidator ID="reqPhone" runat="server" ControlToValidate="txtPhone" Text="*" ErrorMessage="Required Field" ValidationGroup="EditValidation"/>
                            <asp:RegularExpressionValidator ID="regExPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="X" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"  ValidationGroup="EditValidation"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtPhoneFooter" runat="server" placeholder="(xxx) xxx-xxxx" CssClass="form-control-sm"></asp:TextBox>
-                           <asp:RequiredFieldValidator ID="reqPhoneFooter" runat="server" ControlToValidate="txtPhoneFooter" Text="*" ErrorMessage="Required Field" ValidationGroup="AddValidation"/>
                            <asp:RegularExpressionValidator ID="regExPhoneFooter" runat="server" ControlToValidate="txtPhoneFooter" ErrorMessage="X" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}" ValidationGroup="AddValidation"></asp:RegularExpressionValidator>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Email">
                        <ItemTemplate>
                            <asp:Label ID="lblEmail" Text='<%# Bind("Email") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEmail" Text='<%# Bind("Email") %>' runat="server" placeholder="name@example.com" CssClass="form-control-sm"></asp:TextBox>
-                           <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail" Text="*" ErrorMessage="Required Field" ValidationGroup="EditValidation"/>
                            <asp:RegularExpressionValidator ID="regExEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="X" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="EditValidation"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtEmailFooter" runat="server" placeholder="name@example.com" CssClass="form-control-sm"></asp:TextBox>
-                           <asp:RequiredFieldValidator ID="reqEmailFooter" runat="server" ControlToValidate="txtEmailFooter" Text="*" ErrorMessage="Required Field" ValidationGroup="AddValidation"/>
                            <asp:RegularExpressionValidator ID="regExEmailFooter" runat="server" ControlToValidate="txtEmailFooter" ErrorMessage="X" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"  ValidationGroup="AddValidation"></asp:RegularExpressionValidator>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Gender">
                        <ItemTemplate>
                            <asp:Label ID="lblGender" Text='<%# Bind("Gender") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlGender" runat="server" SelectedValue='<%# Bind("Gender") %>' CssClass="form-control-sm">
                                <asp:ListItem Text="Male" Value="Male" />
                                <asp:ListItem Text="Female" Value="Female" />
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:DropDownList ID="ddlGenderFooter" runat="server" SelectedValue='<%# Bind("Gender") %>' CssClass="form-control-sm">
                                <asp:ListItem Text="Male" Value="Male" />
                                <asp:ListItem Text="Female" Value="Female" />
                            </asp:DropDownList>
                        </FooterTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Notes">
                        <ItemTemplate>
                            <asp:Label ID="lblNotes" Text='<%# Bind("Notes") %>' runat="server"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtNotes" Text='<%# Bind("Notes") %>' runat="server" placeholder="Notes" CssClass="form-control-sm"></asp:TextBox>
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:TextBox ID="txtNotesFooter" runat="server" placeholder="Notes" CssClass="form-control-sm"></asp:TextBox>
                        </FooterTemplate>
                    </asp:TemplateField>


                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ImageUrl="~/Images/edit32x32.png" runat="server" CommandName="Edit" ToolTip="Edit" Width="16px" Height="16px" />
                            <asp:ImageButton ImageUrl="~/Images/delete32x32.png" runat="server" CommandName="Delete" ToolTip="Delete" Width="16px" Height="16px" OnClientClick="return confirm('Delete Patient Record?');"/>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ImageUrl="~/Images/save32x32.png" runat="server" CommandName="Update" ToolTip="Update" Width="16px" Height="16px" CausesValidation="true" ValidationGroup="EditValidation"/>
                            <asp:ImageButton ImageUrl="~/Images/cancel32x32.png" runat="server" CommandName="Cancel" ToolTip="Cancel" Width="16px" Height="16px" />
                        </EditItemTemplate>
                        <FooterTemplate>
                            <asp:ImageButton ImageUrl="~/Images/add32x32.png" runat="server" CommandName="Add" ToolTip="Add" Width="16px" Height="16px" CausesValidation="true" ValidationGroup="AddValidation"/>
                        </FooterTemplate>
                    </asp:TemplateField>
                </Columns>
                <HeaderStyle CssClass="thead-dark" />
            </asp:GridView>
            <br />
            <asp:Label ID="lblSuccessMessage" runat="server" class="text-success"/>
            <br />
            <asp:Label ID="lblErrorMessage" runat="server" class="text-danger" />
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowSummary="false" ShowMessageBox="true" />
        </div>
        </div>
        </div>
    </form>
</body>
</html>
