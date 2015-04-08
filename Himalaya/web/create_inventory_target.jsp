<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%!
String validateinfo(String price, String inv)
{
     String returnme="";
    if(!(price.length()<=63
       && price.length()!=0
       && inv.length()<=22
       && inv.length()!=0))
       {
            returnme+="<h3>Price must be at most 63 characters, "+
            "Inventory must be at most 22 characters.<br>"+
            "All fields are required.</h3>";
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
            String supplier = request.getParameter("SupplierID").trim();
            String item = request.getParameter("ItemID").trim();
            String price = request.getParameter("Price").trim();
            String inv = request.getParameter("Inventory").trim();
            //rs=statement.executeQuery("select * from HIMALAYA.SUPPLIERS WHERE SUPPLIER_NAME='Dell'");
            //rs.next();
            //out.println("SupplierID= '" + rs.getString("SUPPLIERID") + "'");
            //out.println("INSERT INTO Sells (SUPPLIERID, ITEMID, PRICE, INVENTORY) VALUES (" + supplier + ", " + item + ", " + price + ", " + inv + ")");
            
            price=price.replaceAll("\\p{Alpha}", ""); //take out non-digits
            inv=inv.replaceAll("\\p{Alpha}", ""); //take out non-digits
            
            
            String errors=validateinfo(price.trim(), inv.trim());
            if(errors.length()!=0)
            {
                out.print(errors);
            }
            else
            {
                rs=statement.executeQuery("INSERT INTO Sells (SUPPLIERID, ITEMID, PRICE, INVENTORY) VALUES (" + supplier + ", " + item + ", " + price + ", " + inv + ")");
                rs.next();          
       %>      
      <h1>Inventory Updated</h1>
      <p>Thank you for adding your inventory to Himalaya.com.</p>
      <!-- STOP YOUR CODING HERE --></td>
  </tr>
  </table>
  </body>
</html>
<% } %>
<%@ include file="cleanup.jsp" %>