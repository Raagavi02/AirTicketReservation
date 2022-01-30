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
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>Booking Details</title>
</head>
<body>
<h1 style="text-align:center;">Your Bookings</h1><br>
<div class="container">
<form id="form1" action="/loginAction?username=${login.username}" method="post">
<h4><a  href="javascript:;" onclick="document.getElementById('form1').submit();">BACK</a></h4>
</form><br>
<form method="post">
<table class="table table-striped">
	<thead>
				<tr>
					<th>F_No.</th>
					<th>Airlines</th>
					<th>From</th>
					<th>To</th>
					<th>Date</th>
					<th>Time</th>
					<th>distance</th>
					<th>B_ID</th>
					<th>Duration</th>
					<th>Fare</th>
					<th>Name</th>
					<th>Adult(s)</th>
					<th>Infant(s)</th>
					<th>Kid(s)</th>
					<th>Tax</th>
					<th></th>
				</tr>
			</thead>
			<tbody>
	<c:forEach items="${result}" var="element">  
  		<tr> 
   			<td>${element.flight_number}</td>  
   			<td>${element.airlines}</td>
   			<td>${element.from_place}</td> 
   			<td>${element.to_place}</td> 
   			<td>${element.departure_date}</td> 
   			<td>${element.time}</td> 
   			<td>${element.distance}</td> 
   			<td>${element.booking_id}</td>
   			<td>${element.duration}</td>
   			<td>${element.fare}</td>
   			<td>${element.name_of_booking}</td>
   			<td>${element.adults}</td>
   			<td>${element.infants}</td> 
   			<td>${element.kids}</td> 
   			<td>${element.priceTax}</td>  
   			<td><a type="button" class="btn btn-success" href="/edit?booking_id=${element.booking_id}" id="container">Edit</a></td> 
   			<td><a type="button" class="btn btn-warning" href="/cancel?booking_id=${element.booking_id}" id="container">Cancel</a></td> 
 		</tr> 
</c:forEach> 
</tbody>
</table>
</form>
<strong>*For queries contact us</strong>
</div>
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