#!/bin/bash
# generate_bulk_transactions.sh: Generate 10,000 market_transactions inserts for H2 SQL
# Usage: ./generate_bulk_transactions.sh > insert_10k_bulk_transactions.sql

# Set base timestamp (2025-10-20 10:00:00, CST/CDT assumed -0500)
BASE_DATE="2025-10-20 10:00:00"
OFFSET="-0500"
BASE_EPOCH=$(date -j -f "%Y-%m-%d %H:%M:%S %z" "$BASE_DATE $OFFSET" +%s)

PARTICIPANTS=(1 2 3)
TYPES=("Buy" "Sell")
AMOUNTS=(183.95 116.11)
PRICES=(48.40 37.32)

COUNT=10000

# Print header
cat <<EOF
-- Bulk insert of 10,000 transactions for market_transactions
INSERT INTO market_transactions (id, participant_id, transaction_type, amount_mwh, price_per_mwh, timestamp, epoch, updated_at) VALUES
EOF

for ((i=1; i<=COUNT; i++)); do
  pid=${PARTICIPANTS[$((RANDOM % 3))]}
  ttype=${TYPES[$((RANDOM % 2))]}
  amt=${AMOUNTS[$((RANDOM % 2))]}
  price=${PRICES[$((RANDOM % 2))]}
  # Spread timestamps by 1 second each for uniqueness
  epoch=$((BASE_EPOCH + i - 1))
  ts=$(date -u -r $epoch +"%Y-%m-%d %H:%M:%S")
  # Print row, add comma except for last row
  if [ $i -lt $COUNT ]; then
    echo "($i, $pid, '$ttype', $amt, $price, '$ts', $epoch, CURRENT_TIMESTAMP),"
  else
    echo "($i, $pid, '$ttype', $amt, $price, '$ts', $epoch, CURRENT_TIMESTAMP);"
  fi
done

