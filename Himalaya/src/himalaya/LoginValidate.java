/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package himalaya;

import java.io.*;
import java.net.*;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *
 * @author Administrator
 */
public class LoginValidate extends HttpServlet {
   
    /** 
    * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
    * @param request servlet request
    * @param response servlet response
    */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException {
        
        Connection con=null;
        PreparedStatement statement=null;
        
        String findPassStmt = "SELECT UserId, Password FROM Users WHERE UserId = '"+request.getParameter("userid")+"'";
        
        try {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@himalaya.phporaclehosting.com/XE","himalaya","uc7smU8d56");
        statement = con.prepareStatement(findPassStmt);
        
        
      if (request.getParameter("userid") != null && request.getParameter("password") != null && request.getParameter("userid") != "" && request.getParameter("password") != "")
      {
          
          ResultSet rs1= statement.executeQuery();
          
          
          if(rs1.next()) // If we returned a result for the userid, then process
          {
              
              String dbUserId = rs1.getString("Password").trim();
              String paramUserId = request.getParameter("password");
              
                  if (dbUserId.compareTo(paramUserId)==0)
                  {
                      Cookie cookie= new Cookie ("userid",rs1.getString("UserId"));
                      cookie.setMaxAge(60*60); //Time to expire in seconds;
                      response.addCookie(cookie);
                      Cookie cookie2 = new Cookie ("password",rs1.getString("Password"));
                      cookie2.setMaxAge(60*60); //Time to expire in seconds;
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
    } catch (Exception e)
    {
        
        
    }
    }
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
    * Handles the HTTP <code>GET</code> method.
    * @param request servlet request
    * @param response servlet response
    */

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException {
        processRequest(request, response);
    } 

    /** 
    * Handles the HTTP <code>POST</code> method.
    * @param request servlet request
    * @param response servlet response
    */   
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException 
    {
        processRequest(request, response);
    }

    /** 
    * Returns a short description of the servlet.
    */
    
    public String getServletInfo() {
        return "Short description";
    }
    
   
    // </editor-fold>
}

