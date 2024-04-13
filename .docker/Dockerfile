FROM ubuntu:22.04

ENV TZ=UTC

ARG NONROOT_USERNAME
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ARG NONROOT_PROJ_DATA_DIR_BASE

ARG EDK2_REPO_URL
ARG EDK2_REPO_TAG
ARG EDK2_REPO_PATH

ARG GCC_REPO_URL
ARG GCC_REPO_TAG
ARG GCC_REPO_PATH

ARG BINUTILS_REPO_URL
ARG BINUTILS_REPO_TAG
ARG BINUTILS_REPO_PATH

ARG KERNEL_TOOLCHAIN_PREFIX

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    sudo \
    nano \
    build-essential \
    gcc \
    git \
    nasm \
    python3 \
    python-is-python3 \
    uuid-dev \
    iasl \
    ca-certificates \
    mtools \
    genisoimage \
    bison \
    flex \
    texinfo \
    wget \
    libgmp3-dev \
    libmpfr-dev \
    libmpc-dev \
    ca-certificates \
    xxd \
    --no-install-recommends

RUN groupadd --gid $USER_GID $NONROOT_USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $NONROOT_USERNAME \
    && echo $NONROOT_USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$NONROOT_USERNAME \
    && chmod 0440 /etc/sudoers.d/$NONROOT_USERNAME

RUN mkdir -p $NONROOT_PROJ_DATA_DIR_BASE && \
    chown $NONROOT_USERNAME:$NONROOT_USERNAME $NONROOT_PROJ_DATA_DIR_BASE
USER $NONROOT_USERNAME

# bootloader
COPY bootloader/environment-prep/edk2-setup.sh /tmp/edk2-setup.sh
RUN /tmp/edk2-setup.sh

# kernel
COPY kernel/environment-prep/download-repos.sh /tmp/download-repos.sh
RUN /tmp/download-repos.sh

COPY kernel/environment-prep/tool-chain.sh /tmp/tool-chain.sh
RUN /tmp/tool-chain.sh

CMD [ "/bin/bash" ]