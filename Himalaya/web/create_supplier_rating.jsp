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
        //out.println("SELECT Supplier_Name FROM Suppliers WHERE SupplierId=" + request.getParameter("supplierid"));
            rs=statement.executeQuery("SELECT * FROM Suppliers WHERE SUPPLIERID=" + Integer.parseInt((request.getParameter("supplierid")).trim()));
            rs.next();
            out.println("<h1>Rate " + rs.getString("SUPPLIER_NAME").trim() + "</h1>");
        %>
      <form name="form1" method="post" action="create_supplier_rating_target.jsp">
        <p> 
          <input id="userid"  name="userid" type="hidden" value="<% out.println(UserIdCookie.getValue()); %>">
          <input id="supplierid"  name="supplierid" type="hidden" value="<% out.println((rs.getString("SUPPLIERID")).trim()); %>">
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
<%
rs.close();
rs=null;
%>
<%@ include file="cleanup.jsp" %>