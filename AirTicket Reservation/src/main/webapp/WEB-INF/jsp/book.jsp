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
<title>Available Flights</title>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
	<style type="text/css">
		#display{
		text-align:center;
			font-weight: bold;
			font-size: 2em;
			color:red;
		}
	</style>
</head>
<body>
<h1 style="text-align:center;">Book Now!</h1><br>
<div class="container">
<h4 id="hide"><a href="/${home}" onclick="myfunc()">BACK</a></h4>
<div id="display"></div>
<form method="post" id="myform">
<table class="table table-striped">
	<thead>
				<tr>
					<th>Flight ID</th>
					<th>Flight Number</th>
					<th>From</th>
					<th>To</th>
					<th>Date</th>
					<th>Time</th>
					<th>Fare</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
	<c:forEach items="${match}" var="element">  
  		<tr> 
    		<td>${element.flight_id}</td> 
   			<td>${element.flight_number}</td>  
   			<td>${element.from_place}</td> 
   			<td>${element.to_place}</td> 
   			<td>${element.departure_date}</td> 
   			<td>${element.time}</td> 
   			<td>${element.fare}</td>
   			<td><a type="button" class="btn btn-success" href="/userLoginagain?flight_id=${element.flight_id}" id="container">Book</a></td> 
 		</tr> 
</c:forEach> 
</tbody>
<tfoot><tr><td>*Available flights</td></tr></tfoot>
</table>
</form>
</div>
<script>
	window.onload=function(){
		if(${size}==0){
			document.getElementById("myform").style.display="none";
			document.getElementById("display").innerHTML="No Flights Available";
		}
	}
</script>
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