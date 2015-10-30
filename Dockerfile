FROM ubuntu:15.10

MAINTAINER Jeff Gregory <jeffmgreg@gmail.com>

RUN apt-get update && apt-get install -y \
	ack-grep bzr cmake     \
	curl g++ git make      \
	man-db mercurial       \
	ncurses-dev nodejs     \
	npm procps python-dev  \
	python-pip ssh         \
	sudo unzip vim         \
	xz-utils ipython       \
	fontconfig

# ========================================================================
# ---------
# VIM Setup
# ---------


RUN mkdir -p ~/.fonts ~/.config/fontconfig/conf.d
RUN wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf -O ~/.fonts/PowerlineSymbols.otf
RUN wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf -O ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
RUN fc-cache -r ~/.fonts

RUN git clone https://github.com/gmarik/Vundle.vim.git /root/.vim/bundle/Vundle.vim
RUN git clone https://github.com/Valloric/YouCompleteMe.git /root/.vim/bundle/YouCompleteMe
RUN cd /root/.vim/bundle/YouCompleteMe          && \
	git submodule update --init --recursive && \
 	./install.sh --clang-completer

COPY vimrc /root/.vimrc
RUN vim +PluginInstall  +qall
RUN vim +GoInstallBinaries +qall
# ========================================================================

# Change timezone
RUN ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
COPY bashrc /root/.bashrc

WORKDIR /go/src
CMD ["/bin/bash"]

# Run Docker with
# sudo docker run -i -t -v ~/workspace/src:/go/src testing2
