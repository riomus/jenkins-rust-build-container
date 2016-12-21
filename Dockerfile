FROM evarga/jenkins-slave

RUN   apt-get -yqq update && apt-get install -y --force-yes \
      build-essential cmake git curl vim strace gdb libssl-dev wget libpcre3-dev&& \
      apt-get autoremove -y && apt-get clean

RUN echo 'root:rust' | chpasswd

USER jenkins
ADD ./assets/rustup_install.sh /rustup_install.sh

RUN sh /rustup_install.sh -y
RUN echo "source ~/.cargo/env">>~/.bashrc

RUN echo 'source ~/.cargo/env && rustup default nightly' | bash 

USER root

RUN chsh -s /bin/bash jenkins