containers="$(docker ps -qaf name=tripsit)"
if [[ ! -z "${containers}" ]]; then
	running_containers="$(docker ps -qf name=tripsit)"
	if [[ ! -z "${running_containers}" ]]; then
		docker stop "${running_containers}"
	fi
	docker rm "${containers}"
	unset running_containers
fi

container_volumes="$(docker volume ls -qf name=tripsit)"
if [[ ! -z "${container_volumes}" ]]; then
	docker volume rm "${container_volumes}"
fi

unset containers
unset container_volumes
