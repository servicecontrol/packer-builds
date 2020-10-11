FROM hashicorp/packer:full

RUN git clone https://github.com/UpCloudLtd/upcloud-packer && cd upcloud-packer && go build && mkdir -p ~/.packer.d/plugins/ && cp upcloud-packer ~/.packer.d/plugins/packer-builder-upcloud && chmod +x ~/.packer.d/plugins/packer-builder-upcloud

COPY "entrypoint.sh" "/entrypoint.sh"

ENTRYPOINT ["/entrypoint.sh"]
