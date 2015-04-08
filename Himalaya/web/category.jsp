<%@ include file="session.jsp" %>

<html>
  <head>
    <title>Himalaya.com [<% out.println(request.getParameter("name")); %>]</title>
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
        rs = statement.executeQuery("SELECT Parent_Category FROM Categories WHERE Category_Name='" + request.getParameter("name") + "' AND Parent_Category IS NOT NULL");
        if(rs.next())
        {
            out.println("<h1><a href='category.jsp?name=" + rs.getString("Parent_Category") + "'>" + rs.getString("Parent_Category").trim() + "</a> > " + request.getParameter("name") + "</h1>");
        }
        else
        {
            out.println("<h1>" + request.getParameter("name") + "</h1>");
        }
        // Print child categories
        int first=1; // Determines whether or not it is our first time through the recordset
        rs = statement.executeQuery("SELECT Category_Name FROM Categories WHERE Parent_Category='" + request.getParameter("name") + "'");    
        
        while(rs.next())
        {
            if (first!=1) out.println("&nbsp;|&nbsp;");
            first=0;
            out.println("<a href='category.jsp?name=" + rs.getString("Category_Name") + "'>" + rs.getString("Category_Name") + "</a>");
        }
        
        /*rs = statement.executeQuery("SELECT ItemId, Item_Name, Description FROM Items WHERE Category_Name = '" + request.getParameter("name") + "'");
        
        first=1;
        while(rs.next())
        {
            first=0;
            out.println("<a href='item.jsp?id=" + rs.getString("ItemId") + "'>" + rs.getString("Item_Name") + "</a><br>");
        }*/
      %>
      <hr>
      <table width="100%" border="0">
      <%
        //Display recently added items
        int count=0;
        rs=statement.executeQuery("SELECT ITEMID, ITEM_NAME, DESCRIPTION, URL FROM ITEMS WHERE Category_Name = '" + request.getParameter("name") + "'");
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
