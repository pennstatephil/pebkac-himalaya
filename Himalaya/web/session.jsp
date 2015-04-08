<%@page contentType="text/html" import="java.sql.*,java.io.*"%>
<%@page pageEncoding="UTF-8"%>

<!-- Begin Session Header Code -->
<%
   Connection con=null;
   Statement statement=null;
   ResultSet rs=null;
    
   try
   {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        con=DriverManager.getConnection("jdbc:oracle:thin:@himalaya.phporaclehosting.com/XE","himalaya","uc7smU8d56");
        statement=con.createStatement();
   }   
   catch(SQLException sqle)
   {    
    out.println("SQL Exception:"+sqle.getMessage());
    out.println("<a href=\"JSPDemo.jsp\">Back</a>\n");
   }
   catch(ClassNotFoundException cnfe)
   {    
    out.println("Class Exception:"+cnfe.getMessage());
    out.println("<a href=\"JSPDemo.jsp\">Back</a>\n");
   }
   catch(Exception e)
   {    
    out.println("General Exception:"+e.getMessage());
    out.println("<a href=\"JSPDemo.jsp\">Back</a>\n");
   }
%>
<!-- End Session Header Code -->