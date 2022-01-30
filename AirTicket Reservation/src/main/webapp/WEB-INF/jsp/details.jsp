<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>Flight Details</title>
<style type="text/css">
	.myform{
		margin:0 auto;
		width:50%;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}h6{
	padding-left:25%;}
	td{
		width:50%; 
	}
	table{
		width:100%;
	}#footer{
		height:50px;
	}
</style>
</head>
<body>
	<h1>Ticket Booked!</h1>
	<br>
	<div class="myform">
	<table class="table table-striped">
		<thead>
			<tr>
				<th>Field Name</th>
				<th>Details</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>Flight ID</td>
				<td>${flightDetails.flight_id }</td>
			</tr>
			<tr>
				<td>Flight Number</td>
				<td>${flightDetails.flight_number }</td>
			</tr>
			<tr>
				<td>Airlines</td>
				<td>${flightDetails.airlines }</td>
			</tr>
			<tr>
				<td>From</td>
				<td>${flightDetails.from_place }</td>
			</tr>
			<tr>
				<td>To</td>
				<td>${flightDetails.to_place }</td>
			</tr>
			<tr>
				<td>Date</td>
				<td>${flightDetails.departure_date }</td>
			</tr>
			<tr>
				<td>Time</td>
				<td>${flightDetails.time }</td>
			</tr>
			<tr>
				<td>Distance</td>
				<td>${flightDetails.distance}</td>
			</tr>
			<tr>
				<td>Booking Id</td>
				<td>${flightDetails.booking_id }</td>
			</tr>
			<tr>
				<td>Duration</td>
				<td>${flightDetails.duration} hrs</td>
			</tr>
			<tr>
				<td>Fare</td>
				<td>${flightDetails.fare }</td>
			</tr>
			<tr>
				<td>Name of Booking</td>
				<td>${flightDetails.name_of_booking }</td>
			</tr>
			<tr>
				<td>Adult(s)</td>
				<td>${flightDetails.adults}</td>
			</tr>
			<tr>
				<td>Infant(s)</td>
				<td>${flightDetails.infants }</td>
			</tr>
			<tr>
				<td>Kid(s)</td>
				<td>${flightDetails.kids }</td>
			</tr>
			<tr>
				<td>Price After Tax</td>
				<td>${flightDetails.priceTax }</td>
			</tr>
		</tbody>
	</table>
	</div>
	<h6><strong>*For queries contact us</strong></h6>
	<div style="text-align: right; padding:10px;">
		<a class="btn btn-success" href="/homeagain?username=${flightDetails.name_of_booking}">BOOK ANOTHER TICKET</a> <a
			class="btn btn-success" href="/logout">LOGOUT</a>
	</div>
	<div id="footer"></div>
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