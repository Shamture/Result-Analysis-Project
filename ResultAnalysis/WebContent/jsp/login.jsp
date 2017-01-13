<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.sql.*" %>
   <%@ page import="dbpackage.*" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>login</title>
</head>
<body>
<%
 String userid=request.getParameter("loginid");
 String password=request.getParameter("password");
 Database db= new Database();
 try
 {
 ResultSet rs= db.executeDBQuery("select password from login where LoginID='"+userid+"'");
 if(rs.next())
 {
	 if(password.equals(rs.getString(1)))
	 {
		 response.sendRedirect("../homealign.html");
	 }
	 else
	 {
		 out.println("<body bgcolor='#900000'><br><br><br><br><center><b>User name & password doesn't match. please Retry</b><br>");
		 out.println("<br><br><a href='../login.html'><b> Retry </b></a></center></body>");
	 }
 }
 else
 {
	 out.println("<body bgcolor='#900000'><br><br><br><br><center> <b>user id not valid, please retry.</b><br>");
	 out.println("<br><br><a href='../login.html'><b> Retry </b></a></center></body>");
 }
 db.closeResultSet();
 }
 catch(Exception e)
 {
	out.println("Unable to execute query .Please Retry."+e);
 }
 %>
</body>
</html>