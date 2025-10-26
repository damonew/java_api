#!/bin/bash
# Generate 10,000 market_transactions rows using only valid participant_ids (1, 2, 3, 4)
# Date range: 2025-10-10 to 2025-10-24, random time each day

output_file="insert_10k_bulk_transactions.sql"
rm -f "$output_file"

start_date="2025-10-10"
end_date="2025-10-24"
start_ts=$(date -j -f "%Y-%m-%d" "$start_date" +%s)
end_ts=$(date -j -f "%Y-%m-%d" "$end_date" +%s)
days_range=$(( (end_ts - start_ts) / 86400 ))

# Allowed participant_ids (only valid ones)
participant_ids=(1 2 3 4)

# Write the header
cat <<EOF > "$output_file"
INSERT INTO grid_user.market_transactions (id, participant_id, transaction_type, amount_mwh, price_per_mwh, timestamp, epoch, updated_at) VALUES
EOF

for ((i=1; i<=10000; i++)); do
  # Pick a random participant_id
  idx=$((RANDOM % ${#participant_ids[@]}))
  participant_id=${participant_ids[$idx]}

  # Random transaction type
  if ((RANDOM % 2)); then
    transaction_type="Buy"
  else
    transaction_type="Sell"
  fi

  # Random amount and price
  amount_mwh=$(awk -v min=10 -v max=200 'BEGIN{srand(); printf "%.2f", min+rand()*(max-min)}')
  price_per_mwh=$(awk -v min=30 -v max=60 'BEGIN{srand(); printf "%.2f", min+rand()*(max-min)}')

  # Random day and time
  day_offset=$((RANDOM % (days_range + 1)))
  base_ts=$((start_ts + day_offset * 86400))
  rand_hour=$((RANDOM % 24))
  rand_minute=$((RANDOM % 60))
  rand_second=$((RANDOM % 60))
  timestamp=$(date -j -f "%s" "$base_ts" +"%Y-%m-%d")
  timestamp="$timestamp $(printf "%02d:%02d:%02d" $rand_hour $rand_minute $rand_second)"

  # Epoch for timestamp
  epoch=$(date -j -f "%Y-%m-%d %H:%M:%S" "$timestamp" +%s)

  # Write SQL
  if [[ $i -eq 10000 ]]; then
    echo "($i, $participant_id, '$transaction_type', $amount_mwh, $price_per_mwh, '$timestamp', $epoch, CURRENT_TIMESTAMP);" >> "$output_file"
  else
    echo "($i, $participant_id, '$transaction_type', $amount_mwh, $price_per_mwh, '$timestamp', $epoch, CURRENT_TIMESTAMP)," >> "$output_file"
  fi
done

echo "SQL file '$output_file' generated in sql-delete-me directory."
