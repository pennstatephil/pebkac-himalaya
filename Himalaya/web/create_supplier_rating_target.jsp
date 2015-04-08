<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>
<%@page import="himalaya.*"%>
<%!
DataBaseAccessor dba =  new DataBaseAccessor();
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
            // Process new auction creation
            String userid = (request.getParameter("userid")).trim();
            int supplier_id = Integer.parseInt((request.getParameter("supplierid")).trim());
            int rating = Integer.parseInt((request.getParameter("select")).trim());
            String comment = (request.getParameter("comments")).trim();
            if(comment.length()==0){comment="No Comments";}
            dba.addNewSupplierRating(userid, supplier_id, rating, comment);
            %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Rating Added!</h1>
      <p>Thanks for your input!  
      Your comments are vital to our marketplace.</p>
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