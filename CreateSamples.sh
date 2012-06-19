

mkdir Samples

for i in $(ls Fetcher)
do
	mkdir Samples/$i

	for j in $(ls Fetcher/$i/wget-scripts)
	do
		ln -s ../../Fetcher/$i/contents/$j Samples/$i/$j
	done
done
