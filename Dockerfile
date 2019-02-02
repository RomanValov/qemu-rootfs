FROM alpine:3.8

RUN apk add --no-cache \
	bash \
	e2fsprogs \
	qemu-img \
	qemu-system-x86_64

ENV CHROOT /rootfs
ENV KERNEL /vmlinuz
ENV INITRD /initrd.img

ENV MEM 2G
ENV HDA_RAW /hda.img
ENV HDA_QCOW2 /hda.qcow2
ENV HDA_SIZE +500m

COPY bin/* /usr/bin/

ENTRYPOINT [ "/usr/bin/entrypoint.sh" ]
