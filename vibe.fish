function vibe
    mkdir -p $HOME/.config/vibe
    docker run --rm -it \
        -u (id -u):(id -g) \
        -e TERM=$TERM \
        -e HOME=/home/vibe \
        -e VIBE_CONFIG_DIR=/home/vibe/.vibe \
        -v (pwd):/app \
        -v $HOME/.config/vibe:/home/vibe/.vibe \
        -w /app \
        --network host \
        ghcr.io/sniner/mistral-vibe-docker:latest $argv
end
