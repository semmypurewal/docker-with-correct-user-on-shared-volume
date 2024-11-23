FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN userdel -r ubuntu 2>/dev/null

RUN apt-get update && apt-get install -y \
    gosu \
    && rm -rf /var/lib/apt/lists/*


COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod 700 /usr/local/bin/entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["bash"]
