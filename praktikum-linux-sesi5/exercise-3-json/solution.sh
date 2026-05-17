#!/bin/bash

mkdir -p output

# =========================================
# Soal 1 - Top 5 customer by spending
# =========================================

jq -r '[.customer.id, .total] | @tsv' orders.jsonl \
| awk '{
sum[$1]+=$2
}
END{
for(c in sum)
    print sum[c], c
}' \
| sort -rn \
| head -5 \
> output/top-customers.txt

# =========================================
# Soal 2 - Invalid order totals
# =========================================

jq -r '
[
    .order_id,
    .total,
    (
        .items
        | map((.qty|tonumber) * (.price|tonumber))
        | add
    )
]
| @tsv
' orders.jsonl \
| awk '{
diff=$2-$3

if(diff < 0)
    diff=-diff

if(diff > 1)
    print
}' \
> output/invalid-orders.txt

# =========================================
# Soal 3 - Top 10 most purchased SKU
# =========================================

jq -r '.items[]? | [.sku, .qty] | @tsv' orders.jsonl \
| awk '{
sum[$1]+=$2
}
END{
for(s in sum)
    print sum[s], s
}' \
| sort -rn \
| head -10 \
> output/top-sku.txt

# =========================================
# Soal 4 - Convert JSONL to flat CSV
# =========================================

jq -r '
[
    .order_id,
    .customer.id,
    .customer.name,
    (.items // [] | length),
    .total,
    .order_date
]
| @csv
' orders.jsonl \
> output/orders-flat.csv

# =========================================
# Soal 5 - Average order value per week
# =========================================

jq -r '[.order_date, .total] | @tsv' orders.jsonl \
| while IFS=$'\t' read -r date total
do
    week=$(date -d "$date" +%Y-%U)
    echo "$week $total"
done \
| awk '{
sum[$1]+=$2
count[$1]++
}
END{
for(w in sum){
avg=sum[w]/count[w]
printf "%s %.2f\n", w, avg
}
}' \
| sort \
> output/weekly-average.txt
