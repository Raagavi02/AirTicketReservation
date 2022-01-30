<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Admin Login Page</title>
<link href="webjars/bootstrap/3.3.6/css/bootstrap.min.css"
	rel="stylesheet">
<title>Insert title here</title>
<style>
.sidepanel {
	width: 0;
	position: fixed;
	z-index: 1;
	height: 100%;
	top: 0;
	left: 0;
	background-color: #111;
	overflow-x: hidden;
	transition: 0.5s;
	padding-top: 60px;
}

.sidepanel a {
	padding: 8px 8px 8px 32px;
	text-decoration: none;
	font-size: 18px;
	color: #818181;
	display: block;
	transition: 0.3s;
}

.column {
	float: left;
	width: 50%;
	padding: 10px;
}

/* Clear floats after the columns */
.row:after {
	content: "";
	display: table;
	clear: both;
}

.sidepanel a:hover {
	color: #f1f1f1;
}

.sidepanel .closebtn {
	position: absolute;
	top: 0;
	right: 25px;
	font-size: 36px;
}

#open {
	padding: 20px;
}

.openbtn {
	font-size: 20px;
	cursor: pointer;
	background-color: #333;
	color: white;
	padding: 14px 16px;
	border: none;
	color: white;
}

.openbtn:hover {
	background-color: #ddd;
	color: black;
}

.popup, .popupagain {
	background: rgba(0, 0, 0, 0.6);
	width: 100%;
	height: 100%;
	position: absolute;
	top: 0;
	display: none;
	justify-content: center;
	align-items: center;
	text-align: center;
}

img {
	display: block;
	width: 80%;
}

.image {
	float: left;
	width: 50%;
	height: 450px;
}

.list {
	padding-top: 100px;
	float: right;
	width: 50%;
	height: 450px;
}

input {
	border-radius: 4px;
	padding: 5.5px 4px;
	border-color: #D0D0D0;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2), 0 6px 20px 0
		rgba(0, 0, 0, 0.19);
}

.topnav {
	overflow: hidden;
	background-color: #333;
	height: 52px;
}

.topnav a {
	float: left;
	color: #f2f2f2;
	text-align: center;
	padding: 14px 36px;
	text-decoration: none;
	font-size: 17px;
}

.topnav a:hover {
	background-color: #ddd;
	color: black;
}

.popup-container {
	height: 400px;
	width: 500px;
	position: relative;
	background-color: white;
}

