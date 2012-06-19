
for i in $(ls Gateways)
do
	(

	for j in $(cat Gateways/$i)
	do
		bash $j 

	done  &> Gateways.log/$i

	) &
done
