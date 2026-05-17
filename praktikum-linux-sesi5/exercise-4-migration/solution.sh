#!/bin/bash

# Validasi keberadaan file input
if [ ! -f "produk-lama.csv" ]; then
  echo "Error: File 'produk-lama.csv' tidak ditemukan di direktori ini."
  exit 1
fi

mkdir -p output
rm -f output/tmp.csv

# Langkah pre-processing pakai sed buat bersihin koma ribuan di dalam kutip
# dan menyamakan format pembatas sebelum masuk ke awk
sed -E '
  s/" *, *"/","/g; 
  s/Rp *([0-9]+),([0-9]+)/Rp \1\2/g; 
  s/0,000"/0/g; 
  s/0,-"/0/g
' produk-lama.csv | awk -F',' '
BEGIN { 
  OFS=","
  # Mapping bulan untuk ISO tanggal
  b["Jan"]="01"; b["Feb"]="02"; b["Mar"]="03"; b["Apr"]="04"
  b["May"]="05"; b["Jun"]="06"; b["Jul"]="07"; b["Aug"]="08"
  b["Sep"]="09"; b["Oct"]="10"; b["Nov"]="11"; b["Dec"]="12"
}
{
  if (NR == 1) next
  
  # Bersihkan tanda kutip pembungkus kolom secara global
  for(i=1; i<=NF; i++) {
    gsub(/^"| *"$|^ *| *$/, "", $i)
  }

  kd  = $1
  nm  = $2
  hg  = $3
  st  = $4
  kt  = $5
  tg  = $6

  if (kd == "") next
  tot++

  # 1. Pembersihan Harga & Kurs
  rb = (hg ~ /rb/) ? 1 : 0
  usd = (hg ~ /\$/ || hg ~ /[Uu][Ss][Dd]/) ? 1 : 0
  if (usd == 1) {
    gsub(/[^0-9.]/, "", hg)
    hg = sprintf("%.0f", (hg == "" || hg == ".") ? 0 : hg * 16000)
  } else {
    gsub(/[^0-9]/, "", hg)
    hg = (hg == "") ? 0 : hg
    if (rb == 1) hg = hg * 1000
  }

  # 2. Nama Produk Title Case
  split(nm, k, " "); nc = ""
  for (i=1; i<=length(k); i++) {
    if (k[i] != "") {
      kt_fmt = toupper(substr(k[i],1,1)) tolower(substr(k[i],2))
      nc = (nc == "") ? kt_fmt : nc " " kt_fmt
    }
  }
  nm = nc

  # 3. Normalisasi Kategori
  kt = tolower(kt)
  if (kt == "pakian" || kt == "clothes" || kt == "") kt = "pakaian"

  # 5. Konversi Tanggal ISO
  iso = ""
  if (tg ~ /^[0-9]+$/) {
    iso = strftime("%Y-%m-%d %H:%M:%S", tg)
  } else if (tg ~ /[A-Za-z]/) {
    split(tg, p, " "); m = b[p[2]]; if (m == "") m = "01"
    iso = sprintf("%04d-%02d-%02d 00:00:00", p[3], m, p[1])
  } else {
    gsub(/[\/]/, "-", tg); split(tg, pt, " "); split(pt[1], d, "-")
    jm = (pt[2] != "") ? pt[2] : "00:00:00"
    if (length(jm) == 5) jm = jm ":00"
    if (length(d[1]) == 4) {
      iso = sprintf("%04d-%02d-%02d %s", d[1], d[2], d[3], jm)
    } else {
      if (d[1] > 12) iso = sprintf("%04d-%02d-%02d %s", d[3], d[2], d[1], jm)
      else if (d[2] > 12) iso = sprintf("%04d-%02d-%02d %s", d[3], d[1], d[2], jm)
      else iso = sprintf("%04d-%02d-%02d %s", d[3], d[2], d[1], jm)
    }
  }

  # 4. Deduplikasi data terbaru
  if (!(kd in arr) || iso > tgl[kd]) {
    arr[kd] = "\""kd"\",\""nm"\"," hg ",\""st"\",\""kt"\",\""iso"\""
    tgl[kd] = iso; hg_list[kd] = hg; kt_list[kd] = kt
  }
}
END {
  min = -1; max = 0
  for (x in arr) {
    dd++
    print arr[x] > "output/tmp.csv"
    sum += hg_list[x]
    kat[kt_list[x]]++
    if (min == -1 || hg_list[x] < min) min = hg_list[x]
    if (hg_list[x] > max) max = hg_list[x]
  }
  
  print "=================================================="
  print "                LAPORAN VALIDASI                  "
  print "=================================================="
  print "Total Baris Input   : " tot " baris"
  print "Total Setelah Dedup : " dd " baris"
  print ""
  print "Distribusi Kategori :"
  for (c in kat) printf "  - %-15s : %d produk\n", c, kat[c]
  print ""
  print "Statistik Harga (Rupiah) :"
  print "  - Minimum         : Rp " min
  print "  - Maksimum        : Rp " max
  printf "  - Rata-rata       : Rp %.2f\n", (dd > 0) ? sum/dd : 0
  print "=================================================="
}'

# 6. Pembuatan file output bersih terurut
echo "kode_produk,nama_produk,harga_rupiah,stok,kategori,last_updated" > output/produk-bersih.csv
if [ -f output/tmp.csv ]; then
  sort -V output/tmp.csv >> output/produk-bersih.csv
  rm -f output/tmp.csv
fi
