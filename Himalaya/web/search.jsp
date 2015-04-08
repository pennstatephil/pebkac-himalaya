<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.sql.*"%>
<%!
DataBaseAccessor dba =  new DataBaseAccessor();
PreparedStatement doSearch = null;
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
      <h1>Search Results for '<% out.println((request.getParameter("search_string")).trim());%>'</h1>
      <p><form name="search_form" method="get" action="search.jsp">
	  New search: <input type="text" name="search_string">
          <input type="submit" name="Submit" value="Go">
      </form></p>
      <table width="100%" border="0">
      <%
        String s = "SELECT ITEMID, ITEM_NAME, URL FROM ITEMS WHERE UPPER(DESCRIPTION) LIKE UPPER( ? ) OR UPPER(ITEM_NAME) LIKE UPPER( ? )";
        doSearch = con.prepareStatement(s);
        doSearch.setString(1, "%"+(request.getParameter("search_string")).trim()+"%");
        doSearch.setString(2, "%"+(request.getParameter("search_string")).trim()+"%");
        rs = doSearch.executeQuery();
       //rs = statement.executeQuery("SELECT ItemId, Item_Name, URL FROM Items WHERE Upper(Description) LIKE Upper('%" + request.getParameter("search_string") +"%') OR Upper(Item_Name) LIKE Upper('%" + request.getParameter("search_string") +"%')");
        int first=1;
        int count=0;

        while(rs.next())
        {
           first=0;
           if(count%3==0) out.println("<tr>");
           out.println("<td class='page'><a href='item.jsp?id=" + rs.getString("ITEMID") +"'><img width='100' border='0' src='" + rs.getString("URL") + "'><p>" + rs.getString("ITEM_NAME") + "</p></a></td>");
           count++;
           if(count%3==0) out.println("</tr>");
        }  
        if(first==1) out.println("No matches found.");
      %>
  </table>
      <!-- STOP YOUR CODING HERE -->
      </td></tr>
  </table>
  </body>
</html>
<%
rs.close();
rs=null;
%>
<%@ include file="cleanup.jsp" %>