package com.airlinesreservation.controller;

import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.airlinesreservation.dao.FlightDAO;
import com.airlinesreservation.dao.LoginDAO;
import com.airlinesreservation.model.FlightDetails;
import com.airlinesreservation.model.LoginDetails;
import com.airlinesreservation.service.FlightService;

@Controller
@SessionAttributes({ "flight_id", "username" })
public class LoginController {

	@Autowired
	private LoginDetails loginDetails;
	@Autowired
	private LoginDAO loginDao;
	@Autowired
	private FlightDAO flightDao;
	@Autowired
	private FlightDetails flightDetails;
	@Autowired
	private FlightService flightService;

	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String homePage(Model model) {
		loginDetails = new LoginDetails();
		model.addAttribute("Places", flightDao.airplotDetails());
		model.addAttribute("login", new LoginDetails());
		model.addAttribute("flight", new FlightDetails());
		return "home";
	}

	@RequestMapping(value = "/admin", method = RequestMethod.GET)
	public String adminPage() {
		loginDetails.setUsertype("admin");
		return "adminLogin";
	}

	@RequestMapping(value = "/user", method = RequestMethod.GET)
	public String userPage() {
		loginDetails.setUsertype("user");
		return "userLoginHome";
	}

	// automatic email sent if the app user forgets password
	@RequestMapping(value = "/forgot", method = RequestMethod.POST)
	public String forgot(@RequestParam String username, Model model) {
		String existspassword = loginDao.searchPassword(username, loginDetails.getUsertype());
		if (existspassword == null) {
			return "noSuchAccount";
		}
		String isSuccess = flightService.sendEmail(username, existspassword, "");
		if (isSuccess == "Mail successfully sent") {
			return "checkEmail";
		}
		return "";
	}

	// automatic mail generation (sign up)
	@RequestMapping(value = "/checkingmail", method = RequestMethod.POST)
	public String checkmail(@RequestParam String username, HttpServletRequest request, Model model) {
		String url = request.getHeader("referer");
		String check = loginDao.check(username, loginDetails.getUsertype());
		if (check.equals("proceed")) {
			Random rand = new Random();
			// Generate random integers in range 0 to 999
			int OTP = rand.nextInt(1000000);
			String isSuccess = flightService.sendEmail(username, String.valueOf(OTP), "");
			if (isSuccess.equals("Mail successfully sent") && url.equals("http://localhost:9020/user")) {
				loginDao.addUser(username, OTP);
				return "checkEmail";
			} else if (isSuccess.equals("Mail successfully sent")) {
				loginDao.addUser(username, OTP);
				flightDetails.setName_of_booking(username);
				loginDetails.setUsername(username);
				model.addAttribute("username", loginDetails.getUsername());
				model.addAttribute("flightDetails", flightDetails);
				return "carddetails";
			} else {
				return "error";
			}

		} else {
			return "accountExists";
		}
	}

	// redirects to user login if user haven't logged in else redirects to personal details page
	@RequestMapping(value = "/userLoginagain", method = RequestMethod.GET)
	public String bookLoginPage(@RequestParam String flight_id, Model model, HttpServletRequest request) {
		loginDetails.setUsertype("user");
		String url = request.getHeader("referer");
		if (url == null) {                      // no direct access
			return "redirect:/home";
		}
		 else {
			if (loginDetails.getUsername() != null) {														// checks if already logged in
				flightDetails.setName_of_booking(loginDetails.getUsername());
				flightDetails.setFlight_id(Integer.valueOf(flight_id));
				model.addAttribute("flight_id", flight_id);
				model.addAttribute("username", loginDetails.getUsername());
				return "carddetails";
			}
			flightDetails.setFlight_id(Integer.valueOf(flight_id));
			model.addAttribute("flight_id", flight_id);
			return "userLogin";
		}
	}

	// checks whether user or page has login in and double checks login credentials with the database
	@RequestMapping(value = "/logged", method = RequestMethod.POST)
	public String validation(HttpServletRequest request, @RequestParam String username,
			@Valid @ModelAttribute("login") LoginDetails login, BindingResult re, Model model) {
		String url = request.getHeader("referer");
		if (re.hasErrors()) {
			return "redirect:/home";
		} else {
			if (url.equals("http://localhost:9020/admin")) {
				loginDetails.setUsertype("admin");
			} else {
				loginDetails.setUsertype("user");
			}
			loginDetails.setUsername(login.getUsername());
			loginDetails.setPassword(login.getPassword());
			String userValidate = loginDao.authenticateUser(loginDetails);

			if (userValidate.equals("SUCCESS") && loginDetails.getUsertype().equals("admin")) // If function returns
																								// success string then
																								// user will be rooted
																								// to Home // page
			{
				
				model.addAttribute("username", username);
				model.addAttribute("login", loginDetails);
				return "loggedAdmin";
			} else if (userValidate.equals("SUCCESS") && loginDetails.getUsertype().equals("user")) {
				loginDetails.setUsername(login.getUsername());
				loginDetails.setPassword(login.getPassword());
				model.addAttribute("login", loginDetails);
				if (url.equals("http://localhost:9020/user")) {
					return "loggedUser";
				} else {
					model.addAttribute("username", loginDetails.getUsername());
					flightDetails.setName_of_booking(login.getUsername());
					return "carddetails";
				}
			} else {
				loginDetails=new LoginDetails();
				return "failed";
			}
		}
	}

	// changes the login credentials of app user
	@RequestMapping(value = "/changePassword", method = RequestMethod.POST)
	public String changePassword(HttpServletRequest request, @RequestParam String password,
			@RequestParam String confirm, Model model) {
		if (password.equals(confirm)) {
			loginDao.changePassword(loginDetails.getUsername(), password, loginDetails.getUsertype());
			if (loginDetails.getUsertype().equals("user")) {
				model.addAttribute("login", loginDetails);
				return "loggedUser";
			} else {
				model.addAttribute("login", loginDetails);
				return "loggedAdmin";
			}
		} else {
			if (loginDetails.getUsertype().equals("user")) {
				model.addAttribute("login", loginDetails);
				return "loggedUser";
			} else {
				model.addAttribute("login", loginDetails);
				return "loggedAdmin";
			}
		}
	}

	//easy check for who has logged in and redirects to respective home page
	@RequestMapping(value = "/loginAction", method = RequestMethod.POST)
	public String loggedUser(Model model) {
		model.addAttribute("login", loginDetails);
		if (loginDetails.getUsertype().equals("user")) {
			return "loggedUser";
		} else {
			return "loggedAdmin";
		}
	}

	// Logs out of the system
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public String logout(Model model) {
		loginDetails = new LoginDetails();
		flightDetails = new FlightDetails();
		model.addAttribute("Places", flightDao.airplotDetails());
		model.addAttribute("flight", flightDetails);
		model.addAttribute("login", loginDetails);
		model.addAttribute("log", "Logged out Successfully!");
		return "home";
	}

	// home page in case of booking another ticket
	@RequestMapping(value = "/homeagain", method = RequestMethod.GET)
	public String homeAgain(Model model, HttpServletRequest request) {
		String url = request.getHeader("referer");
		if (url == null) {
			return "redirect:/home";
		}
		model.addAttribute("Places", flightDao.airplotDetails());
		model.addAttribute("login", loginDetails);
		return "homeAgain";
	}

}
