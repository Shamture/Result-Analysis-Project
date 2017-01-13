<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   <%@ page import="java.sql.*" %>
   <%@ page import="dbpackage.*" %>
  <%@ page import="java.io.*" %>
   <%@ page import="java.util.*" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Semwise result</title>
</head>
<body bgcolor="#E8E8E8">
<table align="center" border="1">
<tr><th>SubCode</th><th>SubName</th><th>InternalMarks</th><th>ExternalMarks</th><th>TotalMarks</th><th>Credits</th></tr>
<%

try
{
String rno=request.getParameter("rno");	
String sem=request.getParameter("sem");
String year=request.getParameter("year");
String table="";
if(sem.equals("1"))
{table+="1";
}
if(sem.equals("2-1"))
{table+="21";
}
if(sem.equals("2-2"))
{table+="22";
}
if(sem.equals("3-1"))
{table+="31";
}
if(sem.equals("3-2"))
{table+="32";
}
if(sem.equals("4-1"))
{table+="41";
}
if(sem.equals("4-2"))
{table+="42";
}
table+=year;
Database db= new Database();
ResultSet rs= db.executeDBQuery("select SubCode,SubjectName,InternalMarks,ExternalMarks,TotalMarks,Credits from "+table+" where  Hallticket='"+rno+"'");	
while(rs.next())
{
%>
    <tr>
         	<td align="center"><%=rs.getString(1)%></td>
    		<td align="center"><%=rs.getString(2)%></td>
   			<td align="center"><%=rs.getString(3)%></td>
   			<td align="center"><%=rs.getString(4)%></td>
   			<td align="center"><%=rs.getString(5)%></td>
   			<td align="center"><%=rs.getString(6)%></td>
 	</tr>
 	  
<%  	
}
%>
</table>
<center><a href="../semwiseresult.html" target="f3"></a></center>
<%
rs=db.executeDBQuery("select TotalMarks from "+table+" where Hallticket='"+rno+"'");
double tmarks=0.0;
int m=0;
double percentage;
String totalmarks;
double tmarks1;
while(rs.next())
{
totalmarks=rs.getString(1);
m+=Integer.parseInt(totalmarks);
tmarks+=Integer.parseInt(totalmarks);
}
out.println("TOTAL MARKS :"+m);
%>
<br><br/>
<%
if(sem.equals("1"))
{	
percentage=(tmarks/1100)*100;
out.println("PERCENTAGE :"+percentage);
}
else
{
percentage=(tmarks/750)*100;
out.println("PERCENTAGE :"+percentage);
%>
<br><br/>
<%
}
rs=db.executeDBQuery("select Credits from "+table+" where Hallticket='"+rno+"'");
int credits;
String crd;
while(rs.next())
{
	crd=rs.getString(1);
	credits=Integer.parseInt(crd);
	if(credits==0)
	{
		out.println("STATUS :Failed");
    %>
    <br><br/>
    <%
	break;
	}
	else
	{
	out.println(" STATUS :Pass");
	%>
	<br><br/>
	<%
	break;
	}
}
rs=db.executeDBQuery("select SubCode from "+table+" where Hallticket='"+rno+"'");
int scount=0;
while(rs.next())
{scount++;}
out.println("NO OF SUB APPEARED :"+scount);
%>
<br><br/>
<%
db.closeResultSet();
}
catch(Exception e)
{	
	out.println("Unable to execute query.Please Retry "+e);
}
%>
<center><a href="../semwiseresult.html" target="f3"><b>Back</b></a></center>
</body>
</html>