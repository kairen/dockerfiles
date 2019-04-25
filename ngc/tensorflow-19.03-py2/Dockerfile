FROM nvcr.io/nvidia/tensorflow:19.03-py2

WORKDIR /workspace
ENV NOTVISIBLE "in users profile"

RUN apt-get update && apt-get install -y supervisor openssh-server && \
  apt-get clean
RUN mkdir -p /var/log/supervisor /var/run/sshd && \ 
  echo 'root:r00tme' | chpasswd && \
  sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
  echo "export VISIBLE=now" >> /etc/profile

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY run_jupyter.sh /run_jupyter.sh
COPY jupyter_notebook_config.py /root/.jupyter/

EXPOSE 22
EXPOSE 8888
EXPOSE 6006

ENTRYPOINT ["/usr/bin/supervisord"]