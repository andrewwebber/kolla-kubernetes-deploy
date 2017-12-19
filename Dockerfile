FROM centos:latest
RUN yum update -y
RUN yum install -y epel-release python-pip python-devel python-devel libffi-devel openssl-devel gcc git ntp vim ansible==2.2.0 wget
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && python get-pip.py
RUN curl -sSL https://get.docker.io
RUN bash && pip install -U ansible==2.2.0
RUN wget https://storage.googleapis.com/kubernetes-release/release/v1.7.0/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin
RUN mkdir kolla-bringup && cd kolla-bringup && \
    git clone http://github.com/openstack/kolla-ansible && \
    git clone http://github.com/openstack/kolla-kubernetes && \
    pip install -U kolla-ansible/ kolla-kubernetes/ && \
    cp -aR /usr/share/kolla-ansible/etc_examples/kolla /etc && \
    cp -aR kolla-kubernetes/etc/kolla-kubernetes /etc && \
    kolla-kubernetes-genpwd
COPY ./config.sh /tmp/config.sh
RUN chmod +x /tmp/config.sh
RUN bash && /tmp/config.sh

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["bash"]
