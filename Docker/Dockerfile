FROM debian:bullseye

RUN apt update && apt install -y usbutils net-tools curl snmp snmpd jq cron \
  && mkdir /app

COPY . /app
WORKDIR /app
CMD ["/bin/bash"]
