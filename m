From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH 1/1] virtio_ccw: introduce device_lost in virtio_ccw_device
Date: Fri, 25 Apr 2014 14:35:27 +0200
Message-ID: <1398429327-31391-2-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1398429327-31391-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1398429327-31391-1-git-send-email-graalfs@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: rusty@rustcorp.com.au
Cc: borntraeger@de.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

When a device is lost, the common I/O layer calls the notification
handler with CIO_GONE: In that event, flag device_lost as true.

In case the device had been flagged as lost when the remove/offline callbacks
are called, call the new virtio_break_device() function prior to invoking
device_unregister(). This avoids hangs of I/O triggered via the device
unregistration callbacks.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 49 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 37 insertions(+), 12 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 1e1fc67..d2c0b44 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -27,6 +27,7 @@
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/kvm_para.h>
+#include <linux/notifier.h>
 #include <asm/setup.h>
 #include <asm/irq.h>
 #include <asm/cio.h>
@@ -62,6 +63,7 @@ struct virtio_ccw_device {
 	struct vq_config_block *config_block;
 	bool is_thinint;
 	bool going_away;
+	bool device_lost;
 	void *airq_info;
 };
 
@@ -1010,11 +1012,14 @@ static void virtio_ccw_remove(struct ccw_device *cdev)
 	unsigned long flags;
 	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	if (vcdev && cdev->online)
+	if (vcdev && cdev->online) {
+		if (vcdev->device_lost)
+			virtio_break_device(&vcdev->vdev);
 		unregister_virtio_device(&vcdev->vdev);
-	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
-	dev_set_drvdata(&cdev->dev, NULL);
-	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+		dev_set_drvdata(&cdev->dev, NULL);
+		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	}
 	cdev->handler = NULL;
 }
 
@@ -1023,12 +1028,14 @@ static int virtio_ccw_offline(struct ccw_device *cdev)
 	unsigned long flags;
 	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	if (vcdev) {
-		unregister_virtio_device(&vcdev->vdev);
-		spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
-		dev_set_drvdata(&cdev->dev, NULL);
-		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
-	}
+	if (!vcdev)
+		return 0;
+	if (vcdev->device_lost)
+		virtio_break_device(&vcdev->vdev);
+	unregister_virtio_device(&vcdev->vdev);
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	dev_set_drvdata(&cdev->dev, NULL);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	return 0;
 }
 
@@ -1096,8 +1103,26 @@ out_free:
 
 static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
 {
-	/* TODO: Check whether we need special handling here. */
-	return 0;
+	int rc;
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+
+	/*
+	 * Make sure vcdev is set
+	 * i.e. set_offline/remove callback not already running
+	 */
+	if (!vcdev)
+		return NOTIFY_DONE;
+
+	switch (event) {
+	case CIO_GONE:
+		vcdev->device_lost = true;
+		rc = NOTIFY_DONE;
+		break;
+	default:
+		rc = NOTIFY_DONE;
+		break;
+	}
+	return rc;
 }
 
 static struct ccw_device_id virtio_ids[] = {
-- 
1.8.3.1
