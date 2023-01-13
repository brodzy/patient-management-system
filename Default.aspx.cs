using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace patient_management {
	public partial class Default : System.Web.UI.Page {
		String dbType = "ConnectionString";
		protected void Page_Load(object sender, EventArgs e) {
		}

		//Button Methods
        protected void addPatient_Click(object sender, EventArgs e)
        {
            // Connect parameters to data entry controls
            dsPatients.InsertParameters["LastName"].DefaultValue = txtLName.Text;
            dsPatients.InsertParameters["FirstName"].DefaultValue = txtFName.Text;
            dsPatients.InsertParameters["Address"].DefaultValue = txtAddress.Text;

            // Insert player
            dsPatients.Insert();

            // Clear fields
            txtLName.Text = string.Empty;
            txtFName.Text = string.Empty;
            txtAddress.Text = string.Empty;
        }

		protected void btnAddVisit_Click(object sender, EventArgs e)
		{
			// Connect parameters to data entry controls
			dsVisits.InsertParameters["PatientID"].DefaultValue = gvPatients.SelectedValue.ToString();
			dsVisits.InsertParameters["VisitDate"].DefaultValue = txtDate.Text;
			dsVisits.InsertParameters["Charge"].DefaultValue = txtCharge.Text;
			dsVisits.InsertParameters["Notes"].DefaultValue = txtNotes.Text;

			// Insert player
			dsVisits.Insert();

			// Clear fields
			txtDate.Text = string.Empty;
			txtCharge.Text = string.Empty;
			txtNotes.Text = string.Empty;
		}

		protected void btnAddPrescriptions_Click(object sender, EventArgs e)
		{
			// Connect parameters to data entry controls
			dsPrescriptions.InsertParameters["PatientID"].DefaultValue = gvPatients.SelectedValue.ToString();
			dsPrescriptions.InsertParameters["VisitID"].DefaultValue = gvVisits.SelectedValue.ToString();
			dsPrescriptions.InsertParameters["DrugName"].DefaultValue = txtDrugName.Text;
			dsPrescriptions.InsertParameters["Instructions"].DefaultValue = txtInstructions.Text;

			// Insert player
			dsPrescriptions.Insert();

			// Clear fields
			txtDrugName.Text = string.Empty;
			txtInstructions.Text = string.Empty;
		}

		//Selected Index Methods
		protected void gvVisits_SelectedIndexChanged(object sender, EventArgs e)
		{
			lblDeletePatientFailure.Text = "";
			lblDeleteVisitFailure.Text = "";
			displayDate(dbType);
		}

		protected void gvPatients_SelectedIndexChanged(object sender, EventArgs e)
        {
			lblDeletePatientFailure.Text = "";
			lblDeleteVisitFailure.Text = "";
			displayName(dbType);
			displayCharge(dbType);
        }

		//Delete Methods
		protected void gvPatients_RowDeleted(object sender, GridViewDeletedEventArgs e)
		{
			// If delete was successful (i.e. no exception was thrown)
			if (e.Exception == null)
			{
				lblDeletePatientFailure.Text = "";
			}
			// If delete failed (i.e. an exception was thrown), then display a message
			// and set a flag indicating that the exception was handled.
			else
			{
				lblDeletePatientFailure.Visible = true;
				lblDeletePatientFailure.Text = "Patient can't be deleted, Visits exist.";
				e.ExceptionHandled = true;
			}

		}

		protected void gvVisits_RowDeleted(object sender, GridViewDeletedEventArgs e)
		{
			// If delete was successful (i.e. no exception was thrown)
			if (e.Exception == null)
			{
				lblDeleteVisitFailure.Text = "";
			}
			// If delete failed (i.e. an exception was thrown), then display a message
			// and set a flag indicating that the exception was handled.
			else
			{
				lblDeleteVisitFailure.Visible = true;
				lblDeleteVisitFailure.Text = "Visit can't be deleted, Prescriptions exist.";
				e.ExceptionHandled = true;
			}
		}

		//Display Methods
		private void displayCharge(string dbType)
		{
			lblTotalCharges.Text = "";
			try
			{
				IDbCommand cmd = ConnectionFactory.GetCommand(dbType);
				cmd.CommandText = getChargeSQL();
				cmd.Connection.Open();
				IDataReader dr = cmd.ExecuteReader();

				txtMsg.Text += "IDbConnection.State: " + cmd.Connection.State.ToString() + Environment.NewLine; ;
				txtMsg.Text += "IDataReader.IsClosed: " + dr.IsClosed + Environment.NewLine;
				txtMsg.Text += "cmd.CommandText: " + cmd.CommandText + Environment.NewLine + Environment.NewLine;

				double count = 0;
				while (dr.Read())
				{
					double charge = (double)dr.GetDecimal(0);
					count += charge;
					lblTotalCharges.Text = count.ToString();
				}


				dr.Close();
				cmd.Connection.Close();

			}
			catch (Exception ex)
			{
				txtMsg.Text = "\r\nError reading data\r\n";
				txtMsg.Text += ex.ToString();
			}
		}

		private void displayName(string dbType)
		{
			lblPatient.Text = "";
			try
			{
				IDbCommand cmd = ConnectionFactory.GetCommand(dbType);
				cmd.CommandText = getNameSQL();
				cmd.Connection.Open();
				IDataReader dr = cmd.ExecuteReader();

				txtMsg.Text += "IDbConnection.State: " + cmd.Connection.State.ToString() + Environment.NewLine; ;
				txtMsg.Text += "IDataReader.IsClosed: " + dr.IsClosed + Environment.NewLine;
				txtMsg.Text += "cmd.CommandText: " + cmd.CommandText + Environment.NewLine + Environment.NewLine;

				while (dr.Read())
				{
					String lName = dr.GetString(0);
					String fName = dr.GetString(1);
					lblPatient.Text = lName + ", " + fName;
				}


				dr.Close();
				cmd.Connection.Close();

			}
			catch (Exception ex)
			{
				txtMsg.Text = "\r\nError reading data\r\n";
				txtMsg.Text += ex.ToString();
			}
		}

		private void displayDate(string dbType)
		{
			lblVisitDate.Text = "";
			try
			{
				IDbCommand cmd = ConnectionFactory.GetCommand(dbType);
				cmd.CommandText = getDateSQL();
				cmd.Connection.Open();
				IDataReader dr = cmd.ExecuteReader();

				txtMsg.Text += "IDbConnection.State: " + cmd.Connection.State.ToString() + Environment.NewLine; ;
				txtMsg.Text += "IDataReader.IsClosed: " + dr.IsClosed + Environment.NewLine;
				txtMsg.Text += "cmd.CommandText: " + cmd.CommandText + Environment.NewLine + Environment.NewLine;

				while (dr.Read())
				{
					DateTime dtDate = (DateTime)dr.GetValue(0);
					String date = dtDate.ToString("MM/dd/yyyy");
					lblVisitDate.Text = date;
				}


				dr.Close();
				cmd.Connection.Close();

			}
			catch (Exception ex)
			{
				txtMsg.Text = "\r\nError reading data\r\n";
				txtMsg.Text += ex.ToString();
			}
		}

		//SQL Statements
		private String getChargeSQL()
		{
			String sql =
				"SELECT " +
					"Visits.Charge " +
				"FROM " +
					"Visits " +
				"WHERE " +
					"Visits.PatientID = " + gvPatients.SelectedValue + " ";

			return sql;

		}

		private String getDateSQL()
		{
			String sql =
				"SELECT " +
					"Visits.VisitDate " +
				"FROM " +
					"Visits " +
				"WHERE " +
					"Visits.VisitID = " + gvVisits.SelectedValue + " ";

			return sql;

		}

		private String getNameSQL()
		{
			String sql =
				"SELECT " +
					"Patients.LastName, " +
					"Patients.FirstName " +
				"FROM " +
					"Patients " +
				"WHERE " +
					"Patients.PatientID = " + gvPatients.SelectedValue + " ";

			return sql;

		}


    }

	
}