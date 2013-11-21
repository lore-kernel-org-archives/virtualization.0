From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 RFC 3/3] virtio_ccw: invoke virtio_driver's notify()
	on CIO_GONE notification
Date: Thu, 21 Nov 2013 20:31:03 +0200
Message-ID: <20131121183103.GA14754@redhat.com>
References: <1385045133-2165-1-git-send-email-graalfs@linux.vnet.ibm.com>
	<1385045133-2165-4-git-send-email-graalfs@linux.vnet.ibm.com>
	<20131121151557.GB12001@redhat.com>
	<528E3EF5.8030004@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <528E3EF5.8030004@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Nov 21, 2013 at 06:12:21PM +0100, Heinz Graalfs wrote:
> On 21/11/13 16:15, Michael S. Tsirkin wrote:
> >On Thu, Nov 21, 2013 at 03:45:33PM +0100, Heinz Graalfs wrote:
> >>virtio_ccw's notify() callback for the common IO layer invokes
> >>virtio_driver's notify() callback to pass-on information to a
> >>backend driver if an online device disappeared.
> >>
> >>Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
> >
> >simple question: is this serialized with device removal?
> >If this races with removal we have a problem.
> >
> 
> notify and remove callbacks are not serialized.
> 
> Additional processing in the notify handler is now locked by the queue lock.
> 
> If remove is already active (e.g. driver unregister) and performing
> its cleanup (via virtblk_remove), we should definitely perform the
> (locked) request queue processing in notify (little later), because
> if a notify comes in, the device is GONE (not going away). Earlier
> triggered cleanup processing is about to fail anyway.

I don't get it. It's possible nothing is in queue
or everything timed out.
Then this notify will address freed memory.

I'm starting to think the right solution is to pass
a flag to remove: bool surprize_removal.

Then you will cleanly set flags before removing the device.

No new callbacks and no races.

> >>---
> >>  drivers/s390/kvm/virtio_ccw.c | 15 +++++++++++++--
> >>  1 file changed, 13 insertions(+), 2 deletions(-)
> >>
> >>diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
> >>index 35b9aaa..682f688 100644
> >>--- a/drivers/s390/kvm/virtio_ccw.c
> >>+++ b/drivers/s390/kvm/virtio_ccw.c
> >>@@ -27,6 +27,7 @@
> >>  #include <linux/module.h>
> >>  #include <linux/io.h>
> >>  #include <linux/kvm_para.h>
> >>+#include <linux/notifier.h>
> >>  #include <asm/setup.h>
> >>  #include <asm/irq.h>
> >>  #include <asm/cio.h>
> >>@@ -1064,8 +1065,18 @@ out_free:
> >>
> >>  static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
> >>  {
> >>-	/* TODO: Check whether we need special handling here. */
> >>-	return 0;
> >>+	int rc;
> >>+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
> >>+
> >>+	switch (event) {
> >>+	case CIO_GONE:
> >>+		rc = notify_virtio_device(&vcdev->vdev, VDEV_GONE);
> >>+		break;
> >>+	default:
> >>+		rc = NOTIFY_DONE;
> >>+		break;
> >>+	}
> >>+	return rc;
> >>  }
> >>
> >>  static struct ccw_device_id virtio_ids[] = {
> >>--
> >>1.8.3.1
> >
