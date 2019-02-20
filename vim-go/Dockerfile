FROM ubuntu:16.04
LABEL maintainer="Kyle Bai <k2r2.bai@gmail.com>"

ENV LANG en_US.UTF-8
ENV GOVERSION 1.10.2
ENV GOROOT /usr/local/go
ENV GOPATH "$HOME/go"
WORKDIR /root

RUN apt-get update && \
  apt-get install -y software-properties-common && \ 
  add-apt-repository -yu ppa:jonathonf/vim && \
  apt-get install -y vim python python-dev python3-dev wget curl zsh git build-essential cmake && \
  wget https://storage.googleapis.com/golang/go${GOVERSION}.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go${GOVERSION}.linux-amd64.tar.gz && \
  rm -rf go${GOVERSION}.linux-amd64.tar.gz && \
  wget -qO- https://kubernetes-helm.storage.googleapis.com/helm-v2.9.1-linux-amd64.tar.gz | tar -zx && \
  mv linux-amd64/helm /usr/local/bin/ && \
  rm -rf linux-amd64 && \
  curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.11.0/bin/linux/amd64/kubectl && \
  chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl && \
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && \
  git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh && \
  chsh -s /bin/zsh
  
COPY .zshrc /root/
COPY .vimrc /root/

RUN export GOROOT=/usr/local/go && \
  export GOPATH=$HOME/go && \
  export PATH=$PATH:$GOROOT/bin:$GOPATH/bin && \
  vim +PluginInstall +qall && \
  cd ~/.vim/bundle/YouCompleteMe && \
  ./install.py --go-completer && \
  sed -i "s/\"colorscheme/colorscheme/g" ~/.vimrc && \
  go get -u github.com/kardianos/govendor && \
  go get github.com/zmb3/gogetdoc && \
  go get golang.org/x/tools/cmd/guru && \
  go get github.com/golang/lint/golint && \
  go get github.com/davidrjenni/reftools/cmd/fillstruct && \
  go get github.com/rogpeppe/godef && \
  go get github.com/kisielk/errcheck && \
  go get github.com/derekparker/delve/cmd/dlv && \
  go get github.com/jstemmer/gotags && \
  go get golang.org/x/tools/cmd/goimports && \
  go get github.com/dominikh/go-tools/cmd/keyify && \
  go get golang.org/x/tools/cmd/gorename && \
  go get github.com/klauspost/asmfmt/cmd/asmfmt && \
  go get github.com/alecthomas/gometalinter && \
  go get github.com/fatih/motion && \
  go get github.com/nsf/gocode && \
  go get github.com/josharian/impl && \
  go get github.com/koron/iferr && \
  go get github.com/fatih/gomodifytags && \
  apt-get purge -y software-properties-common gcc g++ && \
  apt-get autoremove -y && \
  apt-get clean && \ 
  rm -rf $GOPATH/src/ && \
  rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/kubernetes-sigs/kustomize/releases/download/v1.0.3/kustomize_1.0.3_linux_amd64 && \
  chmod +x ./kustomize_1.0.3_linux_amd64 && mv ./kustomize_1.0.3_linux_amd64 /usr/local/bin/kustomize 

ENTRYPOINT ["/bin/zsh"]