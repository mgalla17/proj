for i in HTML CGI ; do
	cd ~project/$i
	ls | while read file; do
		if [ '~project/'$i'/'$file -ot '~public_html/'$i'/'$file  ]; then
			cp ~project/$i/$file ~/public_html/$i/$file
		fi
done
