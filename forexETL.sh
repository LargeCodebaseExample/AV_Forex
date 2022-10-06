START=$(date +%s)

# do something
cd /srv/AV_Forex
Rscript forexETL.R  > /srv/AV_Forex/forexETL.txt 2>&1
cp /srv/AV_Forex/forexETL.txt /usr/share/nginx/html/forexETL.txt

# start your script work here
END=$(date +%s)
DIFF=$(( $END - $START ))
echo "XXX forexETL $START $DIFF"
