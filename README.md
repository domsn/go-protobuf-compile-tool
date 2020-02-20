## Protobuf Compile Tool For Golang

```bash
# latest version
docker pull domsn/go-protobuf-compile-tool:latest

# workdir
/build

# example
docker run -it -v=`pwd`:/build domsn/go-protobuf-compile-tool:latest sh -c "protoc -I=./api/protobuf-spec --go_out=plugins=grpc:internal/pkg/grpc api.proto"
```
