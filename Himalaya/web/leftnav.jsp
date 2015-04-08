<!-- Begin Navigation Code -->
<%
  rs = statement.executeQuery("SELECT Category_Name FROM Categories WHERE Parent_Category IS NULL ORDER BY Category_Name ASC ");
  while(rs.next())
  {
    out.println("<a href='category.jsp?name=" + rs.getString("Category_Name") + "'>" + rs.getString("Category_Name") + "</a><br>");
  }
%>
<!-- End Navigation Code -->