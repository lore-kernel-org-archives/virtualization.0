From: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Subject: [PATCH v4 RFC 1/3] virtio_ccw: fix vcdev pointer handling issues
Date: Fri, 13 Dec 2013 14:13:28 +0100
Message-ID: <1386940410-44943-2-git-send-email-graalfs@linux.vnet.ibm.com>
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

The interrupt handler virtio_ccw_int_handler() using the vcdev pointer
is protected by the ccw_device lock. Resetting the pointer within the
ccw_device structure should be done when holding this lock.

Also resetting the vcdev pointer (under the ccw_device lock) prior to
freeing the vcdev pointer memory removes a critical path.

Signed-off-by: Heinz Graalfs <graalfs@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/s390/kvm/virtio_ccw.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 35b9aaa..b939a7f 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -886,6 +886,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
 	struct virtqueue *vq;
 	struct virtio_driver *drv;
 
+	if (!vcdev)
+		return;
 	/* Check if it's a notification from the host. */
 	if ((intparm == 0) &&
 	    (scsw_stctl(&irb->scsw) ==
@@ -985,23 +987,37 @@ static int virtio_ccw_probe(struct ccw_device *cdev)
 	return 0;
 }
 
+static struct virtio_ccw_device *virtio_grab_drvdata(struct ccw_device *cdev)
+{
+	unsigned long flags;
+	struct virtio_ccw_device *vcdev;
+
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
+	vcdev = dev_get_drvdata(&cdev->dev);
+	if (!vcdev) {
+		spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+		return NULL;
+	}
+	dev_set_drvdata(&cdev->dev, NULL);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
+	return vcdev;
+}
+
 static void virtio_ccw_remove(struct ccw_device *cdev)
 {
-	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	if (cdev->online) {
+	if (vcdev && cdev->online)
 		unregister_virtio_device(&vcdev->vdev);
-		dev_set_drvdata(&cdev->dev, NULL);
-	}
 	cdev->handler = NULL;
 }
 
 static int virtio_ccw_offline(struct ccw_device *cdev)
 {
-	struct virtio_ccw_device *vcdev = dev_get_drvdata(&cdev->dev);
+	struct virtio_ccw_device *vcdev = virtio_grab_drvdata(cdev);
 
-	unregister_virtio_device(&vcdev->vdev);
-	dev_set_drvdata(&cdev->dev, NULL);
+	if (vcdev)
+		unregister_virtio_device(&vcdev->vdev);
 	return 0;
 }
 
@@ -1010,6 +1026,7 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 {
 	int ret;
 	struct virtio_ccw_device *vcdev;
+	unsigned long flags;
 
 	vcdev = kzalloc(sizeof(*vcdev), GFP_KERNEL);
 	if (!vcdev) {
@@ -1039,7 +1056,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	INIT_LIST_HEAD(&vcdev->virtqueues);
 	spin_lock_init(&vcdev->lock);
 
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, vcdev);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	vcdev->vdev.id.vendor = cdev->id.cu_type;
 	vcdev->vdev.id.device = cdev->id.cu_model;
 	ret = register_virtio_device(&vcdev->vdev);
@@ -1050,7 +1069,9 @@ static int virtio_ccw_online(struct ccw_device *cdev)
 	}
 	return 0;
 out_put:
+	spin_lock_irqsave(get_ccwdev_lock(cdev), flags);
 	dev_set_drvdata(&cdev->dev, NULL);
+	spin_unlock_irqrestore(get_ccwdev_lock(cdev), flags);
 	put_device(&vcdev->vdev.dev);
 	return ret;
 out_free:
-- 
1.8.3.1
