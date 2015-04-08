<%@ include file="session.jsp" %>
<%@ include file="authenticate.jsp" %>

<html>
  <head>
    <title>Himalaya.com [Add a New Address]</title>
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
	  <h1>Add New Credit Card</h1>
	  <p>You can use credit cards for billing when making purchases on Himalaya.com. 
        Here you can add a new credit card to your account.</p>
      <form name="sdd_creditcard" method="post" action="create_creditcard_target.jsp">
        <p>Credit Card #: 
          <input name="CC_number" type="text" id="CC_number" size="40">
        </p>
        <p>Company: 
          <input name="company" type="text" id="company" size="30">
        </p>
        <p>Expiration Date: 
          <input name="expiration" type="text" id="expiration">
          (i.e. 06/09)</p>
        <p>CVV Number: 
          <input name="CVV" type="text" id="CVV" size="5" maxlength="3">
        </p>
        <p>Name on Card: 
          <input name="Name_on_Card" type="text" id="Name_on_Card" size="40">
        </p>
	  <input name="userid" type="hidden" id="userid" value="<% out.println(UserIdCookie.getValue().trim()); %>">
        <p>
          <input type="submit" name="Submit" value="Add Credit Card">
        </p>
        </form>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>