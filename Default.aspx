<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="patient_management.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Patient Management System</title>
    <link href="site.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        <h2>Patient Management System</h2>

        <hr />

        <p><strong>Patients</strong></p>
        <asp:GridView ID="gvPatients" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="PatientID" DataSourceID="dsPatients" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvPatients_SelectedIndexChanged" AllowPaging="True" OnRowDeleted="gvPatients_RowDeleted">
            <AlternatingRowStyle BackColor="White" />
            <Columns>
                <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                <asp:BoundField DataField="PatientID" HeaderText="PatientID" InsertVisible="False" ReadOnly="True" SortExpression="PatientID" />
                <asp:BoundField DataField="LastName" HeaderText="LastName" SortExpression="LastName" />
                <asp:BoundField DataField="FirstName" HeaderText="FirstName" SortExpression="FirstName" />
                <asp:BoundField DataField="Address" HeaderText="Address" SortExpression="Address" />
            </Columns>
            <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
            <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
            <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
            <SortedAscendingCellStyle BackColor="#FDF5AC" />
            <SortedAscendingHeaderStyle BackColor="#4D0000" />
            <SortedDescendingCellStyle BackColor="#FCF6C0" />
            <SortedDescendingHeaderStyle BackColor="#820000" />
		</asp:GridView>
		<asp:SqlDataSource ID="dsPatients" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Patients] WHERE [PatientID] = ?" InsertCommand="INSERT INTO [Patients] ([LastName], [FirstName], [Address]) VALUES (?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [PatientID], [LastName], [FirstName], [Address] FROM [Patients]" UpdateCommand="UPDATE [Patients] SET [LastName] = ?, [FirstName] = ?, [Address] = ? WHERE [PatientID] = ?">
            <DeleteParameters>
                <asp:Parameter Name="PatientID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="LastName" Type="String" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="Address" Type="String" />
                <asp:Parameter Name="PatientID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
		<asp:Label ID="lblDeletePatientFailure" runat="server" Font-Bold="True" Font-Italic="True" ForeColor="Red" Text="Label" Visible="False"></asp:Label>
        <br />
        <asp:Button runat="server" Text="Add Patient" ID="addPatient" OnClick="addPatient_Click" />
&nbsp;Last Name
        <asp:TextBox ID="txtLName" runat="server" Width="75px"></asp:TextBox>
&nbsp;First Name
        <asp:TextBox ID="txtFName" runat="server" Width="75px"></asp:TextBox>
&nbsp;Address
        <asp:TextBox ID="txtAddress" runat="server" Width="150px"></asp:TextBox>
        <br />
        <p>
            Total charges for selected patient:
            <asp:Label ID="lblTotalCharges" runat="server" Font-Bold="True" 
                ForeColor="Red" Text="Put total charges here"></asp:Label>
            <br />
        </p>
        <p>
            <strong>Visits - </strong>
            <asp:Label ID="lblPatient" runat="server" 
                Text="Put Selected Patient Name Here: LName, FName" Font-Bold="True" 
                ForeColor="Red"></asp:Label>
        </p>
        <p>
            <asp:SqlDataSource ID="dsVisits" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Visits] WHERE [VisitID] = ?" InsertCommand="INSERT INTO [Visits] ([PatientID], [VisitDate], [Charge], [Notes]) VALUES (?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [VisitID], [VisitDate], [Charge], [Notes] FROM [Visits] WHERE ([PatientID] = ?)" UpdateCommand="UPDATE [Visits] SET [VisitDate] = ?, [Charge] = ?, [Notes] = ? WHERE [VisitID] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="VisitID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PatientID" Type="Int32" />
                    <asp:Parameter Name="VisitDate" Type="DateTime" />
                    <asp:Parameter Name="Charge" Type="Decimal" />
                    <asp:Parameter Name="Notes" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvPatients" Name="PatientID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="VisitDate" Type="DateTime" />
                    <asp:Parameter Name="Charge" Type="Decimal" />
                    <asp:Parameter Name="Notes" Type="String" />
                    <asp:Parameter Name="VisitID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvVisits" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="VisitID" DataSourceID="dsVisits" ForeColor="#333333" GridLines="None" OnSelectedIndexChanged="gvVisits_SelectedIndexChanged" OnRowDeleted="gvVisits_RowDeleted">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" ShowSelectButton="True" />
                    <asp:BoundField DataField="VisitID" HeaderText="VisitID" InsertVisible="False" ReadOnly="True" SortExpression="VisitID" />
                    <asp:BoundField DataField="VisitDate" HeaderText="VisitDate" SortExpression="VisitDate" />
                    <asp:BoundField DataField="Charge" HeaderText="Charge" SortExpression="Charge" />
                    <asp:BoundField DataField="Notes" HeaderText="Notes" SortExpression="Notes" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
			</asp:GridView>
			<asp:Label ID="lblDeleteVisitFailure" runat="server" Font-Bold="True" Font-Italic="True" ForeColor="Red" Text="Label" Visible="False"></asp:Label>
        </p>
        <p>
        <asp:Button ID="btnAddVisit" runat="server" Text="Add Visit" OnClick="btnAddVisit_Click" />
            &nbsp;Date
        <asp:TextBox ID="txtDate" runat="server" Width="75px"></asp:TextBox>
            &nbsp;Charge
        <asp:TextBox ID="txtCharge" runat="server" Width="75px"></asp:TextBox>
            &nbsp;Notes
        <asp:TextBox ID="txtNotes" runat="server" Width="150px"></asp:TextBox>
        </p>
        <p>
            <strong>Prescriptions - </strong>
            <asp:Label ID="lblVisitDate" runat="server" Text="Put Selected Visit Date Here" 
                Font-Bold="True" ForeColor="Red"></asp:Label>
            <asp:GridView ID="gvPrescriptions" runat="server" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="PrescriptionID" DataSourceID="dsPrescriptions" ForeColor="#333333" GridLines="None">
                <AlternatingRowStyle BackColor="White" />
                <Columns>
                    <asp:CommandField ShowDeleteButton="True" ShowEditButton="True" />
                    <asp:BoundField DataField="PrescriptionID" HeaderText="PrescriptionID" InsertVisible="False" ReadOnly="True" SortExpression="PrescriptionID" />
                    <asp:BoundField DataField="DrugName" HeaderText="DrugName" SortExpression="DrugName" />
                    <asp:BoundField DataField="Instructions" HeaderText="Instructions" SortExpression="Instructions" />
                </Columns>
                <FooterStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#990000" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#FFCC66" ForeColor="#333333" HorizontalAlign="Center" />
                <RowStyle BackColor="#FFFBD6" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#FFCC66" Font-Bold="True" ForeColor="Navy" />
                <SortedAscendingCellStyle BackColor="#FDF5AC" />
                <SortedAscendingHeaderStyle BackColor="#4D0000" />
                <SortedDescendingCellStyle BackColor="#FCF6C0" />
                <SortedDescendingHeaderStyle BackColor="#820000" />
			</asp:GridView>
            <asp:SqlDataSource ID="dsPrescriptions" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [Prescriptions] WHERE [PrescriptionID] = ?" InsertCommand="INSERT INTO [Prescriptions] ([PatientID], [VisitID], [DrugName], [Instructions]) VALUES (?, ?, ?, ?)" ProviderName="<%$ ConnectionStrings:ConnectionString.ProviderName %>" SelectCommand="SELECT [PrescriptionID], [DrugName], [Instructions] FROM [Prescriptions] WHERE ([VisitID] = ?)" UpdateCommand="UPDATE [Prescriptions] SET [DrugName] = ?, [Instructions] = ? WHERE [PrescriptionID] = ?">
                <DeleteParameters>
                    <asp:Parameter Name="PrescriptionID" Type="Int32" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="PatientID" Type="Int32" />
                    <asp:Parameter Name="VisitID" Type="Int32" />
                    <asp:Parameter Name="DrugName" Type="String" />
                    <asp:Parameter Name="Instructions" Type="String" />
                </InsertParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvVisits" Name="VisitID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DrugName" Type="String" />
                    <asp:Parameter Name="Instructions" Type="String" />
                    <asp:Parameter Name="PrescriptionID" Type="Int32" />
                </UpdateParameters>
            </asp:SqlDataSource>
        </p>
        <p>
        <asp:Button ID="btnAddPrescriptions" runat="server" Text="Add Prescription" OnClick="btnAddPrescriptions_Click" />
            &nbsp;Drug Name
        <asp:TextBox ID="txtDrugName" runat="server" Width="75px"></asp:TextBox>
            &nbsp;Instructions
        <asp:TextBox ID="txtInstructions" runat="server" Width="170px"></asp:TextBox>
            &nbsp;</p>
        <p>
            <asp:TextBox ID="txtMsg" runat="server" Height="259px" TextMode="MultiLine" Width="698px"></asp:TextBox>
		</p>

       <hr />

        <p>
            &nbsp;</p>
        <p>
            &nbsp;</p>
        </div>
    </form>
</body>

</html>
