<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%@page import="himalaya.*"%>
<%@page contentType="text/html" import="java.util.Calendar,java.text.SimpleDateFormat,java.util.Date"%>

<html>
  <head>
    <title>Himalaya.com [<% out.println("Auction ID # " + request.getParameter("id")); %>]</title>
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
        // Print auction details
        ResultSet rs2=null;
        Statement statement2=null;
        statement2=con.createStatement();
        rs2=statement2.executeQuery("SELECT * FROM AUCTIONS WHERE AuctionId=" + request.getParameter("id"));
        rs2.next();
        rs=statement.executeQuery("SELECT * FROM ITEMS WHERE ItemId=" + rs2.getString("ItemId"));
        rs.next();
        out.println("<h1>" + rs.getString("ITEM_NAME") + "</h1>");
        
        Calendar NowDate = Calendar.getInstance();
        Calendar AuctionDate = Calendar.getInstance();
        DataBaseAccessor dba = new DataBaseAccessor();
        //AuctionDate.setTime(rs.getString("END_TIME"));
        //SimpleDateFormat sdf = new SimpleDateFormat("dd-MONTH-yyyy HH.mm.ss");

        //AuctionDate.getTime()-NowDate.getTime();           
      %>
        <table border='0' width='100%'>
            <tr>
                <td><% out.println("<img src='" + rs.getString("URL") + "'>"); %></td>
                
          <td class="page"> 
            <% 
                    //ResultSet rs3=null;
                    ResultSet rs4=null;
                    ResultSet rs5=null;
                    Statement statement4=null;
                    statement4=con.createStatement();
                    rs4=statement4.executeQuery("SELECT MIN_BID FROM AUCTIONS WHERE AuctionId=" + (request.getParameter("id")).trim());
                    rs5=dba.getRemainingAuctionTime(Integer.parseInt((request.getParameter("id")).trim()));
                    // For debug only: out.println("SELECT * FROM BIDS_ON WHERE AuctionId=" + request.getParameter("id") + " AND Time=(SELECT MAX(Time) FROM BIDS_ON WHERE AuctionId=" + request.getParameter("id") + ")");
                    out.println("<p><b>Description:</b> " + rs.getString("Description") + "</p>");
                    
                    rs5.next();
                    if (rs5.getInt("Sec") <= 0 && rs5.getInt("Hr") <= 0 && rs5.getInt("Mi") <= 0 && rs5.getInt("Dy") <= 0)
                    {   
                        rs4.next();
                        out.println("<p><b>Winning bid:</b> $" + (rs4.getString("MIN_BID")).trim() + "</p>");
                        out.println("<p><b>Auction Ended.</b>");
                    }
                    else 
                    {
                        if(!rs4.next())
                            out.println("<p><b>Current bid:</b> $0.00</p>");
                        else
                        {
                            out.println("<p><b>Current bid:</b> $" + (rs4.getString("MIN_BID")).trim() + "</p>");
                        }
                        out.println("<p><b>Time remaining:</b>" + rs5.getInt("Dy") + " Days, " + rs5.getInt("Hr") + " Hours, " + rs5.getInt("Mi") + " Minutes, " + rs5.getInt("Sec") + " Seconds.</text=\"RED\"</p>"); %>
                        <form action="auction_target.jsp" method="post" name="auction" id="auction">
                          <input id="userid" name="userid" type="hidden" value="<% out.println(UserIdCookie.getValue()); %>">
                          <input id="auctionid" name="auctionid" type="hidden" value="<% out.println(request.getParameter("id")); %>">
                          <p><b>Place bid:</b> 
                            <input name="amount" type="text" id="amount" size="10">
                            <input name="Bid" type="submit" id="Bid" value="Bid">
                          </p>
                          <%if((rs2.getString("BUY_NOW_PRICE")).trim() != "") 
                          { %>
                          <p> You can buy this item now for only $<% out.println(rs2.getString("BUY_NOW_PRICE").trim()); %>.</p>
                            <input name="BuyNow" type="submit" id="BuyNow" value="Buy Now">
                                <input name="BuyNowPrice" type="hidden" id="BuyNowPrice" value="<% out.println(rs2.getString("BUY_NOW_PRICE").trim()); %>">
                           <% } %>
                            </form>
                <%}   %>
            </td>
            </tr>
        </table>
                    
      <!-- STOP YOUR CODING HERE -->
      </td></tr>
  </table>
  </body>
</html>
<%
    rs4.close();
    rs4=null;
    rs2.close();
    rs2=null;
    rs5.close();
    rs5=null;
%>
<%@ include file="cleanup.jsp" %>