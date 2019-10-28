FROM hashicorp/packer:light

LABEL "com.github.actions.name"="packer+ansible action"
LABEL "com.github.actions.description"="packer with ansible provisioner support"
LABEL "com.github.actions.icon"="hash"
LABEL "com.github.actions.color"="green"

LABEL "repository"="kologicdev/github-action-get-packer-ansible"
LABEL "homepage"="kologicdev/github-action-get-packer-ansible"
LABEL "maintainer"="Stepan <kologicdev@icloud.com>"
LABEL "version"="0.0.1"

RUN apk add --no-cache --virtual .run-deps \
       python2 \
       openssh \
    && apk add --no-cache --virtual .build-deps \
        alpine-sdk \
        py-setuptools \
        libffi-dev \
        python2-dev \
        openssl-dev \
    && easy_install-2.7 pip \
    && pip install ansible \
    && apk --purge del .build-deps \
    && rm -rf /var/cache/apk /root/.cache \
    && adduser -D packer

USER packer
ENV USER=packer
ENV HOME=/home/packer
WORKDIR /home/packer

ENTRYPOINT ["bin/packer"]
