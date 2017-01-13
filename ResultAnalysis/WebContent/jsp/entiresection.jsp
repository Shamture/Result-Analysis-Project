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
<title>Entire Section Result</title>
</head>
<body bgcolor="#E8E8E8">
<table align="center" border="1">
<tr><th>Courses</th><th>Appeared</th><th>Passed</th><th>Per above 60%</th><th>Pass %</th></tr>
<%
try
{
String branch=request.getParameter("branch");
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
		/* code for students appeared */
int k1,nr=0;
ResultSet rs=null;
String[] app=new String[9];
String[] pass=new String[9];
String[] kp=new String[9];
String bno=new String();
String js=new String();

if(branch.equals("CSE"))
		{
	bno="05";
		}
if(branch.equals("ECE"))
		{
	bno="04";
		}
if(branch.equals("IT"))
		{
	bno="12";
		}
if(branch.equals("EEE"))
		{
	bno="02";
		}
if(branch.equals("Civil"))
		{
	bno="01";
		}
if(branch.equals("Mech"))
		{
	bno="03";
		}
if(branch.equals("EIE"))
	{
	bno="10";
	}
double[] pp= new double[9];
k1=0;
	rs= db.executeDBQuery("select distinct SubjectName,SubCode from "+table+" order by SubCode");
	while(rs.next())
	{nr++;}
	
	
	rs= db.executeDBQuery("select count(Hallticket) from "+table+" group by SubCode");
		while(rs.next())
		{
		app[k1++]=rs.getString(1);
		}
		/* code for students passed*/
		rs= db.executeDBQuery("select count(Hallticket) from "+table+" where (Credits > 0) group by SubCode");
		int k2=0;
		while(rs.next())
		{
		pass[k2++]=rs.getString(1);
		}
				/* code for students got more than 60 */
		rs= db.executeDBQuery("select count(Hallticket) from "+table+" where (TotalMarks > 60) group by SubCode");
		int k3=0;
		while(rs.next())
		{
		kp[k3++]=rs.getString(1);
		}
		double passq,appq;
		for(int i=0;i<nr;i++)
		{	
			passq=Double.parseDouble(pass[i]);
			appq=Double.parseDouble(app[i]);
				pp[i]=(passq/appq)*100;
		}
		rs= db.executeDBQuery("select distinct SubjectName,SubCode,Hallticket from "+table+" order by SubCode");
k1=-1;		
while(rs.next())
{
			js=rs.getString(3);
			js=js.substring(6,8);
			if(bno.equals(js))
					{
%>
    <tr>
         	<td align="center"><%=rs.getString(1)%></td>
         	<td align="center"><%=app[++k1]%></td>
         	<td align="center"><%=pass[k1]%></td>
         	<td align="center"><%=kp[k1]%></td>
         	<td align="center"><%=pp[k1]%></td>  	
   </tr>     	
<%
					}
}
}
catch(Exception e)
{	
	out.println("Unable to execute query.Please Retry "+e);
}
%>
</table>
<center><a href="../entiresection.html" target="f3"><b>Back</b></a></center>
</body>
</html>