#!/bin/sh
currenttime=$(date +%s)
host=$1
api_key=$2

curl -w "@curl-format.txt" --connect-timeout 10 -o /dev/null -s $host > temp.txt
http_code=`cat temp.txt | grep http_code | awk '{print $2}'`

function mytest {
curl  -X POST --connect-timeout 10 -H "Content-type: application/json" \
-d "{ \"series\" :
         [{\"metric\":\"curl.$1\",
          \"points\":[[$currenttime, $2]],
          \"type\":\"gauge\",
          \"host\":\"$host\",
          \"tags\":[\"env:test\",\"role:curl\",\"http_code:$http_code\"]}
        ]
   }" \
"https://app.datadoghq.com/api/v1/series?api_key=$api_key"
sleep 1
}

metric="time_namelookup"
value=`cat temp.txt | grep time_namelookup | awk '{print $2}'`
mytest $metric $value

metric="time_connect"
value=`cat temp.txt | grep time_connect | awk '{print $2}'`
mytest $metric $value

metric="time_appconnect"
value=`cat temp.txt | grep time_appconnect | awk '{print $2}'`
mytest $metric $value

metric="time_pretransfer"
value=`cat temp.txt | grep time_pretransfer | awk '{print $2}'`
mytest $metric $value

metric="time_redirect"
value=`cat temp.txt | grep time_redirect | awk '{print $2}'`
mytest $metric $value

metric="time_starttransfer"
value=`cat temp.txt | grep time_starttransfer | awk '{print $2}'`
mytest $metric $value

metric="time_total"
value=`cat temp.txt | grep time_total | awk '{print $2}'`
mytest $metric $value