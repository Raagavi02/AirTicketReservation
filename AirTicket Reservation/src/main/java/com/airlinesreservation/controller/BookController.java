package com.airlinesreservation.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.airlinesreservation.dao.FlightDAO;
import com.airlinesreservation.model.FlightDetails;
import com.airlinesreservation.model.LoginDetails;
import com.airlinesreservation.service.FlightService;

@Controller
public class BookController {

	@Autowired
	private FlightDetails flightDetails;
	@Autowired
	private LoginDetails loginDetails;
	@Autowired
	private FlightService flightService;
	@Autowired
	private FlightDAO flightDao;

	// calculates booking details and displays available flights
	@RequestMapping(value = "/flight", method = RequestMethod.POST)
	public String loginDetails(HttpServletRequest request, @RequestParam String from_place,
			@RequestParam String to_place, @RequestParam String departure_date, @RequestParam int adults,
			@RequestParam int kids, @RequestParam int infants, @RequestParam String bookingClass, Model model) {
		String user = request.getParameter("username");
		loginDetails.setUsertype("user");
		flightDetails.setFrom_place(from_place);
		flightDetails.setTo_place(to_place);
		flightDetails.setDeparture_date(departure_date);
		flightDetails.setBookingClass(bookingClass);
		flightDetails.setAdults(adults);
		flightDetails.setInfants(infants);
		flightDetails.setKids(kids);
		List<FlightDetails> isAdded = flightDao.getBooking(flightDetails); // fetches the matching flights from booking
																			// database
		List<FlightDetails> flightd = flightService.calculation(isAdded, bookingClass, adults, // fare and related
																								// details calculated
				infants, kids);
		model.addAttribute("size", isAdded.size()); // pop-up
		if (isAdded.size() != 0) { // checks for match in booking
			for (int i = 0; i < 1; i++) {
				flightDetails.setFare(flightd.get(i).getFare()); // price calculated based on distance
				flightDetails.setDuration(flightd.get(i).getDuration()); // duration calculated bassed on distance
				flightDetails.setPriceTax(flightd.get(i).getPriceTax());
			}
			model.addAttribute("match", flightd); // list of flights
			if (user == null) {
				model.addAttribute("home", "home"); // decides back page
			} else {
				model.addAttribute("username", loginDetails.getUsername());
				model.addAttribute("home", "homeagain");
			}
			return "book";
		} else {
			if (user == null) {
				model.addAttribute("home", "home");
			} else {
				model.addAttribute("username", loginDetails.getUsername());
				model.addAttribute("home", "homeagain");
			}
			return "book";
		}
	}

	// personal details and card details
	@RequestMapping(value = "/carddetails", method = RequestMethod.POST)
	public String bookingDetail(Model model) {
		return "carddetails";
	}

	// displays the flight booked
	@RequestMapping(value = "/details", method = RequestMethod.POST)
	public String displayBooking(@RequestParam String email, @RequestParam String flight_id,
			@RequestParam String username, @RequestParam String mobile, Model model) {
		Random rand = new Random();
		int booking_id = rand.nextInt(1000000000);
		flightDetails.setBooking_id(booking_id);
		flightDetails.setName_of_booking(username);
		flightDetails.setFlight_id(Integer.valueOf(flight_id));
		flightDao.addTransactions(flightDetails);
		FlightDetails flight = flightDao.details(flightDetails);
		model.addAttribute("flightDetails", flight);
		return "details";
	}

	// flights booked by the user
	@RequestMapping(value = "/mybooking", method = RequestMethod.POST)
	public String myBooking(Model model, @RequestParam String username) {
		loginDetails.setUsername(username);
		List<FlightDetails> list = flightDao.myBookings(loginDetails.getUsername());
		model.addAttribute("login", loginDetails);
		model.addAttribute("result", list);
		return "viewBookingDetails";
	}

