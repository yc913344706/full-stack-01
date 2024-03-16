prepare_docker_image()
{
  [ "$#" -eq 1 ] || die "params error"
  _image_name="$1"

	log_info "start prepare_image..."
	#docker rmi -f ${_image_name} || die "docker rmi failed:$_image_name"
	docker pull "${_image_name}"
	docker images --filter=reference="${_image_name}" || die "cannot find docker image: $_image_name"
}

stop_old_docker_container_by_name()
{
  [ "$#" -eq 1 ] || die "params error"
  _container_name="$1"

	log_info "start stop_old_container..."
	#docker ps -a --filter ancestor="${_image_name}" --filter name="${_container_name}$" | grep "${_container_name}" || {
	docker ps -a --filter name="${_container_name}$" | grep "${_container_name}" || {
		log_info "cannot find container, no need to stop old container."
		return 0
	}

	docker ps --filter name="${_container_name}$" | grep "${_container_name}" && {
        docker stop "${_container_name}"

	    sleep "${TIMEOUT_STOP_CONTAINER}"
	    docker ps --filter name="${_container_name}$" | grep "${_container_name}" && log_warn "docker stop timeout"
    }

	docker rm -f "${_container_name}"
}
