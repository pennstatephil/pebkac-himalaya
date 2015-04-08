<%@ include file="session.jsp" %>

<html>
  <head>
    <title>Himalaya.com [<% out.println("Item ID # " + request.getParameter("id")); %>]</title>
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
      <%
        // Print item details
        rs=statement.executeQuery("SELECT Item_Name, Description, URL FROM Items WHERE ItemId=" + request.getParameter("id"));
        rs.next();
        out.println("<h1>" + rs.getString("ITEM_NAME") + "</h1>");
        out.println("<table border='0' width='100%'><tr><td><img src='" + rs.getString("URL") + "'></td><td class='page'><p><b>Description:</b> " + rs.getString("Description") + "</p>" +
        "<p><a href='create_auction.jsp?type=existing&itemid=" + request.getParameter("id") + "'>Auction this Item</a></p>" +
        "<p><a href='create_item_rating.jsp?itemid=" + request.getParameter("id") + "'>Rate this Item</a></p>" +
        "</td></tr></table>");
      %>
      <table border="0" width="100%"><tr>
        <td class="page">
            <h2>Current Suppliers</h2>
            <%
            int first=1;
            rs=statement.executeQuery("SELECT * FROM Sells, Suppliers WHERE Suppliers.SupplierID=Sells.SupplierID AND ItemId=" + request.getParameter("id"));
            while(rs.next())
            {
                first=0;
                int inventory = rs.getInt("INVENTORY");
                if (inventory > 0) {
                    out.println("<p><a href='supplieritem.jsp?itemid=" + rs.getString("ITEMID") + "&supplierid=" + rs.getString("SUPPLIERID") + "'>Supplier: " + rs.getString("SUPPLIER_NAME") + "<br>");
                    out.println("Price: $" + rs.getString("PRICE") + "</a><br>");
                    out.println("<font color='darkgreen'>IN STOCK</font></p>");
                }
                else {
                    out.println("<p>Supplier: " + rs.getString("SUPPLIER_NAME") + "<br>");
                    out.println("Price: $" + rs.getString("PRICE") + "<br>");
                    out.println("<span class='error'>OUT OF STOCK</span></p>");                   
                }
            }
            if (first==1) out.println("No suppliers are selling this item at this time.");
            %>
        </td>
        <td class="page">
            <h2>Current Auctions</h2>
            <%
            first=1;
            rs=statement.executeQuery("SELECT * FROM Auctions WHERE ItemId=" + request.getParameter("id") + " AND END_TIME > SYSDATE ORDER BY END_TIME ASC");
            while(rs.next())
            {
                first=0;
                out.println("<p><a href='auction.jsp?id=" + rs.getString("AUCTIONID") + "'>Seller: " + rs.getString("USERID") + "<br>");
                out.println("Current Bid: $" + rs.getString("MIN_BID") +  "</a></p>");
            }
            if (first==1) out.println("No one is auctioning this item at this time.");           
            %>
        </td>
      </tr>
	  <tr>
	  <td colspan="2" class="page">
	  <h2>Item Ratings</h2>
           <%
           first=1;
           rs=statement.executeQuery("SELECT * FROM Rates_Items WHERE ItemId=" + request.getParameter("id"));
            while(rs.next())
            {
                first=0;
                out.println("<p><b>" + rs.getString("Userid") + "</b> - Rating: " + rs.getString("Rating") + "<br>");
                out.println("Comments: " + rs.getString("comments") + "</p>");
            }
            if (first==1) out.println("No one has rated this item.");            
           %>
	  </td>
	  </tr>
	  </table>
      <!-- STOP YOUR CODING HERE -->
      </td></tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>