.top {
	float: right;
}
</style>
</head>
<body>
	<div class="topnav">
		<a style="padding: 0;">
			<button class="openbtn" onclick="openNav()">&#9776; Account</button>
		</a>
		<div class="top">
			<a href="#news" onclick="myfunction0()">Home</a><a href="/logout">Logout</a>
		</div>
	</div>

	<div id="mySidepanel" class="sidepanel">
		<a href="javascript:void(0)" class="closebtn" onclick="closeNav()">
			X</a><br>
		<h1 style="margin: 0; color: #F0F0F0;">Hello!<br> <h4 style="color:#F0F0F0;">${username}</h4></h1>
		<br> <br> <a href="#" onclick="contain()">Change Password</a>
		<form id="form1" action="/availableFlights" method="post">
			<a href="javascript:;"
				onclick="document.getElementById('form1').submit();">Flight List</a>
		</form>
		<form id="form2" action="/addFlights" method="post">
			<a href="javascript:;"
				onclick="document.getElementById('form2').submit();">Add
				FlightDetails</a>
		</form>
		<a href="/logout">Logout</a>
	</div>
	<div class="popup">
		<div class="popup-container">
			<a style="float: right; padding: 20px;" onclick="hide()" href="#">X</a>
			<h2 style="padding-top: 60px; margin: 0; padding-bottom: 20px;">Change
				Password</h2>
			<br>
			<form action="/changePassword" method="post" onsubmit="return checks()">
				<div>Password</div>
				<input name="password" id="password1" type="password"
					required="required" /><br> <br>
				<div>Confirm Password</div>
				<input name="confirm" id="password2" type="password"
					required="required" /><br> <br> <br> <input
					type="submit" class="btn btn-success" value="Done"
					required="required">
			</form>
		</div>
	</div>
	<div id="news">
	<div><h3 style="color:red;">${message}</h3></div>
	<div><h3 style="color:green;">${message1}</h3></div>
		<h2 style="text-align: center;">Top 5 Places to Visit in the
			World</h2>
		<div class="container">
			<div>
				<div class="image">
					<h4>1. Machu Picchu, Peru</h4>
					<br> <img alt="Machu Picchu" src="/Images/machu.jpg">
				</div>
				<div class="list">
					<ul>
						<li><strong>Best Time to visit: October</strong></li>
						<li>Machu Picchu is one of the New Seven Wonders of the
							World.</li>
						<li>Structures at Machu Picchu were built with a technique
							called ashlar. Stones are cut to fit together without mortar.
							Remarkably, not even a piece of paper can fit in between two
							stones.</li>
						<li>At a dizzying 2,430 meters above sea-level, the view form
							Machu Picchu on a clear day is breath taking.</li>
						<li>The Inca Trail is just as well known as Machu Picchu and
							the trail each year fills up quickly. The trek takes you through
							ruins and beautiful landscapes and leads to the ultimate
							destination, Machu Picchu.</li>
						<li>It is also a testament to the structural integrity of the
							site that it still stands, through earthquakes, constant
							torrential rain and, now, heavy tourism.</li>
					</ul>
				</div>
			</div>
			<div>
				<div class="image">
					<h4>2. The Grand Canyon, Arizona</h4>
					<br> <img alt="The Grand Canyon" src="/Images/grand.jpg">
				</div>
				<div class="list">
					<ul>
						<li><strong>Best Time to visit: March-May</strong></li>
						<li>The Colorado River cuts through the canyon and stretches
							up to 277 miles, offering mesmerizing views to millions of
							tourists</li>
						<li>The Colorado offers rafting opportunities, giving you the
							chance to get a whole different perspective of the vast canyon as
							you raft down the river.</li>
						<li>The national park is home to about 447 species of birds,
							91 species of mammals, 48 species of reptiles, 10 species of
							amphibians and hundreds of other animals</li>
						<li>The Grand Canyon offers a magical escape from the hectic
							city life. The stunning sunrise and sunset, the enchanting
							silence, fresh air and natural beauty, awe inspiring sights and
							endless fun activities make it one of the most appealing tourist
							destinations in America.</li>
					</ul>
				</div>
			</div>
			<div>
				<div class="image">
					<h4>3. Rome, Italy</h4>
					<br> <img alt="Rome" src="/Images/rome.jpg">
				</div>
				<div class="list">
					<ul>
						<li><strong>Best Time to visit: April-June</strong></li>
						<li>Rome is one of the most popular destinations in the world
							for art appreciators.</li>
						<li>Rome boasts a huge collection of artwork and Romans hold
							on to it with pride. Museums, galleries, old villas and palaces,
							Rome will give you a hint of how was the life of its old noble
							families also through their artwork-rich residences, some turned
							into museums, most still private.</li>
						<li>There are buildings and structures hundreds, thousands of
							years old, and every part of the city has a special history to
							it.</li>
						<li>Rome boasts a huge collection of artwork and Romans hold
							on to it with pride. Museums, galleries, old villas and palaces,
							Rome will give you a hint of how was the life of its old noble
							families also through their artwork-rich residences, some turned
							into museums, most still private.</li>
					</ul>
				</div>
			</div>
			<div>
				<div class="image">
					<h4>4. Maui, Hawaii</h4>
					<br> <img alt="Maui" src="/Images/maui.jpg">
				</div>
				<div class="list">
					<ul>
						<li><strong>Best Time to visit: April-May,
								September-November</strong></li>
						<li>Maui has more miles of swimmable beaches than any other
							island in Hawaii.</li>
						<li>Maui is one of the epicenters of Hawaiian Regional
							cuisine, and its chefs are constantly pushing the boundaries on
							innovative culinary trends.</li>
						<li>Whether it's watching the day break while standing atop
							the 10,023 ft. summit, or watching the stars come out at night as
							daylight fades in the west, there's an inescapable mountaintop
							magic you'll find at Haleakala Crater.</li>
						<li>Loved by some and loathed by others, the Road to Hana-if
							done correctly-is arguably Maui's best sight.</li>
						<li>Many of the world's most popular watersports were
							invented right here in Maui, and kitesurfers, windsurfers,
							paddlers, and surfers make annual pilgrimages here to the island
							to play on the fabled North Shore.</li>
					</ul>
				</div>
			</div>
			<div>
				<div class="image">
					<h4>5. Masai Mara, Kenya</h4>
					<br> <img alt="Masai Mara" src="/Images/masai.jpg">
				</div>
				<div class="list">
					<ul>
						<li><Strong>Best Time to visit: July-October</Strong></li>
						<li>The Wildebeest migration, comprising of Wildebeests and zebras, will
							send shivers up your spine at the sound of thunderous hooves
							making their way across the Serengeti to Masai Mara.</li>
						<li>The Masai Mara National Reserve is known for its
							incredible abundance of Wildlife. From the graceful Thompson's
							Gazelles and Giraffes to the menacing Silver Back Jackals,
							there's always something to see.</li>
						<li>A hot air balloon trip will offer you a panoramic view of
							the reserve as it glides through the air.</li>
						<li>The Masai Mara National Reserve, after Amboseli National
							Park, is considered the hot spot for bird watching.</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
	<script>
		document.getElementById("contact").style.display = "none";
		document.getElementById("about").style.display = "none";
		function checks(){
			var a=document.getElementById("password1").value;
			var b=document.getElementById("password2").value;
			if(a==b){
				alert("Password changed");
			}else{
				alert("Password mismatch");
			}
		}
		function openNav() {
			document.getElementById("mySidepanel").style.width = "350px";
		}

		function closeNav() {
			document.getElementById("mySidepanel").style.width = "0";
		}
		function contain() {
			document.querySelector(".popup").style.display = "flex";
			document.getElementById("mySidepanel").style.width = "0";
		}
		document.getElementById("mySidepanel").addEventListener("click",
				function() {
					document.querySelector(".").style.display = "none";
				})
		function hide(){
			document.querySelector(".popup").style.display = "none";
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