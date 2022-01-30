<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>Book Ticket</title>
<style type="text/css">
.myform {
	padding-top: 20px;
	padding-bottom: 20px;
	margin: 0 auto;
	text-align: center;
	width: 80%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

td {
	width: 250px;
	text-align: left;
	padding: 10px;
}

table {
	width: 100%;
}

input, select {
	border-radius: 4px;
	padding: 5.5px 4px;
	border-color: #D0D0D0;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

#footer {
	height: 50px;
}
</style>

</head>
<body>
	<h1 style="text-align: center; padding: 30px; padding-top: 0">Search
		Flight</h1>
	<form action="/flight?username=${login.username}" method="post">
		<div class="myform">
			<table>
				<tr>
					<td>From</td>
					<td><select name="from_place" id="from_place"
						required="required">
							<c:forEach var="element" items="${Places}">
								<option value="${element}">${element}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>To</td>
					<td><select name="to_place" id="to_place" required="required">
							<c:forEach var="element" items="${Places}">
								<option value="${element}">${element}</option>
							</c:forEach>
					</select></td>
				</tr>
				<tr>
					<td>Departure(MM/DD/YYYY)</td>
					<td><div class="input-group date" data-provide="datepicker">
							<input type="text" name="departure_date" class="form-control"
								required="required">
							<div class="input-group-addon">
								<span class="glyphicon glyphicon-th"></span>
							</div>
						</div></td>
				</tr>
				<tr>
					<td><strong>Passengers</strong></td>
				</tr>
				<tr>
					<td>Adult(s)</td>
					<td><input name="adults" type="number" value="1"
						required="required"> Children <input name="kids"
						type="number" value="0" required="required"> Infant(s) <input
						name="infants" type="number" value="0" required="required">
					</td>
				</tr>
				<tr>
					<td>Class</td>
					<td><select name="bookingClass" id="bookingClass"
						required="required">
							<option value="Economy">Economy</option>
							<option value="Business">Business</option>
					</select></td>
				</tr>
			</table>
		</div>
		<br>
		<div style="text-align: center; padding-top: 20px;">
			<input class="btn btn-success" type="submit" value="Search">
		</div>
	</form>
	<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
	<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
	<script type="text/javascript">
		$('#departure_date').datepicker({
			format : 'mm/dd/yyyy'
		});
	</script>
	 <script type="text/javascript"> 
        window.history.forward(); 
        function noBack() { 
            window.history.forward(); 
        } 
    </script> 
</body>
</html>