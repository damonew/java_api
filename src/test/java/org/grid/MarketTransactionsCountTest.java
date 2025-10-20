package org.grid;

import org.junit.jupiter.api.Test;

import static org.assertj.core.api.Assertions.assertThat;

public class MarketTransactionsCountTest extends DaoBaseTest {
    @Test
    void testMarketTransactionsRowCount() {
        Integer count = jdbcTemplate.queryForObject(
            "SELECT COUNT(*) FROM grid_user.market_transactions", Integer.class);
        assertThat(count).isNotNull();
        assertThat(count).isEqualTo(10000);
    }
}
