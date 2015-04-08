<%@ include file="session.jsp" %>

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
      </td><td width="550" class="page">
      <!-- START YOUR CODING HERE -->
      <h1>Create an Account With Us</h1>
      <p>Thank you for your interest in joining Himalaya.com. You are just moments 
        away from creating your own personalized account and browsing our online 
        store. </p>
	  
      <form name="sdd_item" method="post" action="create_user_target.jsp">
        <p>Username: 
          <input name="userid" type="text" id="userid" size="30">
        </p>
        <p>Password: 
          <input name="password" type="password" id="password" size="30">
        </p>
        <p>Name: 
          <input name="user_name" type="text" id="userid3" size="30">
        </p>
        <p>Email: 
          <input name="email" type="text" id="userid4" size="30">
        </p>
        <p>Date of Birth: 
          <input name="dob" type="text" id="userid5" size="30">
          (i.e. MM-DD-YYYY ) </p>
        <p>Gender: 
          <input type="radio" name="gender" value="M">
          Male 
          <input type="radio" name="gender" value="F">
          Female</p>
        <p>Phone: 
          <input name="phone" type="text" id="userid6" size="30">
          (i.e. xxx-xxx-xxxx ) 
        </p> 
        <p>Salary: $
          <input name="salary" type="text" id="userid7" size="30">
        </p> 
        <p>
          <input type="submit" name="Submit" value="Create Account">
        </p>		
        </form>
      <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>