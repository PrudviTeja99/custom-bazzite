    # TODO: pin chunkah image to hash once mature enough
    # You may run into space issues on github runenrs as we are making a
    # complete copy of the image
    #
    # `podman inspect` emits a full image JSON payload; passing that through the
    # environment can overflow the runner's exec/env limit. We only need the image
    # config object for chunkah, so trim it down before exporting it.
    export CHUNKAH_CONFIG_STR=$(podman inspect "${target_image}" | jq -c '.[0].Config')
    podman run --rm --mount=type=image,src="${target_image}",target=/chunkah \
    -e CHUNKAH_CONFIG_STR quay.io/coreos/chunkah:latest \
    build \
    --verbose \
    --compressed \
    --max-layers 128 \
    --prune /sysroot/ \
    --label ostree.commit- --label ostree.final-diffid- \
    --tag "${target_image}:${tag}" | podman load
