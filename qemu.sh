#! /bin/bash

qemu() {
	qemu-system-x86_64 --kernel output/images/bzImage \
					   --hda output/images/rootfs.ext2 \
					   --append "root=/dev/sda" \
					   -net nic,model=virtio \
					   -net user \
					   -redir tcp:5556:10.0.2.15:22
}

gdb() {
	qemu-system-x86_64 -s -S \
                       --kernel output/images/bzImage \
					   --hda output/images/rootfs.ext2 \
					   --append "root=/dev/sda" \
					   -net nic,model=virtio \
					   -net user \
					   -redir tcp:5556:10.0.2.15:22
}

while true; do
    case "$1" in
        -r|--run) qemu; exit 0;;
        -d|--debug) gdb; exit 0;;
        --) shift; break;;
    esac
    shift
done
