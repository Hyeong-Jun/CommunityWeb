<%@ page language="java" contentType="text/html; charset=utf-8" %>
<%@ page import = "java.sql.*, java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<%
String num = request.getParameter("num");
String name = request.getParameter("plus_name");  
String contents = request.getParameter("plus_contents");
int num_plus = 1;

Class.forName("com.mysql.jdbc.Driver");

String url = "jdbc:mysql://localhost:3306/dbMember?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
Connection conn = DriverManager.getConnection(url,"Member","apple");

Statement stmt = conn.createStatement();

String strSQL = "SELECT num FROM tblplus ORDER BY num DESC";
ResultSet rs = stmt.executeQuery(strSQL);

while(rs.next()) {
	rs.getInt(1);

	if(rs.wasNull())  
		num_plus = 1;
	else {
    	strSQL = "SELECT Max(num) FROM tblplus";
    	rs = stmt.executeQuery(strSQL);
    	rs.next();
    	num_plus = rs.getInt(1) + 1;
	}
}

Calendar dateIn = Calendar.getInstance();
String indate = Integer.toString(dateIn.get(Calendar.YEAR)) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.MONTH)+1) + "-";
indate = indate + Integer.toString(dateIn.get(Calendar.DATE)) + " ";
indate = indate + Integer.toString(dateIn.get(Calendar.HOUR_OF_DAY)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.MINUTE)) + ":";
indate = indate + Integer.toString(dateIn.get(Calendar.SECOND));

strSQL ="INSERT INTO tblplus (num, id, name, contents, writedate)";
strSQL = strSQL +  "VALUES('" + num_plus + "', '" + num + "', '" + name + "',";
strSQL = strSQL +  "'" + contents + "', '" + indate + "')";
stmt.executeUpdate(strSQL);

stmt.close();
conn.close();

response.sendRedirect("write_output.jsp?num=" + num); 
%>
