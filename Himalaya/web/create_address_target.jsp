<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makeaddress(String street, String city, String state, String zip, String userid)
{
    dba.addNewAddress(street, city, state, zip, userid);
}
String validateinfo(String street, String city, String state, String zip)
{
    String returnme="";
    if(!(street.length()<=30
       && street.length()!=0
       && city.length()<=30
       && city.length()!=0
       && state.length()==2
       && zip.length()<=10
       && zip.length()!=0))
       {
            returnme+="<h3>Street must be at most 30 characters, "+
            "City must be at most 30 characters, "+
            "State must be exactly 2 characters, "+
            "Zip must be at most 10 digits.<br>"+
            "All fields are required.</h3>";
        }
        if(!ValidateInput.validateAddress(street))
        {
                returnme+="<h3>Invalid street.<br></h3>";
        }
        if(!ValidateInput.validateCity(city))
         {
                returnme+="<h3>Invalid city.<br></h3>";
         }
        if(!ValidateInput.validateState(state))
         {
                returnme+="<h3>Invalid state.<br></h3>";
         }
        if(!ValidateInput.validateZip(zip))
         {
                returnme+="<h3>Invalid zip.<br></h3>";
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
            String street = request.getParameter("street");
            String city = request.getParameter("city");
            String state = request.getParameter("USA_state");
            String zip = request.getParameter("zip");
            String userid = request.getParameter("userid");
            
            String errors=validateinfo(street.trim(), city.trim(), state.trim(), zip.trim());
            if(errors.length()!=0)
            {
                out.print(errors);
            }
            else
            {
                makeaddress(street.trim(), city.trim(), state.trim(), zip.trim(), userid.trim());
                        
       %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Address Created!</h1>
      <p>Thank you for linking this address to your account.  You can now use this address while checking out.</p></td>
  </tr>
  </table>
  </body>
</html>
<% } %>
<%@ include file="cleanup.jsp" %>