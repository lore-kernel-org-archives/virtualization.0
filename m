From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 00/22] New virtio PCI layout
Date: Thu, 21 Mar 2013 18:59:21 +1030
Message-ID: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

I've renewed this again, with some comments from HPA.  I've tried to
keep the new patches separate, so you can see the changes since we
last discussed this (and so it's easy to back it out if we decide it's
insane).

I haven't even looked at the QEMU side so this is completely untested.

Comments gratefully received!
Rusty.

Michael S Tsirkin (1):
  pci: add pci_iomap_range

Rusty Russell (21):
  virtio_config: introduce size-based accessors.
  virtio_config: use size-based accessors.
  virtio_config: make transports implement accessors.
  virtio: use u32, not bitmap for struct virtio_device's features
  virtio: add support for 64 bit features.
  virtio: move vring structure into struct virtqueue.
  virtio-pci: define layout for virtio vendor-specific capabilities.
  virtio_pci: move old defines to legacy, introduce new structure.
  virtio_pci: use _LEGACY_ defines in virtio_pci_legacy.c
  virtio_pci: don't use the legacy driver if we find the new PCI
    capabilities.
  virtio_pci: allow duplicate capabilities.
  virtio_pci: new, capability-aware driver.
  virtio_pci: layout changes as per hpa's suggestions.
  virtio_pci: use little endian for config space.
  virtio_pci: use separate notification offsets for each vq.
  virtio_pci_legacy: cleanup struct virtio_pci_vq_info
  virtio_pci: share structure between legacy and modern.
  virtio_pci: share interrupt/notify handlers between legacy and
    modern.
  virtio_pci: share virtqueue setup/teardown between modern and legacy
    driver.
  virtio_pci: simplify common helpers.
  virtio_pci: fix finalize_features in modern driver.

 drivers/block/virtio_blk.c             |   77 ++--
 drivers/char/virtio_console.c          |   17 +-
 drivers/lguest/lguest_device.c         |   89 +++-
 drivers/net/caif/caif_virtio.c         |   25 +-
 drivers/net/virtio_net.c               |   28 +-
 drivers/remoteproc/remoteproc_virtio.c |    8 +-
 drivers/s390/kvm/kvm_virtio.c          |   88 +++-
 drivers/s390/kvm/virtio_ccw.c          |   39 +-
 drivers/scsi/virtio_scsi.c             |   12 +-
 drivers/virtio/Kconfig                 |   12 +
 drivers/virtio/Makefile                |    3 +-
 drivers/virtio/virtio.c                |   18 +-
 drivers/virtio/virtio_balloon.c        |   10 +-
 drivers/virtio/virtio_mmio.c           |   55 ++-
 drivers/virtio/virtio_pci-common.c     |  395 ++++++++++++++++
 drivers/virtio/virtio_pci-common.h     |  121 +++++
 drivers/virtio/virtio_pci.c            |  777 ++++++++++++--------------------
 drivers/virtio/virtio_pci_legacy.c     |  481 ++++++++++++++++++++
 drivers/virtio/virtio_ring.c           |  116 ++---
 include/asm-generic/pci_iomap.h        |    5 +
 include/linux/virtio.h                 |   11 +-
 include/linux/virtio_config.h          |  205 +++++++--
 include/linux/virtio_pci.h             |   35 ++
 include/uapi/linux/virtio_config.h     |    2 +
 include/uapi/linux/virtio_pci.h        |  111 ++++-
 lib/pci_iomap.c                        |   46 +-
 net/9p/trans_virtio.c                  |    9 +-
 tools/virtio/linux/virtio.h            |   22 +-
 tools/virtio/linux/virtio_config.h     |    2 +-
 tools/virtio/virtio_test.c             |    5 +-
 tools/virtio/vringh_test.c             |   16 +-
 31 files changed, 2018 insertions(+), 822 deletions(-)
 create mode 100644 drivers/virtio/virtio_pci-common.c
 create mode 100644 drivers/virtio/virtio_pci-common.h
 create mode 100644 drivers/virtio/virtio_pci_legacy.c
 create mode 100644 include/linux/virtio_pci.h

-- 
1.7.10.4
