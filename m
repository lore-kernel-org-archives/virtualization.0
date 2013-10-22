From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 0/7] virtio: avoid various hang situations during
	hot-unplug
Date: Tue, 22 Oct 2013 14:45:04 +0200
Message-ID: <1382445911-55657-1-git-send-email-graalfs@linux.vnet.ibm.com>
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

this patch-set tries to solve various hang situations when virtio devices
(network or block) are hot-unplugged from a KVM guest.

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

Here are the details for some of the errors.

In the network case a hang (loop) occurs when a machine check is handled
on System z due to a vlan device removal. A loop spinning for a response
for final IO in virtnet_send_command() will never complete successfully
because of a previous unsuccessfull host kick operation (virtqueue_kick()).

The below patches [1,2] flag the virtqueue as 'broken' when a host kick failure
is detected. Patch [3] exploits this error info to avoid an endless invocation
of cpu_relax() when waiting for the command to complete.

Hang situations also occur when a block device is hot-unplugged.

Several different errors occur when a block device with mounted file-system(s)
is hot-unplugged. Asynchronous writeback functions, as well as page cache read
or write operations end up in never ending wait situations. Hang situations
occur during device removal when virtblk_remove() invokes del_gendisk() to
synch dirty inode pages (invalidate_partition()).

The below patches [4,5,6,7] also exploit a 'broken' virtqueue in order to
trigger IO errors as well as to prevent final hanging IO operations.


Heinz Graalfs (7):
  virtio_ring: add new functions virtqueue{_set_broken()/_is_broken()}
  s390/virtio_ccw: set virtqueue as broken if host notify failed
  virtio_net: avoid cpu_relax() call loop in case virtqueue is broken
  virtio_blk: use dummy virtqueue_notify() to detect host kick error
  virtio_blk: do not free device id if virtqueue is broken
  virtio_blk: set request queue as dying in case virtqueue is broken
  virtio_blk: trigger IO errors in case virtqueue is broken

 drivers/block/virtio_blk.c    | 41 ++++++++++++++++++++++++++++++++++++-----
 drivers/net/virtio_net.c      |  4 +++-
 drivers/s390/kvm/virtio_ccw.c |  2 ++
 drivers/virtio/virtio_ring.c  | 16 ++++++++++++++++
 include/linux/virtio.h        |  4 ++++
 5 files changed, 61 insertions(+), 6 deletions(-)

-- 
1.8.3.1
