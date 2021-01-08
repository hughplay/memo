# docker build over a proxy
docker build --build-arg http_proxy=http://10.61.2.216:8001 --build-arg https_proxy=http://10.61.2.216:8001 -t <tag> .
