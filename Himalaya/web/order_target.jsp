<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>

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
            // Update the order from shopping cart status to shipped on order confirmation
            if(request.getParameter("Submit").trim().equals("Confirm Purchase"))
            {
                // Set order credit card
                //out.println("INSERT INTO ORDER_CREDIT_CARDS VALUES (" + request.getParameter("orderid").trim() + ", '" + request.getParameter("CC_Number").trim() + "')");
                rs=statement.executeQuery("INSERT INTO ORDER_CREDIT_CARDS VALUES (" + request.getParameter("orderid").trim() + ", '" + request.getParameter("CC_Number").trim() + "')");
                rs.next();
                
                // Set order billing address
                //out.println("INSERT INTO ORDER_ADDRESSES VALUES (" + request.getParameter("orderid").trim() + ", " + request.getParameter("BillingAddressID").trim() + ", 'Billing')");
                rs=statement.executeQuery("INSERT INTO ORDER_ADDRESSES VALUES (" + request.getParameter("orderid").trim() + ", " + request.getParameter("BillingAddressID").trim() + ", 'Billing')");
                rs.next();
                
                // Set order shipping address
                //out.println("INSERT INTO ORDER_ADDRESSES VALUES (" + request.getParameter("orderid").trim() + ", " + request.getParameter("BillingAddressID").trim() + ", 'Shipping')");
                rs=statement.executeQuery("INSERT INTO ORDER_ADDRESSES VALUES (" + request.getParameter("orderid").trim() + ", " + request.getParameter("ShippingAddressID").trim() + ", 'Shipping')");
                rs.next();
                
                // Update inventory for each item purchased for this order
                Statement statement2=null;
                ResultSet rs2=null;
                statement2=con.createStatement();
                
                //out.println("SELECT * FROM ORDER_SALE_ITEMS WHERE ORDERID=" + request.getParameter("orderid").trim());
                rs=statement.executeQuery("SELECT * FROM ORDER_SALE_ITEMS WHERE ORDERID=" + request.getParameter("orderid").trim());
                while(rs.next()) {
                    //out.println("UPDATE SELLS SET INVENTORY=INVENTORY-" + rs.getString("QUANTITY") + " WHERE SUPPLIERID=" + rs.getString("SUPPLIERID") + " AND ITEMID=" + rs.getString("ITEMID"));
                    rs2=statement2.executeQuery("UPDATE SELLS SET INVENTORY=INVENTORY-" + rs.getString("QUANTITY") + " WHERE SUPPLIERID=" + rs.getString("SUPPLIERID") + " AND ITEMID=" + rs.getString("ITEMID"));
                    rs2.next();
                }
                
                // Set order status from shopping cart to purchased
                //out.println("UPDATE ORDERS SET ORDER_STATUS='Purchased' WHERE ORDERID=" + request.getParameter("orderid").trim());
                rs=statement.executeQuery("UPDATE ORDERS SET ORDER_STATUS='Purchased', ORDER_DATE=SYSDATE WHERE ORDERID=" + request.getParameter("orderid").trim());
                rs.next();
                
                out.println("<h1>Purchase Complete</h1>");
                out.println("Thank you for using Himalaya.com!");
            }
            // If updating quantity...
            else if (request.getParameter("Submit").trim().equals("Update Qty")) {
                // If new quantity is 0, then delete it from the ORDER_SALE_ITEMS table
                if (request.getParameter("itemqty").trim().equals("0")) {
                    //out.println("DELETE FROM ORDER_SALE_ITEMS WHERE OrderId=" + request.getParameter("orderid").trim() + " AND ItemId=" + request.getParameter("itemid").trim() + " AND SupplierId=" + request.getParameter("supplierid").trim());
                    rs=statement.executeQuery("DELETE FROM ORDER_SALE_ITEMS WHERE OrderId=" + request.getParameter("orderid").trim() + " AND ItemId=" + request.getParameter("itemid").trim() + " AND SupplierId=" + request.getParameter("supplierid").trim());
                    rs.next();
                }
                // Else just update the quantity to the new value
                else {
                    rs=statement.executeQuery("UPDATE ORDER_SALE_ITEMS SET QUANTITY=" + request.getParameter("itemqty").trim() + " WHERE OrderId=" + request.getParameter("orderid").trim() + " AND ItemId=" + request.getParameter("itemid").trim() + " AND SupplierId=" + request.getParameter("supplierid").trim());
                    rs.next();
                }   
                response.sendRedirect("order.jsp?id=" + request.getParameter("orderid").trim());                           
            }
        %>
      </td></tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>