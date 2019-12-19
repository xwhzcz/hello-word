<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Preview.aspx.cs" Inherits="DigitalSystem.SalaryManagement.Preview" %>

<%@ Register Assembly="DevExpress.Web.ASPxGridView.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web.ASPxGridView" TagPrefix="dx" %>

<%@ Register assembly="DevExpress.Web.ASPxEditors.v10.2, Version=10.2.6.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.Web.ASPxEditors" tagprefix="dx" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        预览
        <dx:ASPxGridView ID="ASPxGridView1" runat="server" AutoGenerateColumns="False" ClientIDMode="AutoID" DataSourceID="LinqDataSource1" KeyFieldName="esr_id">
            <Columns>
                <dx:GridViewDataComboBoxColumn FieldName="esr_department" ShowInCustomizationForm="True" VisibleIndex="1" Caption="部门">
                          
                     </dx:GridViewDataComboBoxColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_employee_id" VisibleIndex="3"   Caption="员工编号">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_employee_name" VisibleIndex="2"  Caption="姓名">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataDateColumn FieldName="esr_time" VisibleIndex="4" Caption="发放时间">
                    </dx:GridViewDataDateColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_basic_salary" VisibleIndex="5" Caption="基本工资">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_meritpay" VisibleIndex="6" Caption="绩效工资">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_bonus" VisibleIndex="7" Caption="奖金">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_subsidy" VisibleIndex="8" Caption="津贴">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_allowance" VisibleIndex="9" Caption="补贴">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_social_insurance" VisibleIndex="10" Caption="社会保险">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_housing_fund" VisibleIndex="11" Caption="住房公积金">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_other_shorttime_money" VisibleIndex="12" Caption="其他短期工资">
                    </dx:GridViewDataTextColumn>
                    <dx:GridViewDataTextColumn FieldName="esr_deduction" VisibleIndex="13" Caption="工资扣除项目">
                    </dx:GridViewDataTextColumn>
            </Columns>
        </dx:ASPxGridView>
    </div>
    </form>
    <asp:LinqDataSource ID="LinqDataSource1" runat="server" ContextTypeName="DigitalSystem.SalaryManagement.SalaryRecordDataContext" EntityTypeName="" TableName="K_Employee_Salary_Record"></asp:LinqDataSource>
</body>
</html>
