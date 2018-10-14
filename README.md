-------------------------------------------------------------------------------

CodingExercise-PatientMaintenance
ASP.NET Web Forms Application (.Net version 4.5.2)
Visual Studio 2017 (Community Edition)

Written by: Laura S. Hunt 

-------------------------------------------------------------------------------


Application Project Details: CodingExercise-PatientMaintenance 
	
	This is a coding exercise based on the requirements for Patient Maintenance coding task.  

	The solution is written in C# implementing ASP.Net Web Forms (.Net Framework version 4.5.2),  
	Entity Framework 5 w/ LINQ extension methods for data access, SQL Server backend database, 
	and Bootstrap 4 for front-end styling and design.


Database Details:
	
	The database file, PatientRepository.mdf, is located in the App_Data folder 
	of the project.  

	The database consists of one table: Patients.  The connection string in web.config
	is configured for integrated security.
	
	The Create script for Patients table - 	dbo.Patients.Create.Table.sql - is 
	located in the file location App_Data\Scripts

	Table fields are: FirstName, LastName, Phone, Email, Gender, Notes, CreatedDate, 
	LasUpdatedDate, IsDeleted.


User Interface:
	
	The application uses a single page for all CRUD operations on the Patient data.  Patient data
	can be edited and deleted (soft delete as required) and new patients can be added.  This is 
	implemented with the ASP.Net GridView control templates for displaying and editing
	patient data.  The FooterTemplate is used for adding new patient data.  
	
	ImageButton controls are implemented for user interaction with patient data operations.
	All data is required except for Notes.  Phone number must be in U.S. format:
	(xxx) xxx-xxxx and Email addresses must be formatted for international standards.  These
	requirements are implemented with Validation controls.
	   

Data Encryption Details:

	The application implements DES encryption (key and vector are exposed in web.config).
	All data fields are encrypted/decrypted except for table Id, CreatedDate, LastUpdatedDate,
	and IsDeleted fields.


Notes:

	The application architecture uses a Post/Redirect/Get design pattern.  This solves 
	concerns of clearing form input (user refresh will not re-submit any previously 
	cached POST data).

	Since the code base is small for this app, code documentation was intentionally
	left out and relevant information noted in the readme.txt.

	Any testing data can be purged by deleting all rows from the Patients table 
	of the PatientRepository database.  
	The App_Data\Scripts\dbo.Patients.Delete.sql script will purge all data and 
	reseed the Id column.


Contact:
	Please email me with any questions or comments:
	LauraSHunt@gmail.com

-------------------------------------------------------------------------------
