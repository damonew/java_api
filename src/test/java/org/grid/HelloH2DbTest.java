
package org.grid;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
@ActiveProfiles("test")
public class HelloH2DbTest {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Test
    void helloH2DbQueryShouldReturnHello() {
        String result = jdbcTemplate.queryForObject("SELECT 'hello'", String.class);
        assertThat(result).isEqualTo("hello");
    }
}

