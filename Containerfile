FROM docker.io/library/fedora:latest
LABEL com.github.containers.toolbox="true" \
      name="goose-toolbox" \
      version="base" \
      usage="This image is meant to be used within goose linux" \
      summary="default image run in goose linux toolboxes" \
      maintainer="givensuman <givensuman@duck.com>"

COPY build.sh /
RUN chmod +x /build.sh;
RUN /build.sh;

RUN dnf5 clean all;
