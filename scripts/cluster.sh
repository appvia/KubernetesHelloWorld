#!/bin/bash
case "$OSTYPE" in
"linux-gnu")
	KIND_PLATFORM="linux-amd64" ;;
"darwin")
	KIND_PLATFORM="darwin-amd64" ;;
*)
	echo "Uknown platform";
	exit 2 ;;
esac

#https://github.com/kubernetes-sigs/kind/releases/download/v0.8.1/kind-linux-amd64
KIND_VERSION=v0.8.1
#KIND_PLATFORM="linux-amd64" 
KIND_BIN_URL="https://github.com/kubernetes-sigs/kind/releases/download/${KIND_VERSION}/kind-${PLATFORM}"


get_deps(){
	# if kind is installed?
	if ! which "kind"; then
		# install kind?
		wget "$KIND_BIN_URL" -o kind
	else 
		echo "kind found at $(which "kind")"
	fi;
}

usage (){
	echo <<EOF
setup the cluster.
up - setup the cluster
EOF
}

setup_cluster (){
	echo "hi"
	kind 
}


case $1 in
up)
	setup_cluster ;;
*)
	usage ;;

esac