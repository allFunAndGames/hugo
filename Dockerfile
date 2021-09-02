FROM alpine:latest as build

LABEL org.opencontainers.image.name="hugo GitHub Action"
LABEL org.opencontainers.image.description="GitHub Action for automated build of Hugo based static sites"
LABEL org.opencontainers.image.authors="allfun@wearehackerone.com"

# install required software packages
RUN apk add --no-cache curl jq

# add our binary and make it executable
ARG HUGO_VERSION="latest"
RUN curl -sL $(curl -sL https://api.github.com/repos/gohugoio/hugo/releases/latest | \
                jq -r '.assets[].browser_download_url' | \
                grep -E hugo_[0-9]+\.[0-9]+\.[0-9]+_Linux-64bit.tar.gz) \
                --output hugo_latest.tar.gz && \
                tar xzf hugo_latest.tar.gz && \
                rm -r hugo_latest.tar.gz && \
                mv hugo /usr/bin
               
# define the entrypoint
ENTRYPOINT ["/usr/bin/hugo"]
