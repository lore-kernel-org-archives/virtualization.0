From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v3 RFC 4/4] virtio_ccw: set surprize_removal in virtio_device
	if a device was lost
Date: Wed, 27 Nov 2013 11:32:40 +0100
Message-ID: <1385548360-31943-5-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1385548360-31943-1-git-send-email-graalfs@linux.vnet.ibm.com>
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

Code is added to the notify handler to set the 'surprize_removal' flag
in virtio_device in case a CIO_GONE notification occurs. The remove
callback of the backend driver must check this flag in order to perform
special processing for a lost device.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 35b9aaa..8f6c74a 100644
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
@@ -1064,8 +1065,19 @@ out_free:
 
 static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
 {
-	/* TODO: Check whether we need special handling here. */
-	return 0;
+	int rc;
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+
+	switch (event) {
+	case CIO_GONE:
+		vcdev->vdev.surprize_removal = true;
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
