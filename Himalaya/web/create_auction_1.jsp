<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makeauction()
{
    dba.addNewAuction();
}
%>

<html>
  <head>
    <title>3aya.com [Template Page]</title>
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
    
      <% if (request.getParameter("type")==null || request.getParameter("type").equals(""))
         { 
      %>
      <h1>Start an Auction</h1> 
      <p>When auctioning an item on Himalaya.com, we reccomend first checking 
        to see if the item you wish to auction already exists on Himalaya.com. 
        You can do this by searching for the item using the search field below. 
        If you find a matching result, you can open the item page and choose &quot;Auction 
        This Item&quot;. If you have already done this and have not found the 
        item you wish to sell, then <a href="create_auction.jsp?type=new">click 
        here</a> to get started auctioning your new item. </p>
      <form name="search_form" method="get" action="search.jsp">
        Search for the item you wish to auction: 
        <input type="text" name="search_string">
        <input type="submit" name="Submit" value="Go">
      </form>
      <% 
      }
      else if(request.getParameter("type").equals("existing"))
      {
        rs=statement.executeQuery("SELECT Item_Name, Description, URL FROM Items WHERE ItemId=" + request.getParameter("itemid"));
        rs.next();
        out.println("<h1>Auction Your " + rs.getString("Item_Name") + "</h1>");
        out.println("<img width='150' src='" + rs.getString("URL") + "'>");
      %>
      <form name="form1" method="post" action='create_auction.jsp'>
        <p>Start date/time: 
          <input name="start_timestamp" type="text" id="start_timestamp">
        </p>
        <p>End date/time: 
          <input name="end_timestamp" type="text" id="end_timestamp">
        </p>
        <p>Buy Now Price: 
          <input name="buy_now_price" type="text" id="buy_now_price">
        </p>
        <p>Reserve Price: 
          <input name="reserve_price" type="text" id="reserve_price">
        </p>
        <p>
          <input type="submit" name="Submit2" value="Create Auction">
        </p>
      </form> 
      <% 
      }
      else if(request.getParameter("type").equals("new"))
      {
      %>
      <% } %>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>