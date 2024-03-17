check_var()
{
  _var_name="$1"
  [ -n "$(eval echo "$(echo \$${_var_name})")" ] || {
      CHECK_OK=false
      log_info "check var failed: ${_var_name}"
    }
}

check_file_existed_with_timeout()
{
  _file_path="$1"
  _timeout="$2"

  [ -n "${_timeout}" ] || _timeout=3

  if [ "${_timeout}" -le 0 ]; then
    _flag=0
    while true; do
      if [ -f "${_file_path}" ]; then
        break
      else
        log_info "file not existed: ${_flag}, _timeout: ${_timeout}: no timeout"
        _flag=$((${_flag} + 1))
        sleep 1
      fi
    done
  else
    _flag=0
    while [ "${_flag}" -le "${_timeout}" ]; do
      if [ -f "${_file_path}" ]; then
        break
      else
        log_info "file not existed: ${_flag}, _timeout: ${_timeout}"
        _flag=$((${_flag} + 1))
        sleep 1
      fi
    done

    [ "${_flag}" -lt "${_timeout}" ] || die "cannot find file until timeout"
  fi
}

check_pkg() {
    _pkg="$1"
    command -v ${_pkg} > /dev/null || die "cannot find pkg: ${_pkg}"
}

check_deps() {
    check_pkg "docker"
    check_pkg "docker-compose"
}
