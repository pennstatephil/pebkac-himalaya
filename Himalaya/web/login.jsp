<%@ include file="session.jsp" %>

<html>
  <head>
    <title>Himalaya.com [Login]</title>
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
        // Initialize error code to empty string, then assign it a value if a querystring exists
      String error_code = "";
      if (request.getParameter("error") != null && request.getParameter("error") != "") error_code = request.getParameter("error").trim();

      // Validate login credentials if we received a POST
      if (request.getParameter("userid") != null && request.getParameter("password") != null && request.getParameter("userid") != "" && request.getParameter("password") != "")
      {
          //out.println("We Got Here!<br>"); // For debug only
          
          String UserID = request.getParameter("userid").trim();
          String Password = request.getParameter("password").trim();
          
          rs=statement.executeQuery("SELECT UserId, Password FROM Users WHERE UserId = '" + UserID + "'");
          if(rs.next()) // If we returned a result for the userid, then process
          {
              String DB_UserID = rs.getString("UserID").trim();
              String DB_Password = rs.getString("Password").trim();
              
              //out.println(rs.getString("Password") + " | " + request.getParameter("password")); // For debug only
              if (Password.equals(DB_Password)) // Login was successful, set cookies
              {
                  Cookie cookie = new Cookie ("userid",rs.getString("UserId"));
                  cookie.setMaxAge(60*60*24*7);
                  response.addCookie(cookie);
                  Cookie cookie2 = new Cookie ("password",rs.getString("Password"));
                  cookie2.setMaxAge(60*60*24*7);
                  response.addCookie(cookie2);
                  
                  // Redirect to MyAccount page
                  response.sendRedirect("myaccount.jsp");
              }
              else // Log in was unsuccessful, return error
              {
                  response.sendRedirect("login.jsp?error=2"); // Incorrect password (error 2)
              }
          }
          else // Log in was unsuccessful, return error
          {
              response.sendRedirect("login.jsp?error=1"); // Username not found (error 1)
          }
      }
      else if (request.getParameter("userid") == "" || request.getParameter("password") == "")
      {
         response.sendRedirect("login.jsp?error=3"); // Username or password not provided (error 3) 
      }
      %>

      <h1>Login to Himalaya.com</h1>
      <%
        // Print error condition
        if (error_code.equals("1")) out.println("<p class='error'>User name not found.</p>");
        if (error_code.equals("2")) out.println("<p class='error'>Invalid password.</p>");
        if (error_code.equals("3")) out.println("<p class='error'>You must provide both a userid and password.</p>");
      %>
      <p>You must log in to continue.</p>
      <form name="login_form" method="post" action="login.jsp">
        <p>User ID: 
          <input name="userid" type="text" id="userid">
        </p>
        <p>Password: 
          <input name="password" type="password" id="password">
        </p>
        <p>
          <input type="submit" name="Submit" value="Login">
        </p>
      </form>
      <p>[ <a href="#">forgot password?</a> ] [ <a href="create_user.jsp">create a new account</a>]</p>
        <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>
