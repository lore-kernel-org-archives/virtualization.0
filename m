From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 9/9] virtio_scsi: verify if queue is broken after
	virtqueue_get_buf()
Date: Mon,  4 Nov 2013 12:14:56 +0100
Message-ID: <1383563697-37309-1-git-send-email-graalfs@linux.vnet.ibm.com>
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
To: rusty@rustcorp.com.au, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Rusty,

and here is patch 9 as you suggested.

Thanks.

Heinz Graalfs (9):
  virtio_ring: change host notification API
  virtio_ring: let virtqueue_{kick()/notify()} return a bool
  virtio_net: verify if virtqueue_kick() succeeded
  virtio_test: verify if virtqueue_kick() succeeded
  virtio_ring: add new function virtqueue_is_broken()
  virtio_blk: verify if queue is broken after virtqueue_get_buf()
  virtio_console: verify if queue is broken after virtqueue_get_buf()
  virtio_net: verify if queue is broken after virtqueue_get_buf()
  virtio_scsi: verify if queue is broken after virtqueue_get_buf()

 drivers/block/virtio_blk.c             |  2 ++
 drivers/char/virtio_console.c          |  6 ++++--
 drivers/lguest/lguest_device.c         |  3 ++-
 drivers/net/virtio_net.c               | 12 +++++++-----
 drivers/remoteproc/remoteproc_virtio.c |  3 ++-
 drivers/s390/kvm/kvm_virtio.c          |  8 ++++++--
 drivers/s390/kvm/virtio_ccw.c          |  5 ++++-
 drivers/scsi/virtio_scsi.c             |  3 +++
 drivers/virtio/virtio_mmio.c           |  3 ++-
 drivers/virtio/virtio_pci.c            |  3 ++-
 drivers/virtio/virtio_ring.c           | 32 ++++++++++++++++++++++++++------
 include/linux/virtio.h                 |  6 ++++--
 include/linux/virtio_ring.h            |  2 +-
 tools/virtio/virtio_test.c             |  6 ++++--
 tools/virtio/vringh_test.c             | 13 +++++++++----
 15 files changed, 78 insertions(+), 29 deletions(-)

-- 
1.8.3.1
