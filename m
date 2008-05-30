From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio & lguest fixes (and new virtio_rng driver)
Date: Fri, 30 May 2008 15:21:14 +1000
Message-ID: <200805301521.15243.rusty@rustcorp.com.au>
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 0a2ce2ffc358da96792d514c1024b72c52be9cc1:
  David Howells (1):
        Fix FRV minimum slab/kmalloc alignment

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-for-linus.git master

Chris Lalancette (1):
      Fix crash in virtio_blk during modprobe ; rmmod ; modprobe

Christian Borntraeger (4):
      virtio_blk: allow read-only disks
      virtio_net: another race with virtio_net and enable_cb
      virtio_config: fix len calculation of config elements
      virtio_blk: fix endianess annotations

Rusty Russell (8):
      lguest: use ioremap_cache, not ioremap
      virtio: bus_id for devices should contain 'virtio'
      virtio: virtio_pci should not set bus_id.
      virtio: set device index in common code.
      lguest: fix ugly <NULL> in /proc/interrupts
      virtio: An entropy device, as suggested by hpa.
      virtio: force callback on empty.
      lguest: notify on empty

 Documentation/lguest/lguest.c       |   12 ++-
 arch/x86/lguest/boot.c              |    5 +-
 drivers/block/virtio_blk.c          |    7 ++-
 drivers/char/hw_random/Kconfig      |    9 ++
 drivers/char/hw_random/Makefile     |    1 +
 drivers/char/hw_random/virtio-rng.c |  155 +++++++++++++++++++++++++++++++++++
 drivers/lguest/lguest_device.c      |   25 ++----
 drivers/s390/kvm/kvm_virtio.c       |   18 ++---
 drivers/virtio/virtio.c             |    8 ++-
 drivers/virtio/virtio_pci.c         |    7 --
 drivers/virtio/virtio_ring.c        |    8 --
 include/linux/virtio_blk.h          |    9 +-
 include/linux/virtio_config.h       |    6 +-
 include/linux/virtio_rng.h          |    8 ++
 14 files changed, 225 insertions(+), 53 deletions(-)
 create mode 100644 drivers/char/hw_random/virtio-rng.c
 create mode 100644 include/linux/virtio_rng.h
