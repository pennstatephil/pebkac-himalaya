<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makeuser(String username, String password, String name, String email, String dob, String gender, String phone, double salary)
{
    dba.addNewUser(username, password, name, email, dob, gender, phone, salary);
}

String validateinfo(String username, String password, String name, String email, String dob, String gender, String phone, double salary)
{
    String returnme="";
    if(!(username.length()<=20
       && username.length()!=0
       && password.length()<=20
       && password.length()!=0
       && name.length()<=30
       && name.length()!=0
       && email.length()<=30
       && email.length()!=0
       && dob.length()==10
       && gender.length()==1
       && phone.length()==12
       && salary>0))
       {
            returnme+="<h3>Username must be at most 20 characters, "+
            " Password must be at most 20 characters, "+
            "Name must be at most 30 characters, "+
            "Email must be at most 30 characters, "+
            "DOB must be exactly 10 characters (MM-DD-YYYY), "+
            "Gender selection is required, "+
            "Salary must be at most 7 digits, "+
            "Phone must be exactly 12 characters (xxx-xxx-xxxx), and " +
            "Salary must be greater than 0.<br>"+
            "All fields are required.</h3>";
        }
        if(!ValidateInput.validateFullName(name))
        {
                returnme+="<h3>Invalid name.<br></h3>";
        }
        if(!ValidateInput.validatePhone(phone))
         {
                returnme+="<h3>Invalid phone.<br></h3>";
         }
        if(!ValidateInput.validateEmail(email))
         {
                returnme+="<h3>Invalid email.<br></h3>";
         }
        if(returnme.length()!=0)
         {
            returnme="<h1>Invalid data!</h1><br>"+returnme;
             returnme+="<h3>Go back and try again!</h3>";
         }
    return returnme;
}
%>
<html>
  <head>
    <title>Himalaya.com</title>
    <link href="himalaya.css" rel="stylesheet" type="text/css">
  </head>
  <body>
  <table width="700" border="0">
      <tr height="80"><td colspan="2">
        <%@ include file="banner.jsp" %>
      </td><td></td></tr>
      <tr><td width="150" class="navigation">
        <%@ include file="leftnav.jsp" %>
      </td>
    <td width="550" class="page"> 
      <!-- START YOUR CODING HERE -->
      <%
            // Process new auction creation
            String username = request.getParameter("userid");
            String password = request.getParameter("password");
            String name = request.getParameter("user_name");
            String email = request.getParameter("email");
            String dob = request.getParameter("dob");
            String gender = request.getParameter("gender");
            String phone = request.getParameter("phone");
            String salstr=request.getParameter("salary");
            double salary=0;
            salstr=salstr.replaceAll(",", ""); //take out commas
            salstr=salstr.replaceAll("\\p{Alpha}", ""); //take out non-digits
            if(salstr.trim().length()!=0)
            {    salary=Double.parseDouble(salstr.trim());}
            if(gender==null)
            {gender="";}
           
            String errors=validateinfo(username.trim(), password.trim(), name.trim(), email.trim(), dob.trim(), gender.trim(), phone.trim(), salary);
            if(errors.length()==0)
            { 
                makeuser(username.trim(), password.trim(), name.trim(), email.trim(), dob.trim(), gender.trim(), phone.trim(), salary);            
            %>
      <!-- STOP YOUR CODING HERE -->
      <h1>User Created!</h1>
      <p>Thank you <% out.print(name); %> (<%out.print(username); %>) for creating an account!</p>
         <% } //if validateinfo...
            else
            {
               out.print(errors); 
            }%>
    </td>
  </tr>
  </table>
  </body>
</html>
