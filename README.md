# qemu-rootfs

Dockerized QEMU that boots an extracted Linux rootfs.

## Development

Build Docker image.

```sh
$ docker build --tag qemu-rootfs .
```

## Usage

### Designated volume paths

There a few special designated paths that may be mounted over to add files to the guest root file system.

* `/rootfs`: The root file system that will be partitioned in an image.
* `/boot/vmlinuz`: The kernel used to boot the VM.

### Runtime environment configuration

* `MEM`: Guest RAM size. (default: `2G`)
* `HDA_SIZE`: Guest disk size. A static size maybe set with `5G`. Or the size of the root file system plus additional space maybe set with `+500m`. (default: `+500m`)

```sh
$ docker run --rm -it \
      --env "MEM=2G" \
      --env "HDA_SIZE=+500m" \
    qemu-rootfs
```

### debootstrap

Can be used to test rootfs created with [debootstrap](https://wiki.debian.org/Debootstrap).

```sh
$ sudo debootstrap --arch amd64 bionic /mnt/ubuntu http://archive.ubuntu.com/ubuntu/
$ echo "root:passworD1" | sudo chpasswd --root /mnt/ubuntu

$ docker run --rm -it \
      --volume "/dev/kvm:/dev/kvm" \
      --volume "/mnt/ubuntu:/rootfs:ro" \
    qemu-rootfs
```


### Ubuntu Cloud Image

```sh
$ wget http://cloud-images.ubuntu.com/releases/bionic/release/ubuntu-18.04-server-cloudimg-amd64-root.tar.xz
$ docker run --rm -it \
      --volume "$PWD/ubuntu-18.04-server-cloudimg-amd64-root.tar.xz:/rootfs.tar.xz:ro" \
    qemu-rootfs
````

### Docker multi-stage build

Can also be used a base image in a multi-stage build where a rootfs is customized.

```sh
$ docker build --tag qemu-ubuntu - <<EOF
FROM ubuntu:bionic as rootfs
RUN apt-get update && apt-get install -y curl

FROM qemu-rootfs
COPY --from=rootfs / /rootfs
EOF

$ docker run --rm -it qemu-ubuntu
```
