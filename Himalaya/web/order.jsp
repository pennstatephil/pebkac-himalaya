<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%
    // Check to see if the viewing user is the user this order belongs to
    rs=statement.executeQuery("SELECT * FROM ORDERS WHERE ORDERID=" + request.getParameter("id"));
    rs.next();
    if (UserIdCookie.getValue().trim().equals(rs.getString("USERID").trim()))
    {
%>

<html>
  <head>
    <title>Himalaya.com [Order Page]</title>
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
      <% 
        // Create RS2 for use on this page
        Statement statement2=null;
        ResultSet rs2=null;
        statement2=con.createStatement();
 
        rs=statement.executeQuery("SELECT * FROM ORDERS WHERE ORDERID=" + request.getParameter("id"));
        rs.next();      
        // ***** SHOPPING CART STATUS
        
         if (rs.getString("ORDER_STATUS").trim().equals("Shopping Cart") || rs.getString("ORDER_STATUS").trim().equals("Not Paid"))
         {
            out.println("<h1>Shopping Cart</h1>");

            
            // ORDER AUCTION ITEMS CODE         
            //out.println("SELECT ORDER_AUCTION_ITEMS.WINNING_BID, ITEMS.ITEM_NAME, ITEMS.ITEMID, ITEMS.URL FROM ORDER_AUCTION_ITEMS, AUCTIONS, ITEMS WHERE AUCTIONS.ITEMID=ITEMS.ITEMID AND ORDER_AUCTION_ITEMS.AUCTIONID=AUCTIONS.AUCTIONID AND ORDER_AUCTION_ITEMS.ORDERID=" + request.getParameter("id"));
            rs2 = statement2.executeQuery("SELECT ORDER_AUCTION_ITEMS.WINNING_BID, ITEMS.ITEM_NAME, ITEMS.ITEMID, ITEMS.URL FROM ORDER_AUCTION_ITEMS, AUCTIONS, ITEMS WHERE AUCTIONS.ITEMID=ITEMS.ITEMID AND ORDER_AUCTION_ITEMS.AUCTIONID=AUCTIONS.AUCTIONID AND ORDER_AUCTION_ITEMS.ORDERID=" + request.getParameter("id"));
            int first=1;
            int count=0;

            out.println("<table border='0' width='100%'>");
            while(rs2.next())
            {
               if (first==1) out.println("<h2>Auction Item</h2>");
               first=0;
               if(count%1==0) out.println("<tr>");
               //out.println("<td class='page'><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'><img width='100' border='0' src='" + rs2.getString("URL") + "'><p>" + rs2.getString("ITEM_NAME") + "<b>$" + rs2.getString("WINNING_BID") + "</b></p></a></td>");
               out.println("<td class='page'><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'><img width='100' border='0' src='" + rs2.getString("URL") + "'></a></td><td class='page'><p><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'>" + rs2.getString("ITEM_NAME") + "</a><br><b>$" + rs2.getString("WINNING_BID") + "</b></p></a></td>");
               count++;
               if(count%1==0) out.println("</tr>");
            }
            out.println("</table>");
              
            // ORDER SALE ITEMS CODE
            
            rs2 = statement.executeQuery("SELECT * FROM ORDER_SALE_ITEMS, SELLS, ITEMS WHERE ORDER_SALE_ITEMS.SUPPLIERID=SELLS.SUPPLIERID AND ORDER_SALE_ITEMS.ITEMID=SELLS.ITEMID AND SELLS.ITEMID=ITEMS.ITEMID AND ORDERID=" + rs.getString("ORDERID").trim());
            first=1;
            count=0;

            out.println("<table border='0' width='100%'>");
            while(rs2.next())
            {
               // Begin form
               out.println("<form name='shopping_cart' method='post' action='order_target.jsp'>");
               
               if (first==1) out.println("<h2>Sale Items</h2>");
               first=0;
               if(count%1==0) out.println("<tr>");
               out.println("<td class='page'><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'><img width='100' border='0' src='" + rs2.getString("URL") + "'></a></td><td class='page'><p><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'>" + rs2.getString("ITEM_NAME") + "</a><br><b>$" + rs2.getString("PRICE") + "</b></p></a></td><td><input type='text' name='itemqty' value='" + rs2.getString("QUANTITY") + "' size='2'><input type='submit' name='Submit' value='Update Qty'></td>");
               count++;
               if(count%1==0) out.println("</tr>");
               
               // End form
               out.println("<input name='supplierid' type='hidden' value='" + rs2.getString("SUPPLIERID").trim() + "'>");
               out.println("<input name='itemid' type='hidden' value='" + rs2.getString("ITEMID").trim() + "'>");
               out.println("<input name='orderid' type='hidden' value='" + request.getParameter("id") + "'>");
               out.println("</form>");
            }
            rs2=statement.executeQuery("SELECT SUM(PURCHASE_PRICE*QUANTITY) AS ORDER_TOTAL FROM ORDER_SALE_ITEMS WHERE ORDERID=" + request.getParameter("id"));
            rs2.next();
            if (first==0) out.println("<tr><td></td><td><h2>Total: $" + rs2.getString("ORDER_TOTAL") + "</h2></td></tr>");
            out.println("</table>");
            
            out.println("<p><b>Select your order options:</b></p>");
            
            // Begin form
            out.println("<form name='shopping_cart' method='post' action='order_target.jsp'>");
            
            // Credit card option
            
            out.println("<p>Credit card:");
            
            out.println("<select name='CC_Number' id='CC_Number'>");

            rs2=statement.executeQuery("SELECT CC_Number, Company FROM Credit_Cards WHERE UserId='" + UserIdCookie.getValue().trim() + "'");
            while(rs2.next())
            {
                out.println("<option value='" + rs2.getString("CC_Number") + "'>" + rs2.getString("Company").trim() + " - " + rs2.getString("CC_Number").trim() + "</option>");
            }

            out.println("</select> [ <a href='create_creditcard.jsp' target='_blank'>Add</a> ]</p>");
                  
            // Billing address option
            
            out.println("<p>Billing address:");
            
            out.println("<select name='BillingAddressID' id='BillingAddressID'>");

            rs2=statement.executeQuery("SELECT * FROM Addresses WHERE UserId='" + UserIdCookie.getValue().trim() + "'");
            while(rs2.next())
            {
                out.println("<option value='" + rs2.getString("AddressID") + "'>" + rs2.getString("Street").trim() + ", " + rs2.getString("City").trim() + ", " + rs2.getString("USA_State").trim() + " " + rs2.getString("Zip").trim() + "</option>");
            }

            out.println("</select> [ <a href='create_address.jsp' target='_blank'>Add</a> ]</p>");
            
            // Billing address option
            
            out.println("<p>Shipping address:");
            
            out.println("<select name='ShippingAddressID' id='ShippingAddressID'>");

            rs2=statement.executeQuery("SELECT * FROM Addresses WHERE UserId='" + UserIdCookie.getValue().trim() + "'");
            while(rs2.next())
            {
                out.println("<option value='" + rs2.getString("AddressID") + "'>" + rs2.getString("Street").trim() + ", " + rs2.getString("City").trim() + ", " + rs2.getString("USA_State").trim() + " " + rs2.getString("Zip").trim() + "</option>");
            }

            out.println("</select>  [ <a href='create_address.jsp' target='_blank'>Add</a> ]</p>");
            
            out.println("<input name='orderid' type='hidden' value='" + request.getParameter("id") + "'>");
            out.println("<input type='submit' name='Submit' value='Confirm Purchase'></form>");

         }
        
        // ***** ALL OTHER ORDER STATUSES...
        
         else
         {
            rs=statement.executeQuery("SELECT * FROM ORDERS WHERE ORDERID=" + request.getParameter("id"));
            rs.next(); 
            String OrderId = rs.getString("ORDERID").trim();
            
            out.println("<h1>Order # " + OrderId + "</h1>");
            out.println("<p><b>Order Date:</b> " + rs.getString("ORDER_DATE").trim() + "<br>");
            out.println("<b>Order Status:</b> " + rs.getString("ORDER_STATUS").trim() + "</p>");
            
            // CREDIT CARD CODE
            
           out.println("<h2>Credit Card</h2>");
           //out.println("SELECT * FROM ORDER_ADDRESSES, ADDRESSES WHERE ORDER_ADDRESSES.TYPE_OF_ADDRESS='Billing' AND ORDER_ADDRESSES.ADDRESSID=ADDRESSES.ADDRESSID AND ORDER_ADDRESSES.ORDERID=" + OrderId);
           rs2=statement.executeQuery("SELECT * FROM ORDER_CREDIT_CARDS, CREDIT_CARDS WHERE ORDER_CREDIT_CARDS.CC_NUMBER=CREDIT_CARDS.CC_NUMBER AND ORDER_CREDIT_CARDS.ORDERID=" + OrderId);
            
            if(rs2.next())
            { 
                out.println("<p>" + rs2.getString("Company") + " - " + rs2.getString("CC_Number") + "</p>");
            }
           else
            {
                out.println("No credit card specified.");
            }            
            
            // BILLING ADDRESS CODE
            
           out.println("<h2>Billing Address</h2>");
           //out.println("SELECT * FROM ORDER_ADDRESSES, ADDRESSES WHERE ORDER_ADDRESSES.TYPE_OF_ADDRESS='Billing' AND ORDER_ADDRESSES.ADDRESSID=ADDRESSES.ADDRESSID AND ORDER_ADDRESSES.ORDERID=" + OrderId);
           rs2=statement.executeQuery("SELECT * FROM ORDER_ADDRESSES, ADDRESSES WHERE ORDER_ADDRESSES.TYPE_OF_ADDRESS='Billing' AND ORDER_ADDRESSES.ADDRESSID=ADDRESSES.ADDRESSID AND ORDER_ADDRESSES.ORDERID=" + OrderId);
            
            if(rs2.next())
            { 
                out.println("<p>" + rs2.getString("Street") + "<br>");
                out.println(rs2.getString("City")+", " + rs2.getString("USA_State") + " " + rs2.getString("Zip") + "</p>");
            }
           else
            {
                out.println("<p>No billing address specified.</p>");
            }
           
            // SHIPPING ADDRESS CODE
            
            out.println("<h2>Shipping Address</h2>");
            
            //out.println("SELECT * FROM ORDER_ADDRESSES, ADDRESSES WHERE ORDER_ADDRESSES.TYPE_OF_ADDRESS='Shipping' AND ORDER_ADDRESSES.ADDRESSID=ADDRESSES.ADDRESSID AND ORDERID=" + rs.getString("ORDERID").trim());
            rs2=statement.executeQuery("SELECT * FROM ORDER_ADDRESSES, ADDRESSES WHERE ORDER_ADDRESSES.TYPE_OF_ADDRESS='Shipping' AND ORDER_ADDRESSES.ADDRESSID=ADDRESSES.ADDRESSID AND ORDERID=" + OrderId);
            if(rs2.next())
            {
            
                out.println("<p>"+rs2.getString("Street")+"<br>");
                out.println(rs2.getString("City")+", " + rs2.getString("USA_State") + " " + rs2.getString("Zip") + "</p>");
            }
            else
            {
                out.println("<p>No shipping address specified.</p>");
            }
        
            // ORDER AUCTION ITEMS CODE
            
            rs2 = statement.executeQuery("SELECT ORDER_AUCTION_ITEMS.WINNING_BID, ITEMS.ITEM_NAME, ITEMS.ITEMID, ITEMS.URL FROM ORDER_AUCTION_ITEMS, AUCTIONS, ITEMS WHERE AUCTIONS.ITEMID=ITEMS.ITEMID AND ORDER_AUCTION_ITEMS.AUCTIONID=AUCTIONS.AUCTIONID AND ORDER_AUCTION_ITEMS.ORDERID=" + OrderId);
            int first=1;
            int count=0;

            out.println("<table border='0' width='100%'>");
            while(rs2.next())
            {
               if (first==1) out.println("<h2>Auction Item</h2>");
               first=0;
               if(count%1==0) out.println("<tr>");
               //out.println("<td class='page'><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'><img width='100' border='0' src='" + rs2.getString("URL") + "'><p>" + rs2.getString("ITEM_NAME") + "<b>$" + rs2.getString("WINNING_BID") + "</b></p></a></td>");
               out.println("<td class='page'><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'><img width='100' border='0' src='" + rs2.getString("URL") + "'></a></td><td class='page'><p><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'>" + rs2.getString("ITEM_NAME") + "</a><br><b>$" + rs2.getString("WINNING_BID") + "</b></p></a></td>");
               count++;
               if(count%1==0) out.println("</tr>");
            }
            out.println("</table>");             
            
            // ORDER SALE ITEMS CODE
            
            rs2 = statement.executeQuery("SELECT ORDER_SALE_ITEMS.QUANTITY, ORDER_SALE_ITEMS.PURCHASE_PRICE, ITEMS.ITEM_NAME, ITEMS.ITEMID, ITEMS.URL FROM ORDER_SALE_ITEMS, SELLS, ITEMS WHERE ORDER_SALE_ITEMS.SUPPLIERID=SELLS.SUPPLIERID AND ORDER_SALE_ITEMS.ITEMID=SELLS.ITEMID AND SELLS.ITEMID=ITEMS.ITEMID AND ORDER_SALE_ITEMS.ORDERID=" + OrderId);
            first=1;
            count=0;

            out.println("<table border='0' width='100%'>");
            while(rs2.next())
            {
               if (first==1) out.println("<h2>Sale Items</h2>");
               first=0;
               if(count%1==0) out.println("<tr>");
               out.println("<td class='page'><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'><img width='100' border='0' src='" + rs2.getString("URL") + "'></a></td><td class='page'><p><a href='item.jsp?id=" + rs2.getString("ITEMID") +"'>" + rs2.getString("ITEM_NAME") + "</a><br><b>$" + rs2.getString("PURCHASE_PRICE") + "</b></p></a></td>");
               count++;
               if(count%1==0) out.println("</tr>");
            }
            rs2=statement.executeQuery("SELECT SUM(PURCHASE_PRICE*QUANTITY) AS ORDER_TOTAL FROM ORDER_SALE_ITEMS WHERE ORDERID=" + OrderId);
            rs2.next();
            if (first==0) out.println("<tr><td></td><td><h2>Order Total: $" + rs2.getString("ORDER_TOTAL") + "</h2></td></tr>");
            out.println("</table>");
            
        }
      %>             
      </td></tr>
  </table>
  </body>
</html>
<%
    } // End check whether order belongs to the user
    else
    {
        out.println("You are not authorized to view this page.");
    }
%>
<%@ include file="cleanup.jsp" %>