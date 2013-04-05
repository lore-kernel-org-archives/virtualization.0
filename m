From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 0/7] virtio cleanups
Date: Fri,  5 Apr 2013 14:06:58 +1030
Message-ID: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
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
Cc: Pawel Moll <pawel.moll@arm.com>, Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Aiming these for coming merge window.

Nothing should change, but get ready for a non-guest-endian config transports,
and > 32 features bits.

Final one is just an overdue consolidation.

Cheers,
Rusty.

Rusty Russell (7):
  virtio_config: introduce size-based accessors.
  virtio: use size-based config accessors.
  virtio_config: helpers for non-converting accessors.
  virtio_config: make transports implement accessors.
  virtio: use u32, not bitmap for struct virtio_device's features
  virtio: add support for 64 bit features.
  virtio: move vring structure into struct virtqueue.

 drivers/block/virtio_blk.c             |   77 +++++------
 drivers/char/virtio_console.c          |   17 +--
 drivers/lguest/lguest_device.c         |   36 +++--
 drivers/net/caif/caif_virtio.c         |   25 ++--
 drivers/net/virtio_net.c               |   28 ++--
 drivers/remoteproc/remoteproc_virtio.c |    8 +-
 drivers/s390/kvm/kvm_virtio.c          |   34 ++---
 drivers/s390/kvm/virtio_ccw.c          |   71 +++++++---
 drivers/scsi/virtio_scsi.c             |   12 +-
 drivers/virtio/virtio.c                |   87 +++++++++++--
 drivers/virtio/virtio_balloon.c        |   10 +-
 drivers/virtio/virtio_mmio.c           |   41 +++---
 drivers/virtio/virtio_pci.c            |   33 ++---
 drivers/virtio/virtio_ring.c           |  116 +++++++----------
 include/linux/virtio.h                 |   11 +-
 include/linux/virtio_config.h          |  224 ++++++++++++++++++++++++++------
 net/9p/trans_virtio.c                  |    9 +-
 tools/virtio/linux/virtio.h            |   22 +---
 tools/virtio/linux/virtio_config.h     |    2 +-
 tools/virtio/virtio_test.c             |    5 +-
 tools/virtio/vringh_test.c             |   16 +--
 21 files changed, 534 insertions(+), 350 deletions(-)

-- 
1.7.10.4
