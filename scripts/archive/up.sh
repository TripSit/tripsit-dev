tripsit_network="$(docker network ls -qf name=tripsit)"
# If the tripsit_network does NOT exist, create it
if [[ -z "${tripsit_network}" ]]; then
	echo "Creating network"
	docker network create tripsit
fi

echo "Starting containers"
for project_id in "${DOCKER_COMPOSE_PROJECT_IDS[@]}"; do
	echo "Composing ${project_id}"
	docker compose \
		-f "${REPOS_PATH}/${project_id}/docker-compose.yml" \
		up -d --build
		# --env-file ./.env up -d --build
		# Run only on the http-api project
		# if [ ${project_id} = http-api ]; then
		#   sleep 10
		# 	project_path="${REPOS_PATH}/${project_id}"
		# 	echo "Refreshing migrations on ${project_id}"
		# 	npm --prefix "${project_path}" run reset-db
		# 	# echo "Running migration on ${project_id}"
		# 	# npm --prefix "${project_path}" knex migrate:latest
		# 	# echo "Running seed on ${project_id}"
		# 	# npm --prefix "${project_path}" knex seed:run
		# fi
done

echo "Done starting containers"