	// edits flight booking
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String editBooking(@RequestParam String booking_id, Model model, HttpServletRequest request) {
		String url = request.getHeader("referer");
		flightDetails.setBooking_id(Integer.valueOf(booking_id));
		model.addAttribute("username", loginDetails.getUsername());
		model.addAttribute("booking_id", booking_id);
		model.addAttribute("check", url == null); // checks if the url is entered directly
		return "changeDetails";
	}

	// edited flight bookings changed in database
	@RequestMapping(value = "/changeDetails", method = RequestMethod.POST)
	public String changeDetails(Model model, @RequestParam String bookingClass, @RequestParam int adults,
			@RequestParam int infants, @RequestParam int kids) {
		flightDetails.setBookingClass(bookingClass);
		flightDetails.setAdults(adults);
		flightDetails.setInfants(infants);
		flightDetails.setKids(kids);
		FlightDetails flightd = flightDao.bookingDistance(flightDetails.getBooking_id());
		flightDetails.setFrom_place(flightd.getFrom_place());
		flightDetails.setTo_place(flightd.getTo_place());
		flightDetails.setDeparture_date(flightd.getDeparture_date());
		flightDetails.setDistance(flightd.getDistance());
		flightDetails.setDuration(flightd.getDuration());
		double adultcost = 0;
		double infantcost = 0;
		double kidcost = 0;
		double tax = 0;
		if (flightDetails.getBookingClass().equals("Economy")) {
			adultcost = flightDetails.getDistance() * 5;
			infantcost = flightDetails.getDistance() * 2;
			kidcost = flightDetails.getDistance() * 3.5;
		} else {
			adultcost = flightDetails.getDistance() * 7;
			infantcost = flightDetails.getDistance() * 4;
			kidcost = flightDetails.getDistance() * 5.5;
		}
		double cost = flightDetails.getAdults() * adultcost + flightDetails.getInfants() * infantcost
				+ flightDetails.getKids() * kidcost;
		if (flightDetails.getBookingClass().equals("Economy")) {
			tax = cost + cost * 5 / 100;
		} else {
			tax = cost + cost * 12 / 100;
		}
		flightDetails.setFare(Math.round(cost * 100.0) / 100.0);
		flightDetails.setPriceTax(Math.round(tax * 100.0) / 100.0);
		flightDao.change(flightDetails);
		model.addAttribute("login", loginDetails);
		return "loggedUser";
	}

	// Cancel the particular flight booked by user
	@RequestMapping(value = "/cancel", method = RequestMethod.GET)
	public String cancelBooking(@RequestParam String booking_id, Model model, HttpServletRequest request) {
		String url = request.getHeader("referer");
		if (url == null) {
			return "redirect:/home";
		}
		flightDetails.setBooking_id(Integer.valueOf(booking_id));
		flightDao.cancelBooking(flightDetails.getBooking_id()); // canceling the booking based on the booking_id
		model.addAttribute("login", loginDetails);
		return "loggedUser";
	}

	// List of flights available in database(Admins)
	@RequestMapping(value = "/availableFlights", method = RequestMethod.POST)
	public String availableFlight(Model model) {
		List<FlightDetails> flight = flightDao.allFights();
		model.addAttribute("login", loginDetails);
		model.addAttribute("list", flight);
		return "displayFlightDetails";
	}

	// Add flight details(Admins)
	@RequestMapping(value = "/addFlights", method = RequestMethod.POST)
	public String addFlight(Model model) {
		List<String> list = new ArrayList<String>();
		list.add("Economy");
		list.add("Business");
		model.addAttribute("places", flightDao.airplotDetails());
		model.addAttribute("Class", list);
		model.addAttribute("login", loginDetails);
		return "addDetails";
	}

