<%
// Perform user authentication (check cookies)
Cookie cookies[] = request.getCookies();
Cookie UserIdCookie = null;
Cookie UserPasswordCookie = null;
//Cookie LoggedInCookie = null;
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
    
    /*for (int i = 0; i < cookies.length; i++) 
    {
        if (cookies [i].getName().equals("loggedin"))
        {
            UserPasswordCookie = cookies[i];
            break;
        }
    }*/
}

// If the username cookie cannot be found, then redirect the user to the login page
if(UserIdCookie==null || UserIdCookie.getValue().trim().equals(""))
{
      Cookie cookie = new Cookie ("loggedin","0");
      cookie.setMaxAge(60*60*24*7);
      response.addCookie(cookie);
    response.sendRedirect("login.jsp");
}
// If we have a username cookie, we still need to validate that the password is valid
// Otherwise we again need to redirect the user to the login page
else
{
    rs=statement.executeQuery("SELECT Password, userid,user_name,email,dob,gender FROM Users WHERE UserId = '" + UserIdCookie.getValue() + "'");
    rs.next();

    if (!(rs.getString("Password").trim().equals(UserPasswordCookie.getValue().trim())) )
    {
        response.sendRedirect("login.jsp");
    }
    /*else
    {
      Cookie cookie = new Cookie ("loggedin","1");
      cookie.setMaxAge(60*60*24*7);
      response.addCookie(cookie);
    }*/
}

// Only if the user has successfully been logged in should we continue
//if (LoggedInCookie.getValue().equals("1"))
%>