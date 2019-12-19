using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using System.Windows.Forms;
using System.Web.SessionState;

using DevExpress.XtraEditors;
using DevExpress.XtraEditors.Controls;

namespace DigitalSystem.SalaryManagement
{
    public partial class SalaryItemSet : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                Fill_ReordorBox();
                Fill_GW();
                //Response.Write(Page.IsPostBack);
            }
        }
        //数据库连接
        private SqlConnection conn_database()
        {
            string connectionString = "Data Source=(local);Initial Catalog=KangKeDe;User ID=sa;Password=123456";
            SqlConnection conn = new SqlConnection(connectionString);
            conn.Open();
            return conn;
        }
        private DataSet Get_DataSet(SqlConnection conn, string item)
        {
            //查询工资项目并按序号排列
            SqlCommand cmd = new SqlCommand("select " + item + " from K_Salary_Management order by sm_serial_number", conn);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds, "table_project");

            return ds;
        }

        private DataSet Get_DataSet(SqlConnection conn, string item, string condition)
        {
            //查询工资项目并按序号排列
            SqlCommand cmd = new SqlCommand("select " + item + " from K_Salary_Management where sm_use = " + condition + " order by sm_serial_number", conn);
            SqlDataAdapter sda = new SqlDataAdapter(cmd);
            DataSet ds = new DataSet();
            sda.Fill(ds, "table_project");

            return ds;
        }

        protected void Fill_ReordorBox()
        {
           SqlConnection conn = conn_database();
           DataSet ds = Get_DataSet(conn, "sm_project");
            DataTable dt = ds.Tables[0];
           this.Project_ListBox.DataTextField = "sm_project";
           Project_ListBox.Items.Clear();
           int i = 0;
           foreach (DataRow dr in dt.Rows)
           {
               ListItem li = new ListItem();
               li.Text = (i+1).ToString() + "  " + dr["sm_project"].ToString();
               li.Value = (i++).ToString();
               Project_ListBox.Items.Add(li);
           }
           conn.Close();
        }
        protected void Fill_GW()
        {
            SqlConnection conn = conn_database();
            DataSet ds = Get_DataSet(conn,"*", "1");
            DataTable dt = ds.Tables[0];
                       
            useGV.DataSource = dt;
            useGV.DataBind();

            ds = Get_DataSet(conn, "*", "0");
            dt = ds.Tables[0];

            banGV.DataSource = dt;
            banGV.DataBind();

            conn.Close();
        }

        protected void new_and_ban_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            Response.Write("RRebind");
            useGV.PageIndex = e.NewPageIndex;
            Fill_GW(); //重新绑定GridView数据的函数
            Response.Write("rebind");
        }

        protected String cut(String str)
        {
            int i = str.Length - 1;
            while (str[i] != ' ')
                i--;
            return str.Substring(i + 1);
        }
       
        protected void btnRefresh_click(object sender, EventArgs e)
        {
            try
            {
                string order_list_string = (string)Request.Cookies["order_list"].Value;
                
                List<int> order_list = convert_to_list(order_list_string);
                SqlConnection conn = conn_database();
                for (int i = 0; i < Project_ListBox.Items.Count; i++)
                {
                    int old_order = order_list[i];
                    SqlCommand cmd = new SqlCommand("update K_Salary_Management set sm_serial_number = " + i.ToString() + " where sm_project = '" + cut(Project_ListBox.Items[old_order].ToString()) + "'", conn);
                    cmd.ExecuteNonQuery();
                }
                Fill_ReordorBox();
                delCookie();
            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "新建工资项", MessageBoxButtons.OK, MessageBoxIcon.Error);
                //Response.Redirect(
                //    Request.Url.ToString());
            }
        }

        
       

        protected List<int> convert_to_list(string str)
        {
            List<int> li = new  List<int>();

            for (int i = 0, j = 0; j < str.Length; j++)
            {
                if (str[j] == ',')
                {
                    string tmp = str.Substring(i, j-i);
                    li.Add(Convert.ToInt32(tmp));
                    i = j + 1;
                }
            }

            return li;
        }

        protected void ASPxGridView1_CustomButtonCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomButtonCallbackEventArgs e)
        {
            string csname = "testscript";
                Type cstype = this.GetType();
                ClientScriptManager cs = Page.ClientScript;
                if (!cs.IsStartupScriptRegistered(cstype, csname))
                {
                    string cstext = "NewProject.Show() ;";
                    cs.RegisterStartupScript(cstype, csname, cstext, true);
                }
        }

        protected void btnNew_click(object sender, EventArgs e)
        {
            try
            {
                string cn_name = this.cn_name.Text;
                string en_name = this.en_name.Text;
                string if_use = used.Checked ? "1" : "0";
                string serial_number = Project_ListBox.Items.Count.ToString();
                if (cn_name == "" || en_name == "")
                {
                    MessageBox.Show("名称不能为空！", "新建工资项", MessageBoxButtons.OK, MessageBoxIcon.Error);
                    return;
                }
                //string message = "中文名称：" + cn_name + "\n英文名称：" + en_name + "\n是否启用：" + (used.Checked ? "是" : "否");
                //message += "\n\n确认新建吗？";
                //DialogResult result =
                //MessageBox.Show(message, "新建工资项", MessageBoxButtons.YesNo, MessageBoxIcon.Asterisk);
                //if (result == DialogResult.Yes)
                //{
                    SqlConnection conn = conn_database();
                    SqlCommand cmd1 = new SqlCommand("insert into K_Salary_Management values ('" + cn_name + "', " + serial_number + "," + if_use + "," + "'esr_" + en_name + "')", conn);
                    cmd1.ExecuteNonQuery();
                    SqlCommand cmd2 = new SqlCommand("alter table K_Employee_Salary_Record add esr_" + en_name + " FLOAT", conn);
                    cmd2.ExecuteNonQuery();
                    //MessageBox.Show("新建成功！", "新建工资项", MessageBoxButtons.OK, MessageBoxIcon.Asterisk);
                    conn.Close();
                    Fill_ReordorBox();
                    Fill_GW();
                    //NewProject.Hide();
                    //Response.Redirect(
                    //Request.Url.ToString());
                //}
                //else { return; }


            }
            catch (Exception ex)
            {
                MessageBox.Show(ex.Message, "新建工资项", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        protected void delCookie()
        {
            HttpCookie aCookie = new HttpCookie("order_list");
            aCookie.Expires = DateTime.Now.AddDays(-1);
            Response.Cookies.Add(aCookie);
            //HttpContext.Response.Cookies["order_list"].Expires = DateTime.Now.AddDays(-1);
        }

        protected void new_ban_refresh(object sender, EventArgs e)
        {
            string useSelectedId = "";
            string banSelectedId = "";

            //获取选中的记录Id                   
            List<object> useSelected = useGV.GetSelectedFieldValues("sm_id");
            List<object> banSelected = banGV.GetSelectedFieldValues("sm_id");


            for (int i = 0; i < useSelected.Count; i++)
            {

                useSelectedId += "'" + useSelected[i] + "',";

            }
            for (int i = 0; i < banSelected.Count; i++)
            {

                banSelectedId += "'" + banSelected[i] + "',";

            }

            //List<int> use_list = convert_to_list(rowId);
            if (useSelectedId.Length > 0)
            {
                useSelectedId = useSelectedId.Substring(0, useSelectedId.LastIndexOf(','));
                SqlConnection conn = conn_database();
                //SqlCommand cmd = new SqlCommand("update K_Salary_Management set sm_use = 0", conn);
                //cmd.ExecuteNonQuery();

                SqlCommand cmd = new SqlCommand("update K_Salary_Management set sm_use = 0 where sm_id in (" + useSelectedId + ")", conn);
                cmd.ExecuteNonQuery();

                conn.Close();

            }
            if (banSelectedId.Length > 0)
            {
                banSelectedId = banSelectedId.Substring(0, banSelectedId.LastIndexOf(','));
                SqlConnection conn = conn_database();
                //SqlCommand cmd = new SqlCommand("update K_Salary_Management set sm_use = 0", conn);
                //cmd.ExecuteNonQuery();

                SqlCommand cmd = new SqlCommand("update K_Salary_Management set sm_use = 1 where sm_id in (" + banSelectedId + ")", conn);
                cmd.ExecuteNonQuery();

                conn.Close();

            }
            Fill_GW();

            useGV.Selection.UnselectAll();
            banGV.Selection.UnselectAll();
        }
    }
}