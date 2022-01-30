<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>Contact us</title>
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
	}input,textarea{
		border-radius: 4px;
		padding: 5.5px 4px;
		border-color:#D0D0D0;
		box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0 rgba(0, 0, 0, 0.19);
	}#footer{
		height:50px;
	}
</style>
</head>
<body>
<form id="form1" action="/loginAction?username=${login.username}" method="post">
<h4><a  href="javascript:;" onclick="document.getElementById('form1').submit();">BACK</a></h4>
</form>
<h1 style="text-align:center;padding:30px;">Contact Us</h1>
<form action="/addcontact" method="post">
	<div class="myform">
	<table>
		<tr>
			<td>Full Name</td>
			<td><input type="text" name="user" required="required"></td>
		</tr>
		<tr>
			<td>Email</td>
			<td><input type="email" name="email" required="required"></td>
		</tr>
		<tr>
			<td>Phone</td>
			<td><input type="text" pattern="^[7-9]{1}[0-9]{9}" maxlength="10" required="required"></td>
		</tr>
		<tr>
			<td>Message</td>
			<td><textarea name="message" placeholder="Your Comment..." required="required"></textarea></td>
		</tr>
	</table>
<h6><strong>Note: We will reach out within 48hrs.</strong></h6>
		<div style="text-align: center;padding-top:20px;">
	<input class="btn btn-success" type="submit" value="Done"></div>
	</div><br>
</form>
<script src="webjars/jquery/1.9.1/jquery.min.js"></script>
		<script src="webjars/bootstrap/3.3.6/js/bootstrap.min.js"></script>
		<script>
		window.onbeforeunload = function(){
			 alert('Email sent successfully!');
			};
		</script>
		 <script type="text/javascript"> 
        window.history.forward(); 
        function noBack() { 
            window.history.forward(); 
        } 
    </script> 
</body>
</html>