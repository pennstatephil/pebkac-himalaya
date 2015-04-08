<!-- Begin Cleanup Code -->
<%
  try
    {
        if(rs!=null)
        {   rs.close();
            rs=null;
        }   
        statement=null;
        if(con!=null)
        {   con.close();
            con=null;
        }    
     }  
    catch(SQLException sqle)
    {    
        out.println(sqle.getMessage());
    }
%>
<!-- End Cleanup Code -->