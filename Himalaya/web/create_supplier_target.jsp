<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%@page import="himalaya.*"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
String validateinfo(String name, String address, String poc, String phone, String cat)
{
    String returnme="";
    if(!(name.length()<=30
       && name.length()!=0
       && address.length()<=50
       && address.length()!=0
       && poc.length()<=30
       && poc.length()!=0
       && cat.length()<=30
       && cat.length()!=0
       && phone.length()==12))
       {
            returnme+="<h3>Company name must be at most 30 characters, "+
            "Address must be at most 50 characters, "+
            "Point of Contact must be at most 30 characters, "+
            "Category must be at most 30 characters, "+
            "Phone must be exactly 12 characters (xxx-xxx-xxxx).<br>"+
            "All fields are required.</h3>";
        }
        if(!ValidateInput.validateFullName(poc))
        {
                returnme+="<h3>Invalid Point Of Contact name.<br></h3>";
        }
        if(!ValidateInput.validatePhone(phone))
         {
                returnme+="<h3>Invalid phone.<br></h3>";
         }
        if(!ValidateInput.validateAddress(address))
         {
                returnme+="<h3>Invalid address.<br></h3>";
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
            String name = request.getParameter("supplier_name");
            String address = request.getParameter("supplier_address");
            String poc = request.getParameter("point_of_contact");
            String phone = request.getParameter("phone");
            String category = request.getParameter("company_category");
            
            String errors=validateinfo(name.trim(), address.trim(), poc.trim(), phone.trim(), category.trim());
            if(errors.length()!=0)
            {
                out.print(errors);
            }
            else
            {
                dba.addNewSupplier(name.trim(), address.trim(), poc.trim(), phone.trim(), category.trim());
            //out.println("INSERT INTO Suppliers VALUES ('" + id + "', '" + name + "', '" + address + "', '" + poc + "', '" + phone + "', '" + category + "')");
            //rs=statement.executeQuery("INSERT INTO Suppliers VALUES (supplier_seq.nextval, '" + name + "', '" + address + "', '" + poc + "', '" + phone + "', '" + category + "')");
            //rs.next();             
       %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Supplier Created!</h1>
      <p>This supplier can now add items to their inventory.</p>
    </td>
  </tr>
  </table>
  </body>
</html>
<% } %>