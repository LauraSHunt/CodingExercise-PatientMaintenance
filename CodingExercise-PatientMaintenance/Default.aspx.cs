using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI.WebControls;
using CodingExercise_PatientMaintenance.Helpers;
using CodingExercise_PatientMaintenance.Models;

namespace CodingExercise_PatientMaintenance
{
    public partial class Default : System.Web.UI.Page
    {
        private PatientRepositoryEntities db = new PatientRepositoryEntities();

        protected void Page_Load(object sender, EventArgs e)
        {
            if(!IsPostBack)
            {
                BindData();
                gvPatients.HeaderRow.TableSection = TableRowSection.TableHeader;
            }
        }

        private void BindData()
        {
            List<Patient> listPatients = DecryptPatientData( db.Patients.Where(p => p.IsDeleted == false).ToList());

            if (listPatients.Count > 0)
            {
                gvPatients.DataSource = listPatients;
                gvPatients.DataBind();
            }
            else
            {
                listPatients.Add(new Patient());
                gvPatients.DataSource = listPatients;
                gvPatients.DataBind();
                gvPatients.Rows[0].Cells.Clear();
                gvPatients.Rows[0].Cells.Add(new TableCell());
                gvPatients.Rows[0].Cells[0].ColumnSpan = gvPatients.Columns.Count;
                gvPatients.Rows[0].Cells[0].Text = "No Patient Data Found (Add new below)";
                gvPatients.Rows[0].Cells[0].HorizontalAlign = HorizontalAlign.Center;
            }

            lblSuccessMessage.Text = Convert.ToString( Session["SuccessMessage"]);
            lblErrorMessage.Text = Convert.ToString(Session["ErrorMessage"]);
        }

        protected void gvPatients_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName.Equals("Add"))
            {
                try
                {
                    Patient patient = new Patient
                    {
                        FirstName = DESEncryptionHelper.Encrypt((gvPatients.FooterRow.FindControl("txtFirstNameFooter") as TextBox).Text.Trim()),
                        LastName = DESEncryptionHelper.Encrypt((gvPatients.FooterRow.FindControl("txtLastNameFooter") as TextBox).Text.Trim()),
                        Phone = DESEncryptionHelper.Encrypt((gvPatients.FooterRow.FindControl("txtPhoneFooter") as TextBox).Text.Trim()),
                        Email = DESEncryptionHelper.Encrypt((gvPatients.FooterRow.FindControl("txtEmailFooter") as TextBox).Text.Trim()),
                        Gender = DESEncryptionHelper.Encrypt((gvPatients.FooterRow.FindControl("ddlGenderFooter") as DropDownList).SelectedItem.Value),
                        Notes = DESEncryptionHelper.Encrypt((gvPatients.FooterRow.FindControl("txtNotesFooter") as TextBox).Text),
                        CreatedDate = DateTime.Now,
                        LastUpdatedDate = DateTime.Now,
                        IsDeleted = false
                    };

                    db.Patients.Add(patient);
                    db.SaveChanges();
                    Session["SuccessMessage"] = "New Patient Record Added";
                    Session["ErrorMessage"] = "";
                }
                catch (Exception ex)
                {
                    Session["SuccessMessage"] = "";
                    Session["ErrorMessage"] = "Error Adding Patient Record: " + ex.Message;
                    if (ex.InnerException != null)
                    {
                        Session["ErrorMessage"] += " Inner exception: " + ex.InnerException;
                    }
                }
                finally
                {
                    Response.Redirect(Request.RawUrl);
                }
            }
        }

        protected void gvPatients_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvPatients.EditIndex = e.NewEditIndex;
            BindData();
        }

        protected void gvPatients_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvPatients.EditIndex = -1;
            BindData();
        }

        protected void gvPatients_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int Id = Convert.ToInt32(gvPatients.DataKeys[e.RowIndex].Value.ToString());

                Patient patient = db.Patients.Where(p => p.Id == Id).FirstOrDefault<Patient>();

                patient.FirstName = DESEncryptionHelper.Encrypt((gvPatients.Rows[e.RowIndex].FindControl("txtFirstName") as TextBox).Text.Trim());
                patient.LastName = DESEncryptionHelper.Encrypt((gvPatients.Rows[e.RowIndex].FindControl("txtLastName") as TextBox).Text.Trim());
                patient.Phone = DESEncryptionHelper.Encrypt((gvPatients.Rows[e.RowIndex].FindControl("txtPhone") as TextBox).Text.Trim());
                patient.Email = DESEncryptionHelper.Encrypt((gvPatients.Rows[e.RowIndex].FindControl("txtEmail") as TextBox).Text.Trim());
                patient.Gender = DESEncryptionHelper.Encrypt((gvPatients.Rows[e.RowIndex].FindControl("ddlGender") as DropDownList).SelectedItem.Value);
                patient.Notes = DESEncryptionHelper.Encrypt((gvPatients.Rows[e.RowIndex].FindControl("txtNotes") as TextBox).Text.Trim());
                patient.LastUpdatedDate = DateTime.Now;

                db.SaveChanges();
                gvPatients.EditIndex = -1;
                Session["SuccessMessage"] = "Patient Record updated";
                Session["ErrorMessage"] = "";
            }
            catch (Exception ex)
            {
                Session["SuccessMessage"] = "";
                Session["ErrorMessage"] = "Error Updating Patient Record: " + ex.Message;
                if (ex.InnerException != null)
                {
                    Session["ErrorMessage"] += " Inner exception: " + ex.InnerException;
                }
            }
            finally
            {
                Response.Redirect(Request.RawUrl);
            }
        }

        protected void gvPatients_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                int Id = Convert.ToInt32(gvPatients.DataKeys[e.RowIndex].Value.ToString());

                Patient patient = db.Patients.Where(p => p.Id == Id).FirstOrDefault<Patient>();
                patient.LastUpdatedDate = DateTime.Now;
                patient.IsDeleted = true;
                db.SaveChanges();
                gvPatients.EditIndex = -1;
                Session["SuccessMessage"] = "Patient Record Deleted";
            }
            catch (Exception ex)
            {
                Session["SuccessMessage"] = "";
                Session["ErrorMessage"] = "Error Deleting Patient Record: " + ex.Message;
                if (ex.InnerException != null)
                {
                    Session["ErrorMessage"] += " Inner exception: " + ex.InnerException;
                }
            }
            finally
            {
                Response.Redirect(Request.RawUrl);
            }
        }

        private List<Patient> DecryptPatientData(List<Patient> patients)
        {
            List<Patient> listDecrypted = new List<Patient>();

            foreach( Patient patient in patients)
            {
                Patient decryptedPatient = new Patient
                {
                    Id = patient.Id,
                    FirstName = DESEncryptionHelper.Decrypt(patient.FirstName),
                    LastName = DESEncryptionHelper.Decrypt(patient.LastName),
                    Phone = DESEncryptionHelper.Decrypt(patient.Phone),
                    Email = DESEncryptionHelper.Decrypt(patient.Email),
                    Gender = DESEncryptionHelper.Decrypt(patient.Gender),
                    Notes = DESEncryptionHelper.Decrypt(patient.Notes),
                    CreatedDate = patient.CreatedDate,
                    LastUpdatedDate = patient.LastUpdatedDate,
                    IsDeleted = patient.IsDeleted
                };

                listDecrypted.Add(decryptedPatient);
            }

            return listDecrypted;
        }

        //private void CheckEmptyFields(string template, int rowIndex = -1)
        //{
        //    if(template == "Edit")
        //    {
        //        if( String.IsNullOrEmpty((gvPatients.Rows[rowIndex].FindControl("txtFirstName") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.Rows[rowIndex].FindControl("txtLastName") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.Rows[rowIndex].FindControl("txtPhone") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.Rows[rowIndex].FindControl("txtEmail") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.Rows[rowIndex].FindControl("txtGender") as TextBox).Text))
        //        {
        //            throw new Exception("One or more required fields is empty.");
        //        }
        //    }
        //    else if (template == "Footer")
        //    {
        //        if (String.IsNullOrEmpty((gvPatients.FooterRow.FindControl("txtFirstNameFooter") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.FooterRow.FindControl("txtLastNameFooter") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.FooterRow.FindControl("txtPhoneFooter") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.FooterRow.FindControl("txtEmailFooter") as TextBox).Text) ||
        //            String.IsNullOrEmpty((gvPatients.FooterRow.FindControl("txtGenderFooter") as TextBox).Text))
        //        {
        //            throw new Exception("One or more required fields is empty.");
        //        }

        //    }
        //}
    }
}