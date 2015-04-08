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
      <h1>Add a New Supplier</h1>
	  
      <form action="create_supplier_target.jsp" method="post" name="add_supplier" id="add_supplier">
        <p>Supplier Name: 
          <input name="supplier_name" type="text" id="supplier_name" size="30">
        </p>
        <p>Supplier Address:
          <input name="supplier_address" type="text" id="supplier_address" size="50">
        </p>
        <p>Point of Contact: 
          <input name="point_of_contact" type="text" id="point_of_contact" size="30">
        </p>
        <p>Phone: 
          <input name="phone" type="text" id="phone">
        </p>
        <p>Company Category: 
          <input name="company_category" type="text" id="company_category">
        </p>
        <p>
          <input type="submit" name="Submit" value="Add Supplier">
        </p>		
        </form>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>