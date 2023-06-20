for project_id in "${ALL_PROJECTS[@]}"; do
	project_path="${REPOS_PATH}/${project_id}"
	if [[ -f "${project_path}/package.json" ]]; then
		npm --prefix "${project_path}" test
	fi
done
