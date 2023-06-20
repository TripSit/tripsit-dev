# Remove project repo directories
echo "Removing repository folders"
for project_id in ${ALL_PROJECTS[@]}; do
	rm -rf "${REPOS_PATH}/${project_id}"
done

echo "Removing containers"
containers="$(docker ps -qaf name=tripsit)"
if [[ ! -z "${containers}" ]]; then
	running_containers="$(docker ps -qf name=tripsit)"
	echo "Containers are running: ${running_containers}"
	if [[ ! -z "${running_containers}" ]]; then
		echo "Stopping containers"
		docker stop ${running_containers}
	fi
	echo "Delete containers"
	docker rm $(docker ps -qaf name=tripsit) 
	# docker rm "${containers}"
	echo "Unseting container"
	unset running_containers
fi
unset containers

echo "Removing Images"
container_images="$(docker images -q)"
if [[ ! -z "${container_images}" ]]; then
	echo "Images: ${container_images}"
	docker image rm ${container_images} || echo "Cannot remove images"
fi
unset container_images

echo "Removing Networks"
container_networks="$(docker network ls -qf name=http-api_default)"
if [[ ! -z "${container_networks}" ]]; then
	echo "Removing http-api_default network"
	docker network rm ${container_networks}
fi
unset container_networks

container_networks="$(docker network ls -qf name=tripsit)"
if [[ ! -z "${container_networks}" ]]; then
	echo "Removing tripsit network"
	docker network rm ${container_networks}
fi
unset container_networks

echo "Removing volumes"
container_volumes="$(docker volume ls -qf name=http-api_http_api_psql_data)"
if [[ ! -z "${container_volumes}" ]]; then
	echo "Volumes: ${container_volumes}"
	docker volume rm ${container_volumes}
fi
unset container_volumes

echo "Done removing everything!"
