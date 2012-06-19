
mkdir Fetcher

for i in $(ls www.ebi.ac.uk-ena-sra)
do
	mkdir Fetcher/$i
	grep -v "Not available" www.ebi.ac.uk-ena-sra/$i |grep -v Study > Fetcher/$i/overlay

	count=$(cat Fetcher/$i/overlay|wc -l)

	echo "$i has $count"

	mkdir Fetcher/$i/wget-scripts
	mkdir Fetcher/$i/wget-logs
	mkdir Fetcher/$i/contents
	mkdir Fetcher/$i/checksums

	for j in $(seq 1 $count)
	do
		file=$( awk -F '\t' '{print $14}' Fetcher/$i/overlay|head -n $j|tail -n1)
		md5=$( awk -F '\t' '{print $16}' Fetcher/$i/overlay|head -n $j|tail -n1)
		link=$( awk -F '\t' '{print $17}' Fetcher/$i/overlay|head -n $j|tail -n1)

		
		echo "$md5  $file" > Fetcher/$i/checksums/$file
		echo "if test -f Fetcher/$i/contents/$file 
then
	echo a > /dev/null
else

wget $link -o Fetcher/$i/wget-logs/$file

if test \$(md5sum -c Fetcher/$i/checksums/$file|grep OK$|wc -l) = 1
then
	mv $file Fetcher/$i/contents
fi

fi" > Fetcher/$i/wget-scripts/$file
		
	done
done
