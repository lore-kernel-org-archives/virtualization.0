From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio patches
Date: Fri, 25 Jul 2008 12:08:43 +1000
Message-ID: <200807251208.44418.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mark McLoughlin <markmc@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit b5684b83b1e1579bbbc80e703e990c0cccf5892c:
  Linus Torvalds (1):
        Merge git://git.kernel.org/.../bart/ide-2.6

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Christian Borntraeger (5):
      virtio_blk: check for hardsector size from host
      hvc_console: rework setup to replace irq functions with callbacks
      virtio_console: use virtqueue notification for hvc_console
      virtio: console as a config option
      s390: use virtio_console for KVM on s390

Herbert Xu (2):
      virtio net: Add ethtool ops for SG/GSO
      virtio net: Allow receiving SG packets

Mark McLoughlin (2):
      virtio: fix virtio_net xmit of freed skb bug
      virtio: Use bus_type probe and remove methods

Rusty Russell (6):
      virtio: Recycle unused recv buffer pages for large skbs in net driver
      virtio: clarify that ABI is usable by any implementations
      virtio: don't always force a notification when ring is full
      virtio: Formally reserve bits 28-31 to be 'transport' features.
      virtio: Rename set_features to finalize_features
      virtio: Add transport feature handling stub for virtio_ring.

 arch/s390/Kconfig              |    1 +
 arch/s390/kernel/setup.c       |    4 +-
 drivers/block/virtio_blk.c     |   10 +++-
 drivers/char/Kconfig           |   11 ++++-
 drivers/char/Makefile          |    1 +
 drivers/char/hvc_console.c     |   85 ++++++++----------------------
 drivers/char/hvc_console.h     |   35 +++++++++++--
 drivers/char/hvc_irq.c         |   44 +++++++++++++++
 drivers/char/hvc_iseries.c     |    2 +
 drivers/char/hvc_vio.c         |    2 +
 drivers/char/hvc_xen.c         |    2 +
 drivers/char/virtio_console.c  |   40 ++++++++++++---
 drivers/lguest/lguest_device.c |   14 +++--
 drivers/net/virtio_net.c       |  114 +++++++++++++++++++++++++++++++++++-----
 drivers/s390/kvm/kvm_virtio.c  |   34 ++++++++++--
 drivers/virtio/virtio.c        |   26 +++++----
 drivers/virtio/virtio_pci.c    |   13 +++--
 drivers/virtio/virtio_ring.c   |   23 +++++++-
 include/asm-s390/kvm_virtio.h  |   10 ++++
 include/linux/virtio_9p.h      |    2 +
 include/linux/virtio_balloon.h |    2 +
 include/linux/virtio_blk.h     |    5 ++
 include/linux/virtio_config.h  |   16 +++++-
 include/linux/virtio_console.h |    2 +
 include/linux/virtio_net.h     |    2 +
 include/linux/virtio_pci.h     |    5 +-
 include/linux/virtio_ring.h    |    2 +
 include/linux/virtio_rng.h     |    2 +
 28 files changed, 385 insertions(+), 124 deletions(-)
 create mode 100644 drivers/char/hvc_irq.c
