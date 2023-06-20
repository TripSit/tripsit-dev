for project_id in "${ALL_PROJECTS[@]}"; do
    project_path="${REPOS_PATH}/${project_id}"

    # Only bootstrap projects that don't already exist in the repos directory
    if [[ ! -d "${project_path}" ]]; 
        then

            # Clone git repo
            echo "Cloning ${project_id}..."
            git clone https://github.com/tripsit/${project_id}.git ${project_path}
            # git clone "git@github.com:TripSit/${project_id}.git" "${project_path}" -q

            # If npm package npm install
            if [[ -f "${project_path}/package.json" ]]; then
                echo "Installing npm packages for ${project_id}"
                npm --prefix "${project_path}" ci -audit false -fund false
            fi

            # Run setup but only on the http-api project
            if [ ${project_id} = http-api ]; then
                echo "Running setup on ${project_id}"
                npm --prefix "${project_path}" run setup 2>/dev/null || true
            fi

            # Copy over example .env file
            if [[ -f "${project_path}/.env.example" ]]; then
                echo "Copying .env.example to .env for ${project_id}"
                cp "${project_path}/.env.example" "${project_path}/.env"
            fi

            # Project specific setup
            case "${project_id}" in
                "irc-server")
                ;;

                "http-api")
                ;;

                "discord-bot-test")
                ;;

                "admin-panel")
                ;;

                "data-admin")
                ;;
            esac
        else
            echo "Skipping ${project_id} because it already exists in ${REPOS_PATH}"
    fi
done
