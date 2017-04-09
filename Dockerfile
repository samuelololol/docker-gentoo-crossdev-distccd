FROM samuelololol/docker-gentoo-websync
MAINTAINER samuelololol <samuelololol@gmail.com>
RUN emerge crossdev distcc binutils-libs
RUN mkdir -p /usr/local/portage-crossdev/{profiles,metadata} && \
    echo 'crossdev' > /usr/local/portage-crossdev/profiles/repo_name && \
    echo 'masters = gentoo' > /usr/local/portage-crossdev/metadata/layout.conf && \
    chown -R portage:portage /usr/local/portage-crossdev
RUN ( \
    echo "[crossdev]" && \
    echo "location = /usr/local/portage-crossdev" && \
    echo "priority = 10" && \
    echo "masters = gentoo" && \
    echo "auto-sync = no" \
    ) > /etc/portage/repos.conf/crossdev.conf
RUN ( \
    echo "#!/bin/sh" && \
    echo "eval \"\`gcc-config -E\`\"" && \
    echo "exec distccd \"\$@\"" \
    ) > /usr/local/sbin/distccd-launcher && \
    chmod +x /usr/local/sbin/distccd-launcher
#RUN crossdev -S -v -t armv6j-hardfloat-linux-gnueabi
#RUN rm -r /usr/portage
#CMD ["/usr/local/sbin/distccd-launcher", "--allow", "0.0.0.0/0", "--user", "distcc", "--log-level", "notice", "--log-stderr", "--no-detach"]
#EXPOSE 3632
