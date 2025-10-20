package org.grid;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.AfterEach;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.boot.test.context.SpringBootTest;
import java.nio.file.Files;
import java.nio.file.Paths;

@SpringBootTest
@ActiveProfiles("test")
public abstract class DaoBaseTest {
    @Autowired
    protected JdbcTemplate jdbcTemplate;

    @BeforeEach
    void setup() throws Exception {
        String[] scripts = {
            "sql/schema.sql",
            "sql/tables.sql",
            "sql/inserts.sql",
            "sql/insert_10k_bulk_transactions.sql"
        };
        for (String script : scripts) {
            String sql = new String(Files.readAllBytes(Paths.get(script)));
            for (String stmt : sql.split(";")) {
                if (!stmt.trim().isEmpty() && !stmt.trim().startsWith("--")) {
                    jdbcTemplate.execute(stmt);
                }
            }
        }
    }

    @AfterEach
    void teardown() throws Exception {
        String teardownSql = new String(Files.readAllBytes(Paths.get("sql/teardown.sql")));
        for (String stmt : teardownSql.split(";")) {
            if (!stmt.trim().isEmpty() && !stmt.trim().startsWith("--")) {
                jdbcTemplate.execute(stmt);
            }
        }
    }
}

