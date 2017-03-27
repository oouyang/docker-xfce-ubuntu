# docker-xfce-ubuntu
```
docker run -ti --rm \
           --net=host \
           -e DISPLAY=$DISPLAY \
           -v ~/.Xauthority:/root/.Xauthority \
           -v /tmp/.X11-unix:/tmp/.X11-unix \
           quay.io/alaska/xfce-ubuntu
```
