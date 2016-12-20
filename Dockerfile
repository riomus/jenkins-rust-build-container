FROM evarga/jenkins-slave

RUN   apt-get -yqq update && apt-get install -y --force-yes \
      build-essential cmake git curl vim strace gdb libssl-dev wget&& \
      apt-get autoremove -y && apt-get clean


ADD ./assets/rustup_install.sh /rustup_install.sh

RUN echo 'root:rust' | chpasswd

RUN cp /etc/skel/.bash* ~
RUN sh /rustup_install.sh -y
RUN echo "source ~/.cargo/env">>~/.bashrc

RUN echo 'source ~/.cargo/env && rustup default nightly' | bash 
