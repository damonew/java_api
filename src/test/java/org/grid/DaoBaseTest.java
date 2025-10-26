package org.grid;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.AfterEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
@ActiveProfiles("test")
public abstract class DaoBaseTest {

    @Autowired
    protected JdbcTemplate jdbcTemplate;

    @BeforeEach
    void setup() throws Exception {}

    @AfterEach
    void teardown() throws Exception {}
}
