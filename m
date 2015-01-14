From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 00/16] virtio-pci: towards virtio 1.0 guest support
Date: Wed, 14 Jan 2015 19:27:22 +0200
Message-ID: <1421256142-11512-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Changes since v2:
	handling for devices without config space (e.g. rng)
	reduce # of mappings for VQs

These patches seem to work fine on my virtio-1.0 qemu branch.
There haven't been any bugs since v2: just minor cleanups
and enhancements.
QEMU side is still undergoing polishing, but is already testable.

Rusty, what do you think?  Let's merge these for 3.20?
Also - will you be doing that merge window, or should I?

Michael S. Tsirkin (14):
  virtio_pci: drop virtio_config dependency
  virtio/9p: verify device has config space
  virtio/blk: verify device has config space
  virtio/console: verify device has config space
  virtio/net: verify device has config space
  virtio/scsi: verify device has config space
  virtio/balloon: verify device has config space
  mn10300: drop dead code
  pci: add pci_iomap_range
  s390: add pci_iomap_range
  virtio_pci: move probe/remove code to common
  virtio_pci: modern driver
  virtio_pci_modern: reduce number of mappings
  virtio_pci_modern: support devices with no config

Rusty Russell (2):
  virtio-pci: define layout for virtio 1.0
  virtio_pci: macros for PCI layout offsets

 arch/s390/include/asm/pci_io.h        |   1 +
 drivers/virtio/virtio_pci_common.h    |  33 +-
 include/asm-generic/pci_iomap.h       |  10 +
 include/uapi/linux/virtio_pci.h       |  94 ++++-
 arch/mn10300/unit-asb2305/pci-iomap.c |  35 --
 arch/s390/pci/pci.c                   |  34 +-
 drivers/block/virtio_blk.c            |   6 +
 drivers/char/virtio_console.c         |   6 +
 drivers/net/virtio_net.c              |   6 +
 drivers/scsi/virtio_scsi.c            |   6 +
 drivers/virtio/virtio_balloon.c       |   6 +
 drivers/virtio/virtio_pci_common.c    |  79 +++-
 drivers/virtio/virtio_pci_legacy.c    |  76 +---
 drivers/virtio/virtio_pci_modern.c    | 706 ++++++++++++++++++++++++++++++++++
 lib/pci_iomap.c                       |  35 +-
 net/9p/trans_virtio.c                 |   6 +
 drivers/virtio/Makefile               |   2 +-
 17 files changed, 1016 insertions(+), 125 deletions(-)
 delete mode 100644 arch/mn10300/unit-asb2305/pci-iomap.c
 create mode 100644 drivers/virtio/virtio_pci_modern.c

-- 
MST
