#!/bin/bash

mkdir -p output

# =========================================
# Soal 1 - Top 10 IP
# =========================================

awk '{print $1}' nginx_access.log \
| sort \
| uniq -c \
| sort -rn \
| head \
> output/top-ip.txt

# =========================================
# Soal 2 - Error rate per jam
# =========================================

awk '
{
    match($4, /:([0-9][0-9]):/, t)

    hour=t[1]

    total[hour]++

    if($9 >= 400)
        error[hour]++
}

END{
    for(h in total){

        rate=(error[h]/total[h])*100

        printf "%s Total:%d Error:%d Rate:%.2f%%\n",
        h,total[h],error[h],rate
    }
}' nginx_access.log \
> output/error-rate.txt

# =========================================
# Soal 3 - Suspicious IP
# =========================================

awk '$7 ~ /login|admin/ {print $1}' nginx_access.log \
| sort \
| uniq -c \
| awk '$1 > 50' \
| sort -rn \
> output/suspicious-ip.txt

# =========================================
# Soal 4 - Endpoint paling lambat
# =========================================

awk '
{
    endpoint=$7

    if(endpoint != ""){
        total[endpoint]+=$NF
        count[endpoint]++
    }
}

END{
    for(e in total){

        if(count[e] > 0){

            avg=total[e]/count[e]

            printf "%s %.2f ms\n", e, avg
        }
    }
}' nginx_access.log \
| sort -k2 -rn \
> output/slow-endpoints.txt

# =========================================
# Soal 5 - Total traffic
# =========================================

awk '
{
    sum+=$10
}

END{

    mb=sum/(1024*1024)

    printf "Total Bytes: %d\n", sum
    printf "Total MB: %.2f MB\n", mb
}' nginx_access.log \
> output/traffic-summary.txt
