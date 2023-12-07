FROM alpine:3.15
ENV RADKIT_SERVICE_SUPERADMIN_PASSWORD_BASE64="put_encrypted_superadmin_pw_here"
RUN apk add python3 python3-dev py3-pip gcc psutils ethtool psutils-dev musl-dev linux-headers --update-cache 
ADD http://serverwithpipinstaller/cisco_radkit_1.5.10_pip_linux.tgz /tmp/
RUN tar zxvf /tmp/cisco_radkit_1.5.10_pip_linux.tgz
RUN rm /tmp/cisco_radkit_1.5.10_pip_linux.tgz
RUN python3 -m pip install -U pip
RUN python3 -m pip install -U -f . cisco_radkit_service
RUN *.whl
RUN /usr/bin/radkit-service bootstrap
EXPOSE 8081
ENTRYPOINT ["/usr/bin/radkit-service", "run", "--headless"]