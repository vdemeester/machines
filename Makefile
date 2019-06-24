# Build images
images/fedora-30.qcow2: images
	virt-builder fedora-30 --update \
		--root-password file:assets/fedora_pw \
		--size=30G --format=qcow2 --output images/fedora-30.qcow2

images/ubuntu-1804.qcow2: images
	virt-builder ubuntu-18.04 \
		--root-password file:assets/ubuntu_pw \
		--size=30G --format=qcow2 --output images/ubuntu-1804.qcow2

images:
	mkdir -p images

# Copy to hosts

# Create hosts