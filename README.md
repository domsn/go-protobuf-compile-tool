## Protobuf Compile Tool For Golang

### Setting

```
# WORKDIR
/build
```

### Usage

```
# SRC_DIR is source directory, including dependency proto file
# DST_DIR is proto generate file destination directory
docker run -it -v=`pwd`:/build domsn/go-protobuf-compile-tool:latest sh -c "protoc -I=$SRC_DIR --go_out=plugins=grpc:$DST_DIR [$SRC_DIR/]api.proto"
```

> example

```
docker run -it -v=`pwd`:/build domsn/go-protobuf-compile-tool:latest sh -c "protoc -I=./api/protobuf-spec --go_out=plugins=grpc:internal/pkg/grpc ./api/protobuf-spec/api.proto"

docker run -it -v=`pwd`:/build domsn/go-protobuf-compile-tool:latest sh -c "protoc -I=./api/protobuf-spec --go_out=plugins=grpc:internal/pkg/grpc api.proto"
```

### Version

| Tag                   | Golang version | Protobuf version |
| --------------------- | -------------- | ---------------- |
| latest                | 1.13.8         | 3.11.4           |
| go1.13.8-protoc3.11.4 | 1.13.8         | 3.11.4           |
