<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>

<html>
  <head>
    <title>Himalaya.com [MyAccount]</title>
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
        // Create query for use on this page
        if(UserIdCookie!=null)
        {
            rs=statement.executeQuery("SELECT Administrator, Password, userid,user_name,email,dob,gender FROM Users WHERE UserId = '" + UserIdCookie.getValue() + "'");
            rs.next();
      %>
      <h1>My Account: <%=rs.getString("user_name").trim() %> (<%=rs.getString("userid").trim()%>)</h1>
        
      <p><a href="create_address.jsp">Add Address</a> | <a href="create_creditcard.jsp">Add 
        Credit Card</a> | <a href="create_auction.jsp">Start an Auction</a> | 
        <a href="logout.jsp">Logout</a></p>
      <% if(rs.getString("administrator").equals("1"))
          {
      %>
      <p><b>Admin Options:</b> <a href="create_supplier.jsp">Add Supplier</a> 
        | <a href="create_item.jsp">Add Item</a> | <a href="create_inventory.jsp">Add 
        Inventory</a></p>
        <% } %>
        
      <h2>Auctions I'm Bidding On </h2>
        <%
            int first=0;
            rs=statement.executeQuery("SELECT DISTINCT AUCTIONS.AUCTIONID, ITEMS.ITEM_NAME FROM ITEMS, AUCTIONS, BIDS_ON WHERE AUCTIONS.ITEMID=ITEMS.ITEMID AND AUCTIONS.AUCTIONID=BIDS_ON.AUCTIONID AND BIDS_ON.USERID='" + UserIdCookie.getValue().trim() + "'");
            while(rs.next())
            {
                first=1;
                out.println("<a href='auction.jsp?id=" + rs.getString("AuctionId") + "'>" + rs.getString("Item_Name") + "</a><br>");
            }
            if(first==0) out.println("You are not currently bidding on any items.");
        %>
        
      <h2>Items I'm Auctioning</h2>
        <p>
        <%
        first=0;
            rs=statement.executeQuery("SELECT AUCTIONS.AUCTIONID, ITEMS.ITEM_NAME FROM AUCTIONS, ITEMS WHERE AUCTIONS.ITEMID=ITEMS.ITEMID AND UserId='" + UserIdCookie.getValue().trim() + "'");
            while(rs.next())
            {
                first=1;
                out.println("<a href='auction.jsp?id=" + rs.getString("AuctionId") + "'>" + rs.getString("Item_Name") + "</a><br>");
            }
            if(first==0) out.println("You are not currently auctioning any items.");
        %>
        </p>       
      <h2>Order Status Center</h2>
      <p>
      <%     
            first=0;
            rs=statement.executeQuery("SELECT ORDERS.ORDERID, ORDERS.ORDER_DATE, ORDERS.ORDER_STATUS FROM ORDERS WHERE ORDERS.USERID='" + UserIdCookie.getValue().trim() + "' ORDER BY ORDERS.ORDER_DATE DESC");
            while(rs.next())
            {
                first=1;
                out.println("<a href='order.jsp?id=" + rs.getString("ORDERID") + "'>Order # " + rs.getString("ORDERID") + " (Order Date: " + rs.getString("ORDER_DATE") + ") (Order Status: " + rs.getString("ORDER_STATUS") + ")</a><br>");
            }
            if(first==0) out.println("You do not have any orders at this time.");
        %>
    </p>
        <%
        }
      %>
      <!-- STOP YOUR CODING HERE -->
      </td></tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>
