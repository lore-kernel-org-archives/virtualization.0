From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [GIT PULL v2] vhost: cleanups and fixes
Date: Mon, 20 Apr 2020 16:00:01 -0400
Message-ID: <20200420160001-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, alexander.h.duyck@linux.intel.com, arnd@arndb.de, bjorn.andersson@linaro.org, eli@mellanox.com, eperezma@redhat.com, gustavo@embeddedor.com, hulkci@huawei.com, jasowang@redhat.com, mst@redhat.com, sfr@canb.auug.org.au, yanaijie@huawei.com, yuehaibing@huawei.com
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to d085eb8ce727e581abf8145244eaa3339021be2f:

  vhost: disable for OABI (2020-04-20 10:19:22 -0400)

Changes from v1:
	Dropped a bunch of cleanups which turned out to be controversial

This has been in next for a while, though I tweaked some commit
logs so the hashes differ.

----------------------------------------------------------------
virtio: fixes, cleanups

Some bug fixes.
Cleanup a couple of issues that surfaced meanwhile.
Disable vhost on ARM with OABI for now - to be fixed
fully later in the cycle or in the next release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Alexander Duyck (1):
      virtio-balloon: Avoid using the word 'report' when referring to free page hinting

Eugenio Pérez (1):
      vhost: Create accessors for virtqueues private_data

Gustavo A. R. Silva (1):
      vhost: vdpa: remove unnecessary null check

Jason Wang (1):
      vdpa: fix comment of vdpa_register_device()

Jason Yan (2):
      vhost: remove set but not used variable 'status'
      virtio-balloon: make virtballoon_free_page_report() static

Michael S. Tsirkin (15):
      vdpa-sim: depend on HAS_DMA
      virtio/test: fix up after IOTLB changes
      tools/virtio: define aligned attribute
      tools/virtio: make asm/barrier.h self contained
      virtgpu: pull in uaccess.h
      virtio-rng: pull in slab.h
      remoteproc: pull in slab.h
      virtio_input: pull in slab.h
      rpmsg: pull in slab.h
      remoteproc: pull in slab.h
      vdpa: allow a 32 bit vq alignment
      vdpa: make vhost, virtio depend on menu
      virtio_blk: add a missing include
      virtio: drop vringh.h dependency
      vhost: disable for OABI

Stephen Rothwell (1):
      drm/virtio: fix up for include file changes

YueHaibing (2):
      vdpa: remove unused variables 'ifcvf' and 'ifcvf_lm'
      vdpasim: Return status in vdpasim_get_status

 drivers/block/virtio_blk.c             |  1 +
 drivers/char/hw_random/virtio-rng.c    |  1 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c |  1 +
 drivers/gpu/drm/virtio/virtgpu_kms.c   |  1 +
 drivers/misc/mic/Kconfig               |  2 +-
 drivers/net/caif/Kconfig               |  2 +-
 drivers/remoteproc/remoteproc_sysfs.c  |  1 +
 drivers/remoteproc/stm32_rproc.c       |  1 +
 drivers/rpmsg/mtk_rpmsg.c              |  1 +
 drivers/vdpa/Kconfig                   | 18 ++++++------------
 drivers/vdpa/ifcvf/ifcvf_base.c        |  2 --
 drivers/vdpa/ifcvf/ifcvf_main.c        |  4 +---
 drivers/vdpa/vdpa.c                    |  2 +-
 drivers/vdpa/vdpa_sim/vdpa_sim.c       |  4 ++--
 drivers/vhost/Kconfig                  | 21 ++++++++++++++++-----
 drivers/vhost/net.c                    | 28 +++++++++++++++-------------
 drivers/vhost/scsi.c                   | 14 +++++++-------
 drivers/vhost/test.c                   | 14 +++++++-------
 drivers/vhost/vdpa.c                   |  5 -----
 drivers/vhost/vhost.h                  | 27 +++++++++++++++++++++++++++
 drivers/vhost/vringh.c                 |  5 +++++
 drivers/vhost/vsock.c                  | 14 +++++++-------
 drivers/virtio/Kconfig                 |  2 +-
 drivers/virtio/virtio_balloon.c        |  4 ++--
 drivers/virtio/virtio_input.c          |  1 +
 include/linux/vdpa.h                   |  2 +-
 include/linux/virtio.h                 |  1 -
 include/linux/vringh.h                 |  6 ++++++
 include/uapi/linux/virtio_balloon.h    | 11 +++++++++--
 tools/virtio/Makefile                  |  5 +++--
 tools/virtio/asm/barrier.h             |  1 +
 tools/virtio/generated/autoconf.h      |  0
 tools/virtio/linux/compiler.h          |  1 +
 33 files changed, 128 insertions(+), 75 deletions(-)
 create mode 100644 tools/virtio/generated/autoconf.h
