FROM docker.io/library/fedora:latest
LABEL com.github.containers.toolbox="true" \
      name="dune-toolbox" \
      version="base" \
      usage="This image is meant to be used within Dune OS" \
      summary="Default image run in Dune OS toolboxes" \
      maintainer="givensuman <givensuman@duck.com>"

COPY /scripts/build.sh /
RUN chmod +x /build.sh;
RUN /build.sh;

RUN dnf5 clean all;
