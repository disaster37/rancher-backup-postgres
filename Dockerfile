FROM postgres:latest
MAINTAINER Sebastien LANGOUREAUX <linuxworkgroup@hotmail.com>


# Add python and cron to manage backup
RUN apt-get update && \
    apt-get install -y curl python vim python-pip duplicity ncftp python-paramiko python-gobject-2 python-boto

RUN pip install rancher_metadata

COPY assets/init.py /app/init.py
COPY assets/run /app/run
RUN chmod +x /app/run



# CLEAN APT
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


VOLUME ["/backup/postgres"]
CMD ["/app/run"]
