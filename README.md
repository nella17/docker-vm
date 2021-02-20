# vm-docker

## Usage Example

```shell
#!/bin/zsh

name="vm_$(pwd | sha1)"
cmd="zsh"
if [ $# -gt 0 ]; then
  cmd="$@"
fi

docker run --rm -dt \
  --name $name \
  -v "$PWD:/data" \
  --cap-add=SYS_PTRACE \
  --security-opt seccomp=unconfined \
  nella17/vm &> /dev/null
docker exec -it -w '/data' $name zsh -c "source ~/.zshrc && $cmd"
docker stop $name >/dev/null &
```
