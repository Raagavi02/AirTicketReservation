package com.airlinesreservation.main;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan("com.airlinesreservation")
public class AirlinesReservation {

	public static void main(String[] args) {
		SpringApplication.run(AirlinesReservation.class, args);
	}

}
