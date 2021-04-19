# vm-docker

## Usage Example

filename: `vm` `vm-{tag}`

```bash
#!/bin/bash

docker ps > /dev/null || exit -1

version=$(basename $0)
version=${version#vm}
version=${version#-}
if [ ! $version ]; then
  version='latest'
fi

name="vm_${version}_$(pwd | sha1sum | awk '{print $1}')"

args=()
while [[ $# -gt 0 ]]; do
  if [[ $1 == -* ]]; then
    args+=("$1 $2")
    shift
    shift
  else
    break
  fi
done
args="${args[@]}"

cmd="zsh"
if [ $# -gt 0 ]; then
  cmd="$@"
fi

>&2 echo name: $name
>&2 echo args: $args
>&2 echo cmd: $cmd

exist=$(docker ps -q -f "name=$name")
already_run=$(ps x | grep docker | grep run | grep $name | wc -l)
if [[ ! $exist ]] && [[ $already_run -eq 0 ]]; then
  >&2 echo -n 'start container: '
  docker run --rm -dt \
    --name $name \
    -v "$PWD:/data" \
    --cap-add=SYS_PTRACE \
    --security-opt seccomp=unconfined \
    $args \
    nella17/vm:$version
fi

docker exec -it -w '/data' $name zsh -c "source ~/.zshrc && $cmd"

count=$(ps x | grep docker | grep exec | grep $name | wc -l)
exist=$(docker ps -q -f "name=$name")
if [[ $count -eq 0 ]] && [[ $exist ]]; then
  >&2 echo -n 'shutdown container: '
  docker stop $name
fi
```
