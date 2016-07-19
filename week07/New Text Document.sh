#Specify as variables the "to" and "from" directories
from=~/proj/week08/this/
to=~/proj/week08/that/

#Copies all files from "from" dir to "to" dir
cd $from
for i in *; do
        mv $i $to$i;
done