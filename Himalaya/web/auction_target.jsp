<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makeBid(int auctionId, String userid, double bid)
{
    dba.addNewBid(auctionId, userid, bid);
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
        ResultSet rs1=null;
        ResultSet rs2=null;
        Statement statement1=null;
        Statement statement2=null;
        statement1=con.createStatement();
        statement2=con.createStatement();
      
        String bid = request.getParameter("amount");
        String buyItNowPrice = request.getParameter("BuyNowPrice");
        String UserId = request.getParameter("userid");
        String AuctionId = request.getParameter("auctionid");
        if (!dba.auctionOver(Integer.parseInt(AuctionId.trim())))
        {
            if (request.getParameter("Bid") != null && request.getParameter("Bid").equals("Bid"))
            {
                makeBid(Integer.parseInt(AuctionId.trim()), UserId.trim(), Double.parseDouble(bid.trim()));
                %>
                <h1>Bid Added!</h1>
                <p>Thank you for bidding! You can view the status of the auction on the <a href="myaccount.jsp">MyAccount</a> 
                page.</p></td>
        <%
            }
            else    //buy it now
            {
                makeBid(Integer.parseInt(AuctionId.trim()), UserId.trim(), Double.parseDouble(buyItNowPrice.trim()));
                dba.endAuction(Integer.parseInt(AuctionId.trim()));
                dba.addNewOrder("Not Paid", UserId.trim());
                rs1 = statement1.executeQuery("SELECT ORDERID AS A FROM ( SELECT * FROM ORDERS ORDER BY ORDERID DESC ) WHERE ROWNUM = 1");
                rs1.next();
                int mostRecentOrder = Integer.parseInt(rs1.getString("A"));
                
                rs2 = statement2.executeQuery("SELECT AMOUNT AS B FROM ( SELECT * FROM BIDS_ON WHERE USERID = '" + UserId.trim() + "' AND AUCTIONID = '" + Integer.parseInt(AuctionId.trim()) + "' AND ROWNUM <= 2 ORDER BY AMOUNT DESC ) WHERE ROWNUM = 1");
                rs2.next();
                double winningBid = Double.parseDouble(rs2.getString("B"));
                //dba.processBuyNow(Integer.parseInt(AuctionId.trim()), UserId.trim());
                dba.addNewOrder_Auction_Items(mostRecentOrder, Integer.parseInt(AuctionId.trim()), winningBid);
                rs1.close();
                rs1=null;
                rs2.close();
                rs2=null;
                response.sendRedirect("order.jsp?id=" + mostRecentOrder); 
                %>
                <h1>You used buy it now!</h1>
                <p>Click Proceed to Checkout to finalize your purchase.
                <%
            }
       }
       else {%>
                <H1>Auction Over!</H1>
       <% } %>
      
      <!-- STOP YOUR CODING HERE -->
      
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>
