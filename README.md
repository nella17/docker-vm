# vm-docker

## Usage Example

filename: `vm` `vm-{tag}`

```shell
#!/bin/bash

docker ps > /dev/null || exit -1

version=$(basename $0)
version=${version#vm}
version=${version#-}
if [ ! $version ]; then
  version='latest'
fi

name="vm_${version}_$(pwd | sha1sum | awk '{print $1}')"
cmd="zsh"
if [ $# -gt 0 ]; then
  cmd="$@"
fi

docker run --rm -dt \
  --name $name \
  -v "$PWD:/data" \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  nella17/vm:$version &> /dev/null
docker exec -it -w '/data' $name zsh -c "source ~/.zshrc && $cmd"
docker stop $name >/dev/null &
```
