<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>

<html>
  <head>
    <title>Himalaya.com [Create an Auction]</title>
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
      <p>When auctioning an item on Himalaya.com, we recommend first checking 
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
      else if(request.getParameter("type").equals("existing")&& UserIdCookie != null)
      {
        rs=statement.executeQuery("SELECT Item_Name, Description, URL FROM Items WHERE ItemId=" + request.getParameter("itemid"));
        rs.next();
        out.println("<h1>Auction Your " + rs.getString("Item_Name") + "</h1>");
        out.println("<img width='150' src='" + rs.getString("URL") + "'>");
      %>
      <form name="create_existing" method="post" action="create_auction_target.jsp">
          <input id="type" name="type" type="hidden" value="existing_auction">
          <input id="userid" name="userid" type="hidden" value="<% out.println(UserIdCookie.getValue()); %>">
          <input id="itemid" name="itemid" type="hidden" value="<% out.println(request.getParameter("itemid")); %>">
          <input id="item_name" name="item_name" type="hidden" value="<% out.println(rs.getString("Item_Name")); %>">
          <!--<p>Start date/time: 
          <input name="start_time" type="text" id="start_timestamp">
          (i.e. 15-DECEMBER-1985 09.15.00 AM)</p>
        <p>End date/time: 
          <input name="end_time" type="text" id="end_timestamp">
        </p>-->
        <p>Starting Bid:
          <input name="minbid" type="text" id="minbid">
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
      else if(request.getParameter("type").equals("new")&& UserIdCookie != null)
      {
      %>
	  <h1>Auction Your Item</h1>
	  <form name="create_new_auction" method="post" action="create_auction_target.jsp">
          <input id="type" name="type" type="hidden" value="new_auction">
          <input id="userid" name="userid" type="hidden" value="<% out.println(UserIdCookie.getValue()); %>">
        <p>Item Name:<br>
          <input name="item_name2" type="text" id="item_name2" size="30">
        </p>
        <p>Provide a brief description of the item:<br>
          <textarea name="description" cols="60" rows="4" id="description"></textarea>
        </p>
        <p>Image URL: <br>
          <input name="url" type="text" id="url" size="70">
        </p>
        <p> Select a category for your new item:<br>
          <select name="category_name" id="category_name">
            <% // Populate the item box with all of the available categories
                rs=statement.executeQuery("SELECT CATEGORY_NAME, PARENT_CATEGORY FROM CATEGORIES ORDER BY CATEGORY_NAME, PARENT_CATEGORY");
                while(rs.next())
                {
                    out.println("<option value='" + rs.getString("CATEGORY_NAME") + "'>" + rs.getString("CATEGORY_NAME") + "</option>");
                }
              %>
          </select>
        </p>
        <p>Starting Bid:
          <input name="minbid" type="text" id="minbid">
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
      <% } %>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>