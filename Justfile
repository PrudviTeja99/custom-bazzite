    # TODO: pin chunkah image to hash once mature enough
    # You may run into space issues on github runenrs as we are making a
    # complete copy of the image
    #
    # `podman inspect` on a full image can produce a very large JSON payload. Passing
    # the full inspect result through environment variables exceeds the runner's
    # argument/environment limit, which triggers "Argument list too long".
    # Restrict the payload to the image config JSON that chunkah actually needs.
    export CHUNKAH_CONFIG_STR=$(podman inspect --type image --format '{{json .Config}}' "${target_image}")
    podman run --rm --mount=type=image,src="${target_image}",target=/chunkah \
    -e CHUNKAH_CONFIG_STR quay.io/coreos/chunkah:latest \
    build \
    --verbose \
    --compressed \
    --max-layers 128 \
    --prune /sysroot/ \
    --label ostree.commit- --label ostree.final-diffid- \
    --tag "${target_image}:${tag}" | podman load
