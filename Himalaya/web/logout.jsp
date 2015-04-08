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
            // Find the user's "userid" and "password" cookies
            Cookie cookies[] = request.getCookies();
            Cookie UserIdCookie = null;
            Cookie UserPasswordCookie = null;
            if (cookies != null)
            {
                for (int i = 0; i < cookies.length; i++) 
                {
                    if (cookies [i].getName().equals("userid"))
                    {
                        UserIdCookie = cookies[i];
                        break;
                    }
                }

                for (int i = 0; i < cookies.length; i++) 
                {
                    if (cookies [i].getName().equals("password"))
                    {
                        UserPasswordCookie = cookies[i];
                        break;
                    }
                }
            }
            // Delete the cookies (user is logged out)
            Cookie killMyCookie = new Cookie("mycookie", null);
            killMyCookie.setMaxAge(0);
            killMyCookie.setPath("/");
            response.addCookie(killMyCookie);

            UserIdCookie.setMaxAge(0);
            UserPasswordCookie.setMaxAge(0);
            response.addCookie(UserIdCookie);
            response.addCookie(UserPasswordCookie);
            UserIdCookie = null;
            UserPasswordCookie = null;
        %>
      <h1>Thanks for visiting!</h1>
      <p>You have been logged out of Himalaya.com.</p>
        <!-- STOP YOUR CODING HERE -->
    </td>
  </tr>
  </table>
  </body>
</html>

<%@ include file="cleanup.jsp" %>
