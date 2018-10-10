#!/usr/bin/env bash

# svc = services
# rc = replica controllers
# ing = ingress
# po = pods
# deploy = deployments
# ds = daemonset
teardown_array=( deploy ing ds rc svc po )

for area in ${teardown_array[@]} ; do
	specific_area=$(kubectl get $area -o name | grep -v 'service/kubernetes')
	for item in $specific_area ; do
		if [[ $area == 'po' ]] ; then
			kubectl get $item | grep 'Running' &> /dev/null
			item_status=$?
			if [[ $item_status == 0 ]] ; then
				# echo "Deleteing pod: $item"
				kubectl delete --wait=false $item
			fi
		else
			# echo "Deleteing: $item"
			kubectl delete $item
		fi
	done
	sleep 1
done
