<%@ include file="session.jsp" %>
<%@page import="himalaya.*"%>
<%@page import="java.util.Date"%>

<%!
DataBaseAccessor dba =  new DataBaseAccessor();
PreparedStatement getItem = null;
void makeauction(double buynow, double reserve, int itemid, String userid, double min_bid)
{
    dba.addNewAuction(buynow, reserve, itemid, userid, min_bid);
}

void makeitem(String itemName, String description, String image, String URL, String categoryName)
{
    dba.addNewItem(itemName, description, image, URL, categoryName);
}

String validateinfo(double buynow, double reserve, double minbid)
{
    String returnme="";
    if(buynow<0 || reserve<0 || minbid<0)
       {
            returnme+="<h3>All numbers must be positive</h3>";
        }
        if(buynow!=0 && buynow < minbid)
        {
                returnme+="<h3>Buy it now price must be more than minimum bid.<br></h3>";
        }
        if(reserve!=0 && reserve < minbid)
         {
                returnme+="<h3>Reserve price must be more than minimum bid.<br></h3>";
         }
        if(buynow!=0 && reserve > buynow)
         {
                returnme+="<h3>Reserve price must be less than or equal to buy it now price.<br></h3>";
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
            String Item_Name;
            String Buy_Now_Price = request.getParameter("buy_now_price");
            //TODO: Check if buy_now or reserve is blank
            String Reserve_Price = request.getParameter("reserve_price");
            String UserId = request.getParameter("userid");
            String Min_Bid = request.getParameter("minbid");
            if (Min_Bid.trim() == "")
                Min_Bid = "0";
            if (Reserve_Price.trim() == "")
                Reserve_Price = "0";
            if (Buy_Now_Price.trim() == "")
                Buy_Now_Price = "0";
            
            Min_Bid=Min_Bid.replaceAll("\\p{Alpha}", ""); //take out non-digits
            Reserve_Price=Reserve_Price.replaceAll("\\p{Alpha}", ""); //take out non-digits
            Buy_Now_Price=Buy_Now_Price.replaceAll("\\p{Alpha}", ""); //take out non-digits
            
            String errors=validateinfo(Double.parseDouble(Buy_Now_Price.trim()), Double.parseDouble(Reserve_Price.trim()), Double.parseDouble(Min_Bid.trim()));
       if(errors.length()!=0)
        {
           out.print(errors);
        }
       else 
       {
            if (request.getParameter("type").equals("existing_auction"))
           {
                String ItemId = request.getParameter("itemid");
                Item_Name = request.getParameter("item_name");
                makeauction(Double.parseDouble(Buy_Now_Price.trim()), Double.parseDouble(Reserve_Price.trim()), Integer.parseInt(ItemId.trim()), UserId.trim(), Double.parseDouble(Min_Bid.trim()));            
           }
           else
           {
                getItem = con.prepareStatement("SELECT ITEMID FROM ITEMS WHERE ROWNUM = 1 ORDER BY ITEMID DESC");
                Item_Name = request.getParameter("item_name2");
                String itemDesc = request.getParameter("description");
                String imageURL = request.getParameter("url");
                String category = request.getParameter("category_name");
                makeitem(Item_Name.trim(), itemDesc.trim(), imageURL.trim(), "ITEM URL", category.trim());
                rs = getItem.executeQuery();
                rs.next();
                int itemID = rs.getInt("ITEMID");
                makeauction(Double.parseDouble(Buy_Now_Price.trim()), Double.parseDouble(Reserve_Price.trim()), itemID, UserId.trim(), Double.parseDouble(Min_Bid.trim()));
           }

      %>
      <!-- STOP YOUR CODING HERE -->
      <h1>Auction Created!</h1>
      <p>Thank you for adding your <% out.println(Item_Name); %> to the marketplace. You can check 
        the status of your auction on the <a href="myaccount.jsp">MyAccount</a> 
        page.</p></td>
  </tr>
  </table>
  </body>
</html>
<%
    rs.close();
    rs=null;
}
%>
<%@ include file="cleanup.jsp" %>