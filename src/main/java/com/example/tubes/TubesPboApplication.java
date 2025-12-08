package com.example.tubes;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import com.example.tubes.servlet.HelloServlet;

import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

@SpringBootApplication
public class TubesPboApplication extends SpringBootServletInitializer {

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
		return application.sources(TubesPboApplication.class);
	}

	public static void main(String[] args) {
		SpringApplication.run(TubesPboApplication.class, args);
	}

	@Bean
	public ServletRegistrationBean<HelloServlet> servletRegistrationBean() {
		return new ServletRegistrationBean<>(
				new HelloServlet(), "/hello-servlet/*");
	}
}
