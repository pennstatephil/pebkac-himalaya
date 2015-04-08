<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makeitemrating(String userid, String itemid, int rating, String comment)
{
    dba.addNewItemRating(userid, itemid, rating, comment);
}
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
            String userid = request.getParameter("userid");
            String item_id = request.getParameter("itemid");
            String rating = request.getParameter("select");
            String comment = request.getParameter("comments");
            if(comment.length()==0){comment="No Comments";}
            makeitemrating(userid.trim(), item_id.trim(), Integer.parseInt(rating.trim()), comment.trim());
            rs=statement.executeQuery("SELECT item_name FROM ITEMS WHERE ITEMID = '" + item_id.trim() + "'"); 
            rs.next();
            String item_name = rs.getString("ITEM_NAME");
            %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Rating Added!</h1>
      <p>Thanks for rating the <%out.print(item_name);%>.  
      Your comments are vital to our marketplace.</p>
    </td>
  </tr>
  </table>
  </body>
</html>
