<%@ include file="session.jsp" %>

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
      </td><td width="550" class="page">
      <!-- START YOUR CODING HERE -->
      <h1>Add Inventory</h1>
	  
      <form action="create_inventory_target.jsp" method="post" name="add_inventory" id="add_inventory">
        <p>Supplier: 
          <select name="SupplierID" id="SupplierID">
              <%
                rs=statement.executeQuery("SELECT SupplierID, Supplier_Name FROM Suppliers");
                while(rs.next())
                {
                    out.println("<option value='" + rs.getString("SupplierID") + "'>" + rs.getString("Supplier_Name").trim() + "</option>");
                }
              %>
          </select>
        </p>
        <p>Item: 
          <select name="ItemID" id="ItemID">
              <%
                rs=statement.executeQuery("SELECT ItemID, Item_Name FROM Items ORDER BY Item_Name");
                while(rs.next())
                {
                    out.println("<option value='" + rs.getString("ItemID").trim() + "'>" + rs.getString("Item_Name").trim() + "</option>");
                }
              %>
          </select>
        </p>
        <p>Price: 
          <input name="Price" type="text" id="Price" size="30">
        </p>
        <p>Inventory: 
          <input name="Inventory" type="text" id="Inventory">
        </p>
        <p>
          <input type="submit" name="Submit" value="Add Inventory">
        </p>		
        </form>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>