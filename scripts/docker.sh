# docker pull proxy
# https://docs.docker.com/engine/reference/commandline/pull/#proxy-configuration

# docker build over a proxy
docker build --build-arg http_proxy=http://127.0.0.1:8001 --build-arg https_proxy=http://127.0.0.1:8001 -t <tag> .
# docker compose: build -> args

# export and import docker image
# https://stackoverflow.com/questions/23935141/how-to-copy-docker-images-from-one-host-to-another-without-using-a-repository
docker save -o <xxx.tar> <image name>
docker load -i <xxx.tar>

# make container keep running, Dockerfile:
CMD ['sleep', 'infinity']
# docker compose
command ['sleep', 'infinity']
