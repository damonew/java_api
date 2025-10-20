package org.grid;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

@SpringBootApplication
public class Application {
    private static final Logger logger = LogManager.getLogger(Application.class);

    public static void main(String[] args) {
        logger.info("--------------------- Grid API --------------------");
        logger.info("H2 Console: http://localhost:8080/h2-console");
        logger.info("Health Check: http://localhost:8080/actuator/health");
        logger.info("---------------------------------------------------");
        SpringApplication.run(Application.class, args);
    }
}