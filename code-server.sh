docker run -d \
  --name=code-server \
  -e PUID=1000 \
  -e PGID=1000 \
  -e TZ=Asia/Seoul \
  -e PASSWORD="$password" \
  -p 80:8443 \
  --restart unless-stopped \
  ghcr.io/linuxserver/code-server
