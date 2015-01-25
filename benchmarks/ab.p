# output as png image
 set terminal png

 # save file to "abj.png"
 set output "ab.png"

 # graph a title
 set title "ab -n 1500 -c 150 -g ab.tsv http://bedrock.stg/"

 # nicer aspect ratio for image size
 set size 1,0.7

 # y-axis grid
 set grid y

 # x-axis label
 set xlabel "request"

 # y-axis label
 set ylabel "response time (ms)"

 # plot data from "ab.tsv"
 plot "ab.tsv" using 7 title "ctime" with lines, \
      "ab.tsv" using 8 title "dtime" with lines, \
      "ab.tsv" using 9 title "ttime" with lines, \
      "ab.tsv" using 10 title "wait" with lines
