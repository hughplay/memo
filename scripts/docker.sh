# docker build over a proxy
docker build --build-arg http_proxy=http://127.0.0.1:8001 --build-arg https_proxy=http://127.0.0.1:8001 -t <tag> .
