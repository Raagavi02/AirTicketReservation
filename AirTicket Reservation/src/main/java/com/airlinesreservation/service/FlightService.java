package com.airlinesreservation.service;

import java.util.List;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import com.airlinesreservation.model.FlightDetails;

@Service
public class FlightService {

	public String sendEmail(String username, String existspassword, String type) {
		String recipient = username;

		// email ID of Sender.
		String sender = "";// sender's email address
		String password = "";//sender's password
		// Getting system properties
		Properties properties = System.getProperties();
		properties.put("mail.smtp.auth", "true");
		properties.put("mail.smtp.starttls.enable", "true");
		properties.put("mail.smtp.host", "smtp.gmail.com");
		properties.put("mail.smtp.port", "587");

		// creating session object to get properties
		Session session = Session.getInstance(properties, new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(sender, password);// userid and password for "from" email address
			}
		});

		try {
			// MimeMessage object.
			Message message = new MimeMessage(session);

			// Set From Field: adding senders email to from field.
			message.setFrom(new InternetAddress(sender));

			// Set To Field: adding recipient's email to from field.
			message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
			if (type.equals("addcontact")) {
				message.setSubject("Contact Support");

				// set body of the email.
				message.setText("Dear " + existspassword + ", Thanks for your valuable comment.");
			} else {
				// Set Subject: subject of the email
				message.setSubject("Login Credentials");

				// set body of the email.
				message.setText("Dear User,username: " + username + ", password: " + existspassword);
			}
			// Send email.
			Transport.send(message);
			return "Mail successfully sent";
		} catch (MessagingException mex) {
			mex.printStackTrace();
		}
		return "execution failed";
	}

	public List<FlightDetails> calculation(List<FlightDetails> flight, String bookingclass, int adult, int infant,
			int kid) {
		for (FlightDetails flightDetails : flight) {
			double distance = flightDetails.getDistance();
			double duration = distance / 548.219;
			double adultcost = 0;
			double infantcost = 0;
			double kidcost = 0;
			double tax = 0;
			if (bookingclass.equals("Economy")) {
				adultcost = distance * 5; // adult -> rs. 5/km
				infantcost = distance * 2; // infant -> rs. 2/km
				kidcost = distance * 3.5; // kid -> rs. 3.5/km
			} else {
				adultcost = distance * 7; // adult -> rs. 7/km
				infantcost = distance * 4; // infant -> rs. 4/km
				kidcost = distance * 5.5; // kid -> rs. 5.5/km
			}
			double cost = adult * adultcost + infant * infantcost + kid * kidcost;
			if (bookingclass.equals("Economy")) {
				tax = cost + cost * 5 / 100;// 5% tax for economy class
			} else {
				tax = cost + cost * 12 / 100;// 12% tax for business class
			}
			flightDetails.setFare(Math.round(cost * 100.0) / 100.0);
			flightDetails.setPriceTax(Math.round(tax * 100.0) / 100.0);
			flightDetails.setDuration(Math.round(duration * 100.0) / 100.0);
		}
		return flight;
	}

}
