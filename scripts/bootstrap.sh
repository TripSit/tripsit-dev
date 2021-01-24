
for project_id in "${ALL_PROJECTS[@]}"; do
	project_path="${REPOS_PATH}/${project_id}"

	# Only bootstrap projects that don't already exist in the repos directory
	if [[ ! -d "${project_path}" ]]; then

		# Clone git repo
		git clone "git@github.com:TripSit/${project_id}.git" "${project_path}"

		# If npm package npm install
		if [[ -f "${project_path}/package.json" ]]; then
			npm --prefix "${project_path}" install
			npm --prefix "${project_path}" run setup 2> /dev/null || true
		fi

		# Copy over example .env file
		if [[ -f "${project_path}/.env.example" ]]; then
			cp "${project_path}/.env.example" "${project_path}/.env"
		fi
	fi
done
