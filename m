From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v3 RFC 0/4] virtio: add 'surprize_removal' to virtio_device
Date: Wed, 27 Nov 2013 11:32:36 +0100
Message-ID: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
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
To: mst@redhat.com, virtualization@lists.linux-foundation.org
Cc: borntraeger@de.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Hi, here is an updated patch-set to my v2 RFC
   virtio: add new notify() callback to virtio_driver
This RFC introduces a new virtio_device entry 'surprize_removal' instead
of a new 'notify' callback in struct virtio_driver.

When an active virtio block device is hot-unplugged from a KVM guest,
affected guest user applications are not aware of any errors that occur
due to the lost device. This patch-set adds code to avoid further request
queueing when a lost block device is detected, resulting in appropriate
error info. Additionally a potential hang situation can be avoided by not
waiting for requests (e.g. in-flight requests) in blk_cleanup_queue() that
will never complete.

On System z there exists no handshake mechanism between host and guest
when a device is hot-unplugged. The device is removed and no further I/O
is possible.

When an online channel device disappears on System z the kernel's CIO layer
informs the driver (virtio_ccw) about the lost device.

Here are some more error details:

For a particular block device virtio's request function virtblk_request()
is called by the block layer to queue requests to be handled by the host.
In case of a lost device requests can still be queued, but an appropriate
subsequent host kick usually fails. This leads to situations where no error
feedback is shown.

In order to prevent request queueing for lost devices appropriate settings
in the block layer should be made. Exploiting System z's CIO notify handler
callback, and passing on device loss information via the surprize_removal
flag to the remove callback of the backend driver, can solve this task.

v2->v3 changes:
 - remove virtio_driver's notify callback (and appropriate code) introduced
   in my v1 RFC
 - introduce 'surprize_removal' in struct virtio_device
 - change virtio_blk's remove callback to perform special actions when the
   surprize_removal flag is set
   - avoid final I/O by preventing further request queueing
   - avoid hangs in blk_cleanup_queue() due to waits on 'in-flight' requests
 - set surprize_removal in virtio_ccw's notify callback when a device is lost

v1->v2 changes:
 - add include of linux/notifier.h (I also added it to the 3rd patch)
 - get queue lock in order to be able to use safe queue_flag_set() functions
   in virtblk_notify() handler


Heinz Graalfs (4):
  virtio: add surprize_removal to virtio_device
  virtio_blk: avoid further request queueing on device loss
  virtio_blk: avoid calling blk_cleanup_queue() on device loss
  virtio_ccw: set surprize_removal in virtio_device if a device was lost

 drivers/block/virtio_blk.c    | 12 +++++++++++-
 drivers/s390/kvm/virtio_ccw.c | 16 ++++++++++++++--
 drivers/virtio/virtio.c       |  1 +
 include/linux/virtio.h        |  1 +
 4 files changed, 27 insertions(+), 3 deletions(-)

-- 
1.8.3.1
