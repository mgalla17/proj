COPY_ALL=1

for i in HTML CGI ; do
	cd ~project/$i
	ls | while read file; do
		if [ '$COPY_ALL' = '1' ]; then 
			if [ '~project/'$i'/'$file -ot '~public_html/'$i'/'$file  ]; then
				cp ~project/$i/$file ~/public_html/$i/$file
			fi
		else
			cp ~project/$i/$file ~/public_html/$i/$file
		fi
done
