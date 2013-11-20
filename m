From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH RFC 3/3] virtio_ccw: invoke virtio_driver's notify() on
	CIO_GONE notification
Date: Wed, 20 Nov 2013 16:22:03 +0100
Message-ID: <1384960923-31463-4-git-send-email-graalfs@linux.vnet.ibm.com>
References: <1384960923-31463-1-git-send-email-graalfs@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1384960923-31463-1-git-send-email-graalfs@linux.vnet.ibm.com>
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

virtio_ccw's notify() callback for the common IO layer invokes
virtio_driver's notify() callback to pass-on information to a
backend driver if an online device disappeared.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 35b9aaa..420010d 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -1064,8 +1064,18 @@ out_free:
 
 static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
 {
-	/* TODO: Check whether we need special handling here. */
-	return 0;
+	int rc;
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+
+	switch (event) {
+	case CIO_GONE:
+		rc = notify_virtio_device(&vcdev->vdev, VDEV_GONE);
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
