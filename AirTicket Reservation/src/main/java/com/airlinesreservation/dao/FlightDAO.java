package com.airlinesreservation.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Component;

import com.airlinesreservation.model.FlightDetails;
import com.airlinesreservation.util.DBConnection;

@Component
public class FlightDAO {

	// List of international flights for dropdown
	public List<String> airplotDetails() {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;
		List<String> list = new ArrayList<String>();

		String airport = "";
		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement(); // Statement is used to write queries. Read more about it.
			resultSet = statement.executeQuery("select location,airport,IATA from flights");
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				airport = resultSet.getString("location") + " , " + resultSet.getString("airport") + " , "
						+ resultSet.getString("IATA");
				list.add(airport);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// gets all the flight details from database
	public List<FlightDetails> getBooking(FlightDetails flight) {
		List<FlightDetails> list = new ArrayList<>();
		String date = flight.getDeparture_date();
		String[] froms = flight.getFrom_place().split(","); 
		String[] tos = flight.getTo_place().split(",");
		String from = froms[froms.length - 1].trim();// database has only the IATA code
		String to = tos[tos.length - 1].trim();
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		String from_db = "";
		String to_db = "";
		String date_db = "";
		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			resultSet = statement.executeQuery(
					"select flight_id,flight_no,flight_name,from_city,to_city,date,time,distance from bookings");
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				int f_id = resultSet.getInt("flight_id");
				String f_no = resultSet.getString("flight_no");
				String f_name = resultSet.getString("flight_name");
				from_db = resultSet.getString("from_city"); // fetch the values present in database
				to_db = resultSet.getString("to_city");
				date_db = resultSet.getString("date");
				String time = resultSet.getString("time");
				double distance = resultSet.getDouble("distance");
				if (from.equals(from_db) && to.equals(to_db) && date_db.equals(date)) {
					FlightDetails flightdetails = new FlightDetails();
					flightdetails.setFlight_id(f_id);
					flightdetails.setFlight_number(f_no);
					flightdetails.setAirlines(f_name);
					flightdetails.setFrom_place(from_db);
					flightdetails.setTo_place(to_db);
					flightdetails.setDeparture_date(date);
					flightdetails.setTime(time);
					flightdetails.setDistance(distance);
					list.add(flightdetails);
				}
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// Once booked the values of booking details are entered in database
	public void addTransactions(FlightDetails flightDetails) {
		Connection con = null;
		Statement statement = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			int flight_id = flightDetails.getFlight_id();
			String bookingClass = flightDetails.getBookingClass();
			int booking_id = flightDetails.getBooking_id();
			double duration = flightDetails.getDuration();
			double tax = flightDetails.getPriceTax();
			double fare = flightDetails.getFare();
			String name = flightDetails.getName_of_booking();
			int adults = flightDetails.getAdults();
			int infants = flightDetails.getInfants();
			int kids = flightDetails.getKids();
			String query = "INSERT INTO transactions(flight_id,class,booking_id,duration,cost,username,adults,infants,kids,finalcost) VALUES('"
					+ flight_id + "','" + bookingClass + "','" + booking_id + "','" + duration + "','" + fare + "','"
					+ name + "','" + adults + "','" + infants + "','" + kids + "','" + tax + "')";

			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// inserting into table containing all the booked flight details
	public FlightDetails details(FlightDetails flight) {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			String query = "TRUNCATE final";
			statement.executeUpdate(query);
			query = "INSERT INTO final(flight_id,flight_no,flight_name,from_city,to_city,date,time,distance,class,booking_id,duration,cost,username,adults,infants,kids,finalcost) "
					+ "SELECT b.flight_id,b.flight_no,b.flight_name,b.from_city,b.to_city,b.date,b.time,b.distance,t.class,t.booking_id,t.duration,t.cost,t.username,t.adults,t.infants,t.kids,t.finalcost FROM bookings b "
					+ "JOIN transactions t ON t.flight_id=b.flight_id";
			statement.executeUpdate(query);
			resultSet = statement.executeQuery("select * from final WHERE booking_id=" + flight.getBooking_id());
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				FlightDetails flightDetails = new FlightDetails();
				flightDetails.setFlight_id(resultSet.getInt("flight_id")); // fetch the values present in database
				flightDetails.setFlight_number(resultSet.getString("flight_no"));
				flightDetails.setAirlines(resultSet.getString("flight_name"));
				flightDetails.setFrom_place(resultSet.getString("from_city"));
				flightDetails.setTo_place(resultSet.getString("to_City"));
				flightDetails.setDeparture_date(resultSet.getString("date"));
				flightDetails.setTime(resultSet.getString("time"));
				flightDetails.setDistance(resultSet.getDouble("distance"));
				flightDetails.setBookingClass(resultSet.getString("class"));
				flightDetails.setBooking_id(resultSet.getInt("booking_id"));
				flightDetails.setDuration(resultSet.getDouble("duration"));
				flightDetails.setFare(resultSet.getDouble("cost"));
				flightDetails.setName_of_booking(resultSet.getString("username"));
				flightDetails.setAdults(resultSet.getInt("adults"));
				flightDetails.setInfants(resultSet.getInt("infants"));
				flightDetails.setKids(resultSet.getInt("kids"));
				flightDetails.setPriceTax(resultSet.getDouble("finalcost"));
				return flightDetails;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// fetches data of particular user's bookings
	public List<FlightDetails> myBookings(String username) {
		List<FlightDetails> list = new ArrayList<FlightDetails>();
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;
		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			resultSet = statement.executeQuery("SELECT * FROM final WHERE username='" + username + "'");
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				FlightDetails flightDetails = new FlightDetails();
				flightDetails.setFlight_id(resultSet.getInt("flight_id")); // fetch the values present in database
				flightDetails.setFlight_number(resultSet.getString("flight_no"));
				flightDetails.setAirlines(resultSet.getString("flight_name"));
				flightDetails.setFrom_place(resultSet.getString("from_city"));
				flightDetails.setTo_place(resultSet.getString("to_City"));
				flightDetails.setDeparture_date(resultSet.getString("date"));
				flightDetails.setTime(resultSet.getString("time"));
				flightDetails.setDistance(resultSet.getDouble("distance"));
				flightDetails.setBookingClass(resultSet.getString("class"));
				flightDetails.setBooking_id(resultSet.getInt("booking_id"));
				flightDetails.setDuration(resultSet.getDouble("duration"));
				flightDetails.setFare(resultSet.getDouble("cost"));
				flightDetails.setName_of_booking(resultSet.getString("username"));
				flightDetails.setAdults(resultSet.getInt("adults"));
				flightDetails.setInfants(resultSet.getInt("infants"));
				flightDetails.setKids(resultSet.getInt("kids"));
				flightDetails.setPriceTax(resultSet.getDouble("finalcost"));
				list.add(flightDetails);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// Changes booking details for particular booking id(user)
	public void change(FlightDetails flightDetails) {
		Connection con = null;
		Statement statement = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			String sql = "UPDATE transactions " + "SET class = '" + flightDetails.getBookingClass() + "',cost="
					+ flightDetails.getFare() + ",finalCost=" + flightDetails.getPriceTax() + ",adults="
					+ flightDetails.getAdults() + ",infants=" + flightDetails.getInfants() + ",kids="
					+ flightDetails.getKids() + " WHERE booking_id = " + flightDetails.getBooking_id();
			statement.executeUpdate(sql);
			sql = "UPDATE final " + "SET class = '" + flightDetails.getBookingClass() + "',cost="
					+ flightDetails.getFare() + ",finalCost=" + flightDetails.getPriceTax() + ",adults="
					+ flightDetails.getAdults() + ",infants=" + flightDetails.getInfants() + ",kids="
					+ flightDetails.getKids() + " WHERE booking_id = " + flightDetails.getBooking_id();
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// gets the distance to recalculate cost
	public FlightDetails bookingDistance(int booking_id) {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;
		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();

			resultSet = statement.executeQuery("SELECT * FROM final WHERE booking_id='" + booking_id + "'");
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				FlightDetails flightDetails = new FlightDetails();
				flightDetails.setFlight_id(resultSet.getInt("flight_id")); // fetch the values present in database
				flightDetails.setFlight_number(resultSet.getString("flight_no"));
				flightDetails.setAirlines(resultSet.getString("flight_name"));
				flightDetails.setFrom_place(resultSet.getString("from_city"));
				flightDetails.setTo_place(resultSet.getString("to_City"));
				flightDetails.setDeparture_date(resultSet.getString("date"));
				flightDetails.setTime(resultSet.getString("time"));
				flightDetails.setDistance(resultSet.getDouble("distance"));
				flightDetails.setBookingClass(resultSet.getString("class"));
				flightDetails.setBooking_id(resultSet.getInt("booking_id"));
				flightDetails.setDuration(resultSet.getDouble("duration"));
				flightDetails.setFare(resultSet.getDouble("cost"));
				flightDetails.setName_of_booking(resultSet.getString("username"));
				flightDetails.setAdults(resultSet.getInt("adults"));
				flightDetails.setInfants(resultSet.getInt("infants"));
				flightDetails.setKids(resultSet.getInt("kids"));
				flightDetails.setPriceTax(resultSet.getDouble("finalcost"));
				return flightDetails;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// deletes the particular booking of user
	public void cancelBooking(int booking_id) {
		Connection con = null;
		Statement statement = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			String sql = "DELETE FROM final " + "WHERE booking_id = " + booking_id;
			statement.executeUpdate(sql);
			sql = "DELETE FROM transactions " + "WHERE booking_id = " + booking_id;
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// list of available flights are displayed 
	public List<FlightDetails> allFights() {

		List<FlightDetails> list = new ArrayList<FlightDetails>();
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		String from_db = "";
		String to_db = "";
		String date_db = "";
		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			resultSet = statement.executeQuery(
					"select flight_id,flight_no,flight_name,from_city,to_city,date,time,distance from bookings");
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				FlightDetails details = new FlightDetails();
				int f_id = resultSet.getInt("flight_id");
				String f_no = resultSet.getString("flight_no");
				String f_name = resultSet.getString("flight_name");
				from_db = resultSet.getString("from_city"); // fetch the values present in database
				to_db = resultSet.getString("to_city");
				date_db = resultSet.getString("date");
				String time = resultSet.getString("time");
				double distance = resultSet.getDouble("distance");
				details.setFlight_id(f_id);
				details.setFlight_number(f_no);
				details.setAirlines(f_name);
				details.setFrom_place(from_db);
				details.setTo_place(to_db);
				details.setDeparture_date(date_db);
				details.setTime(time);
				details.setDistance(distance);
				list.add(details);
			}
			return list;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return null;
	}

	// admin adds flight details to database
	public void addFlight(FlightDetails flightDetails) {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			int count = 0;
			String[] froms = flightDetails.getFrom_place().split(", ");
			String[] tos = flightDetails.getTo_place().split(", ");
			String from = froms[froms.length - 1].trim().toUpperCase();
			String to = tos[tos.length - 1].trim().toUpperCase();
			String query1 = "SELECT MAX(flight_id) FROM bookings";
			resultSet = statement.executeQuery(query1);
			while (resultSet.next()) {
				count = resultSet.getInt(1);
			}
			String query = "INSERT INTO bookings(flight_id,flight_no,flight_name,from_city,to_city,date,time,distance) VALUES ("
					+ (count + 1) + ",'" + flightDetails.getFlight_number() + "','" + flightDetails.getAirlines()
					+ "','" + from + "','" + to + "','" + flightDetails.getDeparture_date() + "','"
					+ flightDetails.getTime() + "','" + flightDetails.getDistance() + "')";
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// admin edits flight details in database
	public void editFlight(FlightDetails flightDetails) {
		Connection con = null;
		Statement statement = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			String[] froms = flightDetails.getFrom_place().split(", ");
			String[] tos = flightDetails.getTo_place().split(", ");
			String from = froms[froms.length - 1].trim().toUpperCase();
			String to = tos[tos.length - 1].trim().toUpperCase();
			String sql = "UPDATE bookings " + "SET flight_no = '" + flightDetails.getFlight_number() + "',flight_name='"
					+ flightDetails.getAirlines() + "',from_city='" + from + "',to_city='" + to + "',date='"
					+ flightDetails.getDeparture_date() + "',time='" + flightDetails.getTime() + "',distance='"
					+ flightDetails.getDistance() + "' WHERE flight_id = '" + flightDetails.getFlight_id() + "'";
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	
	// admin cancels particular flight details in database
	public void cancelFlight(int flight_id) {
		Connection con = null;
		Statement statement = null;
		String sql = "";
		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			sql = "DELETE FROM transactions " + "WHERE flight_id = " + flight_id;
			statement.executeUpdate(sql);
			sql = "DELETE FROM bookings " + "WHERE flight_id = " + flight_id;
			statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
