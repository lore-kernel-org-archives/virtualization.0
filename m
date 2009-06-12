From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PULL] virtio
Date: Fri, 12 Jun 2009 22:18:34 +0930
Message-ID: <200906122218.34829.rusty__16990.4356742792$1244811068$gmane$org@rustcorp.com.au>
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
Cc: Mark McLoughlin <markmc@redhat.com>, Mike Frysinger <vapier@gentoo.org>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

The following changes since commit 8ebf975608aaebd7feb33d77f07ba21a6380e086:
  Randy Dunlap (1):
        block: fix kernel-doc in recent block/ changes

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/rusty/linux-2.6-virtio.git master

Christian Borntraeger (2):
      virtio: fix id_matching for virtio drivers
      virtio: enhance id_matching for virtio drivers

Mark McLoughlin (2):
      virtio: teach virtio_has_feature() about transport features
      virtio: indirect ring entries (VIRTIO_RING_F_INDIRECT_DESC)

Michael S. Tsirkin (3):
      virtio: find_vqs/del_vqs virtio operations
      virtio_pci: split up vp_interrupt
      virtio_pci: optional MSI-X support

Mike Frysinger (1):
      virtio_blk: add missing __dev{init,exit} markings

Rusty Russell (5):
      virtio: fix obsolete documentation on probe function
      virtio: meet virtio spec by finalizing features before using device
      virtio: add names to virtqueue struct, mapping from devices to queues.
      virtio: expose features in sysfs
      virtio: handle short buffers in virtio_rng.

 drivers/block/virtio_blk.c          |   10 +-
 drivers/char/hw_random/virtio-rng.c |   30 +++--
 drivers/char/virtio_console.c       |   26 ++--
 drivers/lguest/lguest_device.c      |   41 +++++-
 drivers/net/virtio_net.c            |   45 ++---
 drivers/s390/kvm/kvm_virtio.c       |   43 +++++-
 drivers/virtio/virtio.c             |   29 +++-
 drivers/virtio/virtio_balloon.c     |   27 ++--
 drivers/virtio/virtio_pci.c         |  307 ++++++++++++++++++++++++++++++-----
 drivers/virtio/virtio_ring.c        |  102 +++++++++++-
 include/linux/virtio.h              |   15 +-
 include/linux/virtio_config.h       |   49 +++++--
 include/linux/virtio_pci.h          |   10 +-
 include/linux/virtio_ring.h         |    8 +-
 net/9p/trans_virtio.c               |    6 +-
 scripts/mod/file2alias.c            |    2 +-
 16 files changed, 592 insertions(+), 158 deletions(-)
