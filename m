From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH V2 RFC 0/9] virtio: fix hang(loop) after hot-unplug vlan
Date: Thu, 24 Oct 2013 17:23:11 +0200
Message-ID: <1382628200-42956-1-git-send-email-graalfs@linux.vnet.ibm.com>
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
To: rusty@rustcorp.com.au, mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi,

this patch-set solves a hang situation when a vlan network device is
hot-unplugged from a KVM guest.

On System z there exists no handshake mechanism between host and guest
when a device is hot-unplugged. The device is removed and no further I/O
is possible.

The guest is notified about the hard removal with a CRW machine check.
As per architecture, the host must repond to any I/O operation for the
removed device with an error condition as if the device had never been
there.

During machine check handling in the guest, virtio exit functions try to
perform cleanup operations by triggering final I/O, including appropriate
host kicks. These operations fail, or do not complete, and lead to several
kinds of hang situations. In particular, virtio-ccw guest->host notification
on an unplugged device will receive an error; this is, however, not reflected
back to the affected virtqueues.

Here are the details of the error.

A hang (loop) occurs when a machine check is handled on System z due to a
vlan device removal. A loop spinning for a response for final IO in
virtnet_send_command() will never complete successfully because of a previous
unsuccessfull host kick operation (virtqueue_kick()).


Patch [1] changes the guest->host notification API. A potential error returned
by the host during notify() should not be ignored, but used in order to reflect
the error back to the affected virtqueue.

Patch [2] changes virtqueue_kick() and virtqueue_notify() to return a bool
depending on the result of the host notification operation. If the host
kick failed the current virtqueue is now flagged as 'broken'.

Patches [3,4] add code to verify host kicks by testing the return value of
virtqueue_kick() in order to avoid potential loops.

Patch [5] adds a new function virtqueue_is_broken(). This function should be
used to verify the state of a virtqueue when a previous virtqueue_get_buf()
returned a NULL pointer.

Patch [6,7,8,9] add virtqueue_is_broken() calls to handle potential errors
when a virtqueue_bet_buf() doesn't deliver any more buffers.


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
 drivers/scsi/virtio_scsi.c             |  3 ++-
 drivers/virtio/virtio_mmio.c           |  3 ++-
 drivers/virtio/virtio_pci.c            |  3 ++-
 drivers/virtio/virtio_ring.c           | 32 ++++++++++++++++++++++++++------
 include/linux/virtio.h                 |  6 ++++--
 include/linux/virtio_ring.h            |  2 +-
 tools/virtio/virtio_test.c             |  6 ++++--
 tools/virtio/vringh_test.c             | 13 +++++++++----
 15 files changed, 77 insertions(+), 30 deletions(-)

-- 
1.8.3.1
