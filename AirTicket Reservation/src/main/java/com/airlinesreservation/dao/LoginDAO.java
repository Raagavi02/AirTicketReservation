package com.airlinesreservation.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.stereotype.Component;

import com.airlinesreservation.model.FlightDetails;
import com.airlinesreservation.model.LoginDetails;
import com.airlinesreservation.util.DBConnection;

@Component
public class LoginDAO {

	// details added after signing up
	public String addUser(String userName, int password) {
		// Assign user entered values to temporary variables.
		Connection con = null;
		Statement statement = null;
		

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			
				String query = "INSERT INTO user(username,password) " + "VALUES ('" + userName + "','" + password
						+ "')";
				statement.executeUpdate(query);
				return "added";

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "";
	}

	// checks for existence of app user details in database
	public String authenticateUser(LoginDetails login) {
		String userName = login.getUsername(); // Assign user entered values to temporary variables.
		String password = login.getPassword();
		String usertype = login.getUsertype();
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		String userNameDB = "";
		String passwordDB = "";

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement(); // Statement is used to write queries. Read more about it.
				resultSet = statement.executeQuery("select username,password from " + usertype); // the table
																											// name is
																											// users and
				// userName,password are
				// columns. Fetching all the
				// records and storing in a
				// resultSet.

				while (resultSet.next()) // Until next row is present otherwise it return false
				{
					userNameDB = resultSet.getString("userName"); // fetch the values present in database
					passwordDB = resultSet.getString("password");

					if (userName.equals(userNameDB) && password.equals(passwordDB)) {
						return "SUCCESS"; //// If the user entered values are already present in the database, which
											//// means user has already registered so return a SUCCESS message.
					}
				}
			} catch (SQLException e) {
			e.printStackTrace();
		}
		return "Invalid user credentials"; // Return appropriate message in case of failure

	}
	
	// displays all matching flight details
	public int addBookingDetails(FlightDetails flight) {

		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			resultSet = statement.executeQuery("select from_city,to_city,date,time from bookings"); // the table name is
																									// users and
																									// userName,password
																									// are columns.
																									// Fetching all the
																									// records and
																									// storing in a
																									// resultSet.

			int id = 0;

			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				String from = resultSet.getString("from_city");
				String to = resultSet.getString("to_city");
				String date = resultSet.getString("date");
				String time = resultSet.getString("time");

				if (from.equalsIgnoreCase(flight.getFrom_place()) && to.equalsIgnoreCase(flight.getTo_place())
						&& date.equals(flight.getDeparture_date()) && time.equals(flight.getTime())) {
					id += resultSet.getInt("flight_id");
				}
			}
			// String query="INSERT INTO transaction(username,password) "+"VALUES
			// ('"+userName+"','"+password+"')";
			// statement.executeUpdate(query);
			return id;

		} catch (SQLException e) {
			e.printStackTrace();
		}
		return 0;

	}

	// checks if account already exists
	public String check(String username,String userType) {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement(); // Statement is used to write queries. Read more about it.
			resultSet = statement.executeQuery("select username from "+userType);
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				String user = resultSet.getString("username");
				if (user.equals(username)) {
					return "account exists";
				}
			}
			return "proceed";
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "";
	}

	// gets password from database for forgot password(user)
	public String searchPassword(String username, String userType) {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			resultSet = statement.executeQuery("select username,password from " + userType);
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				String user = resultSet.getString("username");
				if (user.equals(username)) {
					return resultSet.getString("password");
				} 
			}
				return null;
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "";
	}
	
	// gets password from database for forgot password(admin)
	public String searchPasswordAdmin(String username) {
		Connection con = null;
		Statement statement = null;
		ResultSet resultSet = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			resultSet = statement.executeQuery("select username,password from admin");
			while (resultSet.next()) // Until next row is present otherwise it return false
			{
				String user = resultSet.getString("username");
				if (user.equals(username)) {
					return resultSet.getString("password");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return "";
	}

	//changes password in database
	public void changePassword(String username,String password,String userType) {
		Connection con = null;
		Statement statement = null;

		try {
			con = DBConnection.createConnection(); // Fetch database connection object
			statement = con.createStatement();
			String sql = "UPDATE "+ userType+
	                   " SET password = '"+password+"' WHERE username = '"+username+"'";
	      statement.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
