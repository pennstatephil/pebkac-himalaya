<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
void makeitem(String itemName, String desc, String imageURL, String itemURL, String category)
{
    dba.addNewItem(itemName, desc, imageURL, itemURL, category);
}

String validateinfo(String itemName, String itemDesc, String imageURL)
{
     String returnme="";
    if(!(itemName.length()<=60
       && itemName.length()!=0
       && itemDesc.length()<=30
       && itemDesc.length()!=0
       && imageURL.length()<=7
       && imageURL.length()!=0))
       {
            returnme+="<h3>Item name must be at most 60 characters, "+
            "Description must be at most 255 characters, "+
            "URL must be at most 255 characters.<br>"+
            "All fields are required.</h3>";
        }
        if(returnme.length()!=0)
         {
            returnme="<h1>Invalid data!</h1><br>"+returnme;
             returnme+="<h3>Go back and try again!</h3>";
         }
    return returnme;
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
            //String Start_Time = request.getParameter("start_time");
            //String End_Time = request.getParameter("end_time");
            String itemName = request.getParameter("item_name");
            String itemDesc = request.getParameter("description");
            String imageURL = request.getParameter("url");
            String category = request.getParameter("category_name");
            // FOr debug, print SQL for INSERT statement
            //out.println("INSERT INTO AUCTIONS (AuctionID, Start_Time, End_Time, Buy_Now_Price, Reserve_Price, ItemId, UserId) VALUES (auction_seq.nextval, SYSDATE, SYSDATE+7," + Buy_Now_Price + "," + Reserve_Price + "," + ItemId + ",'" + UserId.trim() + "')");
            //statement.executeQuery("INSERT INTO AUCTIONS (AuctionID, Start_Time, End_Time, Buy_Now_Price, Reserve_Price, ItemId, UserId) VALUES (auction_seq.nextval, SYSDATE, SYSDATE+7," + Buy_Now_Price + "," + Reserve_Price + "," + ItemId + ",'" + UserId.trim() + "')");
           
            String errors=validateinfo(itemName.trim(), itemDesc.trim(), imageURL.trim());
            if(errors.length()!=0)
            {
                out.print(errors);
            }
            else
            {
                makeitem(itemName.trim(), itemDesc.trim(), imageURL.trim(), "ITEM URL", category.trim());            
       %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Item Created!</h1>
      <p>Thank you for adding your <% out.println(itemName); %> to the database.</p>
    </td>
  </tr>
  </table>
  </body>
</html>
<% } %>
<%@ include file="cleanup.jsp" %>
