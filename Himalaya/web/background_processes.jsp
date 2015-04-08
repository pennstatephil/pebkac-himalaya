<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%!
DataBaseAccessor dba =  new DataBaseAccessor();
%>
<html>
  <head>
    <title>Himalaya.com [Search]</title>
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
        ResultSet rs1 = null;
        ResultSet rs2 = null;
        Statement statement1=null;
        Statement statement2=null;
        statement1=con.createStatement();
        statement2=con.createStatement();
        statement.executeUpdate("delete from HIMALAYA.AUCTIONS a WHERE (END_TIME < SYSDATE AND (MIN_BID < RESERVE_PRICE OR AUCTIONID NOT IN ( SELECT AUCTIONID FROM BIDS_ON b WHERE b.AUCTIONID = a.AUCTIONID )))");
        statement.executeUpdate("delete from HIMALAYA.AUCTIONS WHERE END_TIME+14 < SYSDATE");
        
        rs = statement.executeQuery("SELECT AUCTIONID FROM AUCTIONS WHERE END_TIME < SYSDATE AND MIN_BID >= RESERVE_PRICE AND AUCTIONID NOT IN ( SELECT AUCTIONID FROM ORDER_AUCTION_ITEMS )");
        while(rs.next())
        {
            rs1 = statement1.executeQuery("SELECT USERID, AMOUNT FROM BIDS_ON WHERE AUCTIONID = " + rs.getInt("AUCTIONID") + " ORDER BY AMOUNT DESC");
            if(rs1.next())
            {
                dba.addNewOrder("Not Paid", (rs1.getString("USERID")).trim());
                rs2 = statement2.executeQuery("SELECT * FROM ORDERS WHERE ROWNUM = 1 ORDER BY ORDERID DESC");
                rs2.next();
                int mostRecentOrder = Integer.parseInt(rs2.getString(1));
                dba.addNewOrder_Auction_Items(mostRecentOrder, rs.getInt("AUCTIONID"), rs1.getDouble("AMOUNT"));
                rs2.close();
                rs2=null;
            }
            rs1.close();
            rs1=null;
        }
        %><H1>Background Processes Complete!</h1>
      <p>All unsuccessful auctions have been removed, successful auctions have been moved into orders, and auctions that ended more than 2 weeks ago have been removed.</p>
  </table>
      <!-- STOP YOUR CODING HERE -->
  </body>
</html>
<%
rs.close();
rs=null;
%>
<%@ include file="cleanup.jsp" %>
