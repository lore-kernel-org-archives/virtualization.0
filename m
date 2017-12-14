From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] virtio/s390: implement PM operations for virtio_ccw
Date: Thu, 14 Dec 2017 10:59:54 +0100
Message-ID: <20171214095954.7615-2-cohuck__32292.1709776439$1513245654$gmane$org@redhat.com>
References: <20171214095954.7615-1-cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20171214095954.7615-1-cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

Suspend/Resume to/from disk currently fails. Let us wire
up the necessary callbacks. This is mostly just forwarding
the requests to the virtio drivers. The only thing that
has to be done in virtio_ccw itself is to re-set the
virtio revision.

Suggested-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20171207141102.70190-2-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index b18fe2014cf2..330b3fa3430a 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -1300,6 +1300,9 @@ static int virtio_ccw_cio_notify(struct ccw_device *cdev, int event)
 		vcdev->device_lost = true;
 		rc = NOTIFY_DONE;
 		break;
+	case CIO_OPER:
+		rc = NOTIFY_OK;
+		break;
 	default:
 		rc = NOTIFY_DONE;
 		break;
@@ -1312,6 +1315,25 @@ static struct ccw_device_id virtio_ids[] = {
 	{},
 };
 
+static int virtio_ccw_freeze(struct ccw_device *cdev)
+{
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+
+	return virtio_device_freeze(&vcdev->vdev);
+}
+
+static int virtio_ccw_restore(struct ccw_device *cdev)
+{
+	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	int ret;
+
+	ret = virtio_ccw_set_transport_rev(vcdev);
+	if (ret)
+		return ret;
+
+	return virtio_device_restore(&vcdev->vdev);
+}
+
 static struct ccw_driver virtio_ccw_driver = {
 	.driver = {
 		.owner = THIS_MODULE,
@@ -1324,6 +1346,9 @@ static struct ccw_driver virtio_ccw_driver = {
 	.set_online = virtio_ccw_online,
 	.notify = virtio_ccw_cio_notify,
 	.int_class = IRQIO_VIR,
+	.freeze = virtio_ccw_freeze,
+	.thaw = virtio_ccw_restore,
+	.restore = virtio_ccw_restore,
 };
 
 static int __init pure_hex(char **cp, unsigned int *val, int min_digit,
-- 
2.13.6
