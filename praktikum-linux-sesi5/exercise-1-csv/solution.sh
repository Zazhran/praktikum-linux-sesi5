#!/bin/bash

mkdir -p output

# =========================================
# Soal 1 - Hitung jumlah customer per status
# =========================================

awk -F',' 'NR>1 {print tolower($6)}' data.csv \
| sort \
| uniq -c \
> output/1-status-count.txt

# =========================================
# Soal 2 - Konversi tanggal ke ISO 8601
# =========================================

awk -F',' '
NR==1 {
    print
    next
}

{
    split($5,a,/[\/- ]/)

    if(length(a[3])==2)
        a[3]="20"a[3]

    if(length(a[1])==4)
        $5=a[1] "-" a[2] "-" a[3]
    else
        $5=a[3] "-" a[2] "-" a[1]

    print
}' data.csv \
> output/2-iso-date.csv

# =========================================
# Soal 3 - Ambil customer gmail
# =========================================

awk -F',' '
NR==1 || $3 ~ /@gmail\.com$/
' data.csv \
> output/3-gmail-customers.csv

# =========================================
# Soal 4 - Hapus duplicate email
# =========================================

awk -F',' '
!seen[$3]++
' data.csv \
> output/4-deduplicated.csv

# =========================================
# Soal 5 - Nama tidak title case
# =========================================

awk -F',' '
NR>1 && $2 !~ /^[A-Z][a-z]+( [A-Z][a-z]+)*$/
' data.csv \
> output/5-invalid-names.txt
