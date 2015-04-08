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
      <h1>Add a New Item to the Marketplace</h1>
	  
      <form name="sdd_item" method="post" action="create_item_target.jsp">
        <p>Item Name:<br>
          <input name="item_name" type="text" id="item_name" size="30">
        </p>
        <p>Provide a brief description of the item:<br>
          <textarea name="description" cols="60" rows="4" id="description"></textarea>
        </p>
        <p>Image URL: <br>
          <input name="url" type="text" id="url" size="70">
        </p>
        <p> Select a category for your new item:<br>
          <select name="category_name" id="category_name">
            <% // Populate the item box with all of the available categories
                rs=statement.executeQuery("SELECT CATEGORY_NAME, PARENT_CATEGORY FROM CATEGORIES ORDER BY CATEGORY_NAME, PARENT_CATEGORY");
                while(rs.next())
                {
                    out.println("<option value='" + rs.getString("CATEGORY_NAME") + "'>" + rs.getString("CATEGORY_NAME") + "</option>");
                }
              %>
          </select>
        </p>
        <p>
          <input type="submit" name="Submit" value="Add Item">
        </p>		
        </form>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>