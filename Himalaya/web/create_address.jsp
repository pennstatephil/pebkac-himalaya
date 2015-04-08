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
	  <h1>Add New Address</h1>
	  <p>You can use addresses for billing and shipping purposes when making purchases 
        on Himalaya.com. Here you can add a new address to your account.</p>
      <form name="sdd_address" method="post" action="create_address_target.jsp">
        <p>Street: 
          <input name="street" type="text" id="street" size="30">
        </p>
        <p>City: 
          <input name="city" type="text" id="city" size="30">
        </p>
        <p>State: 
          <input name="USA_state" type="text" id="street3" size="4" maxlength="2">
        </p>
        <p>Zip: 
          <input name="zip" type="text" id="street4" size="10" maxlength="5">
          <input name="userid" type="hidden" id="userid" value="<% out.println(UserIdCookie.getValue().trim()); %>">
        </p>
        <p>
          <input type="submit" name="Submit" value="Add Address">
        </p>
        </form>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>