<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Change Details</title>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
	<style type="text/css">
.myform{
		padding-top:20px;
		padding-bottom:20px;
		margin:0 auto;
		text-align:center;
		width:50%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}td{
		width:250px;
		padding:10px;
	}table{
		width:100%;
	}input,select{
		border-radius: 4px;
		padding: 5.5px 4px;
		border-color:#D0D0D0;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}#footer{
		height:50px;
	}</style>
<title>Insert title here</title>
</head>
<body>
<form id="form1" action="/mybooking?username=${username}" method="post">
<h4><a  href="javascript:;" onclick="document.getElementById('form1').submit();">BACK</a></h4>
</form>
<h1 style="text-align:center;padding:60px;">Edit Flight Details Form</h1>
<form action="/changeDetails?booking_id=${booking_id}" method="post">
	<div class="myform">
	<table>
		<tr>
			<td>Class Details</td>
			<td><select name="bookingClass" id="bookingClass" required="required">
				<option value="Economy">Economy</option>
				<option value="Business">Business</option>
				</select></td>
		</tr>
		<tr>
			<td>Adults</td>
			<td><input type="number" name="adults" value="1" min="1"></td>
		</tr>
		<tr>
			<td>Infants</td>
			<td><input type="number" name="infants" value="0" min="0"></td>
		</tr>
		<tr>
			<td>Kids</td>
			<td><input type="number" name="kids" value="0" min="0"></td>
		</tr>
	</table>
<h6><strong>Note:Only booking class and no.of passengers can be edited. For further editing, cancel and re-book the ticket.</strong></h6>
		<div style="text-align: center;padding-top:20px;">
	<input class="btn btn-success" type="submit" value="Done"></div>
	</div><br>
</form>
<script type="text/javascript">
window.onload=function(){
	if(${check}){
		document.body.style.display="none";
		alert("Invalid Access");
		window.location.href="/logout";
	}
}</script>
<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
		<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
 <script type="text/javascript"> 
        window.history.forward(); 
        function noBack() { 
            window.history.forward(); 
        } 
    </script> 
</body>
</html>