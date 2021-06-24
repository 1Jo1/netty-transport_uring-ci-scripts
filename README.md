# Automated testing of Netty's `io_uring` support

### Kernel Mainline
[![mainline](https://gitlab.com/netty-io_uring/linux-stable/-/jobs/1373030751/artifacts/raw/badge.svg)](https://gitlab.com/netty-io_uring/linux-stable/-/pipelines/1373030751)

### Kernel Stable
[![stable](https://gitlab.com/netty-io_uring/linux-stable/-/jobs/1372817108/artifacts/raw/badge.svg)](https://coveralls.io/github/yuin/goldmark)

### Kernel LTS
[![lts](https://gitlab.com/netty-io_uring/linux-stable/-/jobs/1372828353/artifacts/raw/badge.svg)](https://coveralls.io/github/yuin/goldmark)

To make [Netty's io_uring support](https://github.com/netty/netty-incubator-transport-io_uring) more reliable, I created a [Linux stable repo](https://gitlab.com/netty-io_uring/linux-stable) on GitLab to [trigger automatic tests](https://gitlab.com/netty-io_uring/linux-stable/-/pipelines). Whenever there's a new (Git) tagged version in Linux, the following steps will run:

1. Build a kernel image
2. Start `QEMU` VM on that image
3. Run [Netty's io_uring tests](https://github.com/netty/netty-incubator-transport-io_uring/tree/main/src/test/java/io/netty/incubator/channel/uring)

## Roadmap

- [x] Add x86_64 netty test pipeline
- [ ] Add aarch64 netty test pipeline
- [ ] Run pipelines in parallel
- [ ] Integrate with Netty's io_uring repo

## Why GitLab?

GitHub Actions currently requires the configuration file to live in the same repository as the project being tested, it's not suitable for mirrored repositories. GitLab CI/CD, on the other hand, allows external configuration files such as [the one hosted in this repository](https://gitlab.com/netty-io_uring/linux-stable).