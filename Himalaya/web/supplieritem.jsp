<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>

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
        // Print item details
        rs=statement.executeQuery("SELECT Item_Name, Description, URL FROM Items WHERE ItemId=" + request.getParameter("itemid"));
        rs.next();
        out.println("<h1>" + rs.getString("ITEM_NAME") + "</h1>");
        out.println("<table border='0' width='100%'><tr><td><img src='" + rs.getString("URL") + "'></td><td class='page'><p><b>Description:</b> " + rs.getString("Description") + "</p>");
        
        rs=statement.executeQuery("SELECT Price FROM Sells WHERE ItemId=" + request.getParameter("itemid") + " AND SupplierId=" + request.getParameter("supplierid"));
        rs.next(); 
        String price = rs.getString("PRICE").trim();
        %>
      <p>Buy this item from this supplier for only $<% out.println(price); %>.</p>
      <form name="buynow" method="post" action="supplieritem_target.jsp">
        <input name="supplierid" type="hidden" id="supplierid" value="<% out.println(request.getParameter("supplierid")); %>">
        <input name="itemid" type="hidden" id="itemid" value="<% out.println(request.getParameter("itemid")); %>">
        <input name="price" type="hidden" id="price" value="<% out.println(price); %>">
        <input type="submit" name="Submit" value="Buy Now">
      </form>
      <p><a href="create_supplier_rating.jsp?supplierid=<% out.println(request.getParameter("supplierid")); %>">Rate this Supplier</a></p>
        <%
        out.println("</td></tr></table>");
      %>
      <table width="100%"> 
        <tr>
	  <td class="page">
	  <h2>Supplier Ratings</h2>
           <%
           int first=1;
           rs=statement.executeQuery("SELECT * FROM Rates_Suppliers WHERE SupplierId=" + request.getParameter("supplierid"));
            while(rs.next())
            {
                first=0;
                out.println("<p><b>" + rs.getString("Userid") + "</b> - Rating: " + rs.getString("Rating") + "<br>");
                out.println("Comments: " + rs.getString("comments") + "</p>");
            }
            if (first==1) out.println("No one has rated this supplier.");            
           %>
	  </td>
	  </tr>
	</table>

<!-- STOP YOUR CODING HERE -->
        </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>