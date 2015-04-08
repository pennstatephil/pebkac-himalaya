<%@ include file="session.jsp" %>

<html>
  <head>
    <title>Himalaya.com [Home]</title>
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
      <h1>Welcome to Himalaya.com</h1>
      <p><form name="search_form" method="get" action="search.jsp">
	  Search for: <input type="text" name="search_string">
          <input type="submit" name="Submit" value="Go">
      </form></p>
      <h2>New to Himalaya.com?</h2>
      <p>If you would like to start shopping with us, <a href="create_user.jsp">create 
        a personalized account today</a>! </p>
      <h2>Featured Items</h2>
      <table width="100%" border="0">
      <%
        //Display recently added items
        int count=0;
        rs=statement.executeQuery("SELECT * FROM (select * from HIMALAYA.ITEMS ORDER BY ITEMID DESC ) WHERE ROWNUM <= 6");
        //rs=statement.executeQuery("SELECT ITEMID, ITEM_NAME, DESCRIPTION, URL FROM ITEMS WHERE ROWNUM <=6 ORDER BY ITEMID DESC");
        while(rs.next())
        {
           if(count%3==0) out.println("<tr>");
           out.println("<td class='page'><a href='item.jsp?id=" + rs.getString("ITEMID") +"'><img width='100' border='0' src='" + rs.getString("URL") + "'><p>" + rs.getString("ITEM_NAME") + "</p></a></td>");
           count++;
           if(count%3==0) out.println("</tr>");
        }     
      %>
      </table>
      <!-- STOP YOUR CODING HERE -->
      </td></tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>
