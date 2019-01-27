ARG ROOTFS_IMAGE=scratch
FROM ${ROOTFS_IMAGE} as rootfs


FROM ubuntu:18.04 as kernel

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    linux-image-virtual


FROM alpine:3.8

RUN apk add --no-cache \
	bash \
	e2fsprogs \
	qemu-img \
	qemu-system-x86_64

ENV CHROOT /rootfs
ENV KERNEL /boot/vmlinuz

ENV MEM 2G
ENV HDA_RAW /hda.img
ENV HDA_QCOW2 /hda.qcow2
ENV HDA_SIZE +500m

COPY create-image.sh .
COPY extract-tar.sh .
COPY entrypoint.sh .
COPY qemu.sh .

COPY --from=kernel /boot/vmlinuz-*-generic $KERNEL
COPY --from=rootfs / /rootfs

ENTRYPOINT [ "./entrypoint.sh" ]
