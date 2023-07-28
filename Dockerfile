FROM ghcr.io/minchinweb/python:3.11

COPY ddns.py ./

COPY requirements.txt ./
# base image should have turned off pip caching
RUN pip install -r requirements.txt

# these are provided by the build hook when run on Docker Hub
ARG BUILD_DATE="1970-01-01T00:00:00Z"
ARG COMMIT="local-build"
ARG URL="https://github.com/MinchinWeb/docker-ddns"
ARG BRANCH="none"

LABEL maintainer="MinchinWeb" \
      org.label-schema.description="Dynamic DNS Updater" \
      org.label-schema.build-date=${BUILD_DATE} \
      org.label-schema.vcs-url=${URL} \
      org.label-schema.vcs-ref=${COMMIT} \
      org.label-schema.schema-version="1.0.0-rc1"

# RUN export DDNS_VERSION="$(grep -oP '__version__\s+=\s+\"?\K[\d\w\.]+' ./ddns.py)"

# CMD [ "/bin/bash", "-c", "printenv", ">", "/etc/environment", "&&", "python", "./ddns.py" ]
CMD [ "python", "./ddns.py" ]