	// Adds flight to database
	@RequestMapping(value = "/addFlightDetails", method = RequestMethod.POST)
	public String addFlightDB(@RequestParam String flight_number, @RequestParam String flight_name,
			@RequestParam String from_place, @RequestParam String to_place, @RequestParam String departure_date,
			@RequestParam String distance, @RequestParam String time, Model model) {
		if (from_place.equals(to_place)) {
			model.addAttribute("username", loginDetails.getUsername());
			model.addAttribute("login", loginDetails);
			return "loggedAdmin";
		}
		flightDetails.setFrom_place(from_place);
		flightDetails.setTo_place(to_place);
		flightDetails.setDeparture_date(departure_date);
		flightDetails.setTime(time);
		flightDetails.setFlight_number(flight_number);
		flightDetails.setAirlines(flight_name);
		flightDetails.setDistance(Double.valueOf(distance));
		flightDao.addFlight(flightDetails);
		model.addAttribute("username", loginDetails.getUsername());
		model.addAttribute("login", loginDetails);
		return "loggedAdmin";
	}

	// Add flight details(Admins)
	@RequestMapping(value = "/editFlight", method = RequestMethod.GET)
	public String editFlight(@RequestParam int flight_id, Model model, HttpServletRequest request) {
		String url = request.getHeader("referer");
		if (url == null) {
			return "redirect:/home";
		}
		flightDetails.setFlight_id(flight_id);
		List<String> list = new ArrayList<String>();
		list.add("Economy");
		list.add("Business");
		model.addAttribute("places", flightDao.airplotDetails());
		model.addAttribute("Class", list);
		model.addAttribute("check", url == null);
		model.addAttribute("login", loginDetails);
		return "editFlight";
	}

	// Edit flight details(Admins)
	@RequestMapping(value = "/editFlightDetails", method = RequestMethod.POST)
	public String editFlightDetails(@RequestParam String flight_number, @RequestParam String flight_name,
			@RequestParam String from_place, @RequestParam String to_place, @RequestParam String departure_date,
			@RequestParam String distance, @RequestParam String time, Model model) {
		if (from_place.equals(to_place)) {
			model.addAttribute("username", loginDetails.getUsername());
			model.addAttribute("login", loginDetails);
			return "loggedAdmin";
		}
		flightDetails.setFrom_place(from_place);
		flightDetails.setTo_place(to_place);
		flightDetails.setDeparture_date(departure_date);
		flightDetails.setTime(time);
		flightDetails.setFlight_number(flight_number);
		flightDetails.setAirlines(flight_name);
		flightDetails.setDistance(Double.valueOf(distance));
		flightDao.editFlight(flightDetails);
		model.addAttribute("username", loginDetails.getUsername());
		model.addAttribute("login", loginDetails);
		return "loggedAdmin";
	}

	// Cancel flight details(Admins)
	@RequestMapping(value = "/cancelFlight", method = RequestMethod.GET)
	public String cancelFlight(@RequestParam int flight_id, Model model, HttpServletRequest request) {
		String url = request.getHeader("referer");
		if (url == null) {
			return "redirect:/home";
		}
		flightDetails.setFlight_id(flight_id);
		flightDao.cancelFlight(flight_id);
		model.addAttribute("check", url == null);
		model.addAttribute("username", loginDetails.getUsername());
		model.addAttribute("login", loginDetails);
		return "loggedAdmin";
	}

	// Contact admin for query
	@RequestMapping(value = "/contact", method = RequestMethod.GET)
	public String contact(@RequestParam String username, Model model, HttpServletRequest request) {
		String url = request.getHeader("referer");
		if (url == null) {
			return "redirect:/home";
		}
		model.addAttribute("login", loginDetails);
		return "contact";
	}

	// Custom email - reply for contacting admin
	@RequestMapping(value = "/addcontact", method = RequestMethod.POST)
	public String addcontact(@RequestParam String email, @RequestParam String user, @RequestParam String message,
			Model model) {
		flightService.sendEmail(email, user, "addcontact");
		model.addAttribute("login", loginDetails);
		return "loggedUser";
	}

}
