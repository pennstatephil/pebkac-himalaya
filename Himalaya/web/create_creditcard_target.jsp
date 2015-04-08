<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makecreditcard(String CC_number, String company, String expiration, String CVV, String name, String userid)
{
    dba.addNewCredit_Card(CC_number, company, expiration, CVV, name, userid);
}

String validateinfo(String number, String company, String expiration, String CVV, String name)
{
    String returnme="";
    if(!(number.length()<=16
       && number.length()!=0
       && company.length()<=30
       && company.length()!=0
       && expiration.length()<=7
       && expiration.length()!=0
       && CVV.length()<=3
       && CVV.length()!=0
       && name.length()<=50
       && name.length()!=0
       ))
       {
            returnme+="<h3>Card Number must be at most 16 characters, "+
            "Company must be at most 30 characters, "+
            "Name must be at most 50 characters, "+
            "Expiration must be at most 7 characters.<br>"+
            "All fields are required.</h3>";
        }
        if(!ValidateInput.validateFullName(name))
        {
                returnme+="<h3>Invalid name.<br></h3>";
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
            String CC_number = request.getParameter("CC_number");
            String company = request.getParameter("company");
            String expiration = request.getParameter("expiration");
            String CVV = request.getParameter("CVV");
            String name = request.getParameter("Name_on_Card");
            String userid = request.getParameter("userid");
            
            CC_number=CC_number.replaceAll("\\p{Alpha}", "");
            expiration=expiration.replaceAll("\\p{Alpha}", "");
            CVV=CVV.replaceAll("\\p{Alpha}", "");
            
            String errors=validateinfo(CC_number.trim(), company.trim(), expiration.trim(), CVV.trim(), name.trim());
            
            if(errors.length()!=0)
            {
                out.print(errors);
            }
            else
            {
                makecreditcard(CC_number.trim(), company.trim(), expiration.trim(), CVV.trim(), name.trim(), userid.trim());            
       %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Credit Card Added!</h1>
      <p>Thank you for linking this credit card to your account.  You can now use this card while checking out.</p></td>
  </tr>
  </table>
  </body>
</html>
<% } %>
<%@ include file="cleanup.jsp" %>