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
        // Check to see if the user has a shopping cart, if not, create a shopping cart for the user
        rs=statement.executeQuery("SELECT ORDERID FROM ORDERS WHERE ORDER_STATUS='Shopping Cart' AND USERID='" + UserIdCookie.getValue().trim() + "'");
        //out.println("SELECT ORDERID FROM ORDERS WHERE ORDER_STATUS='Shopping Cart' AND USERID='" + UserIdCookie.getValue().trim() + "'");
        String OrderId;
        
        if(rs.next())
        {
            rs=statement.executeQuery("SELECT ORDERID FROM ORDERS WHERE ORDER_STATUS='Shopping Cart' AND USERID='" + UserIdCookie.getValue().trim() + "'");
            rs.next();
            OrderId = rs.getString("ORDERID");
            //out.println("For debug only: Shopping cart found.");            
        } // If the user does not have a shopping cart then create one
        else
        {
            // Insert new order/shopping cart
            //out.println("For debug only: Shopping cart not found. Creating...");
            //out.println("INSERT INTO ORDERS VALUES (order_seq.nextval, SYSDATE, 'Shopping Cart', '" + UserIdCookie.getValue().trim() + "')");
            rs=statement.executeQuery("INSERT INTO ORDERS VALUES (order_seq.nextval, SYSDATE, 'Shopping Cart', '" + UserIdCookie.getValue().trim() + "')");
            //rs.next();
            // Now get the order id for the new shopping cart
            rs=statement.executeQuery("SELECT ORDERID FROM ORDERS WHERE ORDER_STATUS='Shopping Cart' AND USERID='" + UserIdCookie.getValue().trim() + "'");
            rs.next();
            OrderId = rs.getString("ORDERID");            
        }
        
        // Insert purchased item into ORDER_SALE_ITEMS table for this order
        //out.println("INSERT INTO ORDER_SALE_ITEMS VALUES (" + OrderId + ", " + request.getParameter("supplierid") + ", " + request.getParameter("itemid") + ", 1, " + request.getParameter("price") + ")");
        rs=statement.executeQuery("INSERT INTO ORDER_SALE_ITEMS VALUES (" + OrderId + ", " + request.getParameter("supplierid") + ", " + request.getParameter("itemid") + ", 1, " + request.getParameter("price") + ")");      
        response.sendRedirect("order.jsp?id=" + OrderId);  
    %>
    <h1>Item Added</h1>
    <p>The item has been added to your <a href="order.jsp?id=<% out.println(OrderId); %>">shopping cart</a>.</p>
        <!-- STOP YOUR CODING HERE -->
        </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>