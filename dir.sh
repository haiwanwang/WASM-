#!/bin/bash

HOST_ROOT=${HOST_ROOT:-$(cd "$(dirname "${BASH_SOURCE:-$0}")" && pwd)}
__run_sh__base_path="$(dirname "$(realpath --logical "${BASH_SOURCE[0]}")")"

echo ${HOST_ROOT}
echo ${__run_sh__base_path}