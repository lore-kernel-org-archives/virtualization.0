From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v4 RFC 3/3] virtio_ccw: set 'device_lost' on CIO_GONE
	notification
Date: Fri, 13 Dec 2013 14:13:30 +0100
Message-ID: <1386940410-44943-4-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1386940410-44943-1-git-send-email-graalfs@linux.vnet.ibm.com>
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

When a CIO_GONE notification is received the device_lost flag is
set in the virtio_device. This flag should be tested by a backend
in order to be able to prevent triggering final I/O to a device that
is not reachable any more.

The notification is ignored in case remove or set_offline is already
running. The virtio_device pointer might point to freed memory in that
case.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index b939a7f..a468b9c 100644
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
@@ -1085,8 +1086,26 @@ out_free:
 
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
+		atomic_inc(&vcdev->vdev.device_lost);
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
