<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>

<html>
  <head>
    <title>Himalaya.com [Rate Item]</title>
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
            rs=statement.executeQuery("SELECT Item_Name, ItemId FROM Items WHERE ItemId=" + request.getParameter("itemid"));
            rs.next();
            out.println("<h1>Rate " + rs.getString("Item_Name").trim() + "</h1>");
        %>
      <form name="form1" method="post" action="create_item_rating_target.jsp">
        <p> 
          <input id="userid"  name="userid" type="hidden" value="<% out.println(UserIdCookie.getValue()); %>">
          <input id="itemid"  name="itemid" type="hidden" value="<% out.println(rs.getString("ItemId")); %>">
          Rating: 
          <select name="select">
            <option value="5">5</option>
            <option value="4">4</option>
            <option value="3">3</option>
            <option value="2">2</option>
            <option value="1">1</option>
          </select>
        </p>
        <p>Comments:<br>
          <textarea name="comments" cols="40" rows="5" id="comments"></textarea>
        </p>
        <p>
          <input type="submit" name="Submit" value="Add Rating">
        </p>
      </form> 
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>