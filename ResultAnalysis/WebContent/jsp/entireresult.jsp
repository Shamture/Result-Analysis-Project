<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ page import="java.sql.*" %>
 <%@ page import="dbpackage.*" %>
 <%@ page import="java.lang.*" %>
 <%@ page import="java.util.*" %>
 <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Total Semister's Result</title>
</head>
<body bgcolor="#E8E8E8">
<%
try
{
String rno=request.getParameter("rno");
out.println("Roll no: "+rno);
%>
<p></p>
<%
String x="20"+rno.substring(0,2);
try {
    int  yr= Integer.parseInt(x);
	} catch (NumberFormatException e) {
    out.println("string cannot be converted");
   }
String a1="1" + x;
try {
    int  yr= Integer.parseInt(x);
	yr++;
	x= Integer.toString(yr);
} catch (NumberFormatException e) {
    out.println("string cannot be converted");
   }
String a2="21" + x;
String a3="22" + x;
try {
    int  yr= Integer.parseInt(x);
	yr++;
	x= Integer.toString(yr);
} catch (NumberFormatException e) {
    out.println("string cannot be converted");
   }
String a4="31" + x;
String a5="32" + x;
try {
    int  yr= Integer.parseInt(x);
	yr++;
	x= Integer.toString(yr);
} catch (NumberFormatException e) {
    out.println("string cannot be converted");
   }
String a6="41" + x;
String a7="42" + x;

String table[]={a1,a2,a3,a4,a5,a6,a7};
Database db= new Database();
int i=-1;
while(i++<7)
{
ResultSet rs= db.executeDBQuery("select SubCode,SubjectName,InternalMarks,ExternalMarks,TotalMarks,Credits from "+table[i]+" where Hallticket='"+rno+"'");	
if(table[i].length()==5)
{
	String x2=table[i].substring(0,1);
	String y3=table[i].substring(1,5);
	out.println(x2+" year "+y3+" results");
}
else
{
	String x1=table[i].substring(0,1);
	String z=x1+"-"+table[i].substring(1,2);
	String y1=table[i].substring(2,6);
	out.println(z+" sem "+y1+" year results");
}
%>
<table align="center" border="1">
<tr><th>Sub Code</th><th>Sub Name</th><th>Internal Marks</th><th>External Marks</th><th>Total Marks</th><th>Credits</th></tr>
<%
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
<center><a href="../entireresult.html" target="f3"></a></center> 
<%

rs=db.executeDBQuery("select TotalMarks from "+table[i]+" where Hallticket='"+rno+"'");
double tmarks=0.0;
double percentage;
int m=0;
String totalmarks=new String();
while(rs.next())
{
totalmarks=rs.getString(1);
m+=Integer.parseInt(totalmarks);
tmarks+=Integer.parseInt(totalmarks);
}
%>
<br></br>
<%
out.println("TOTAL MARKS :"+m);
%>
<br></br>
<%
String sem1=table[i].substring(0,1);
if(sem1.equals("1"))
{	
percentage=(tmarks/1100)*100;
}
else
{
percentage=(tmarks/750)*100;
}
int ix = (int)(percentage*100.0);
double dbl= ((double)ix)/100.0;
out.println("PERCENTAGE :"+dbl);
%>
<br></br>
<%
rs=db.executeDBQuery("select Credits from "+table[i]+" where Hallticket='"+rno+"'");
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
		<br></br>
		<%
		break;
	}
	else
	{
		out.println(" STATUS :Pass");
	%>
	<br></br>
	<%
	break;}
}
rs=db.executeDBQuery("select SubCode from "+table[i]+" where Hallticket='"+rno+"'");
int scount=0;
while(rs.next())
{scount++;}
out.println("NO OF SUB APPEARED :"+scount);
%>
<br></br>
<hr size=2 width=120% align="center" noshade></hr>
<%
}

db.closeResultSet();
}
catch(Exception e)
{	
	out.println("");
}
%>
</body>
</html>