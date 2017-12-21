From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v5 3/4] virtio_vop: don't kfree device on register failure
Date: Thu, 21 Dec 2017 20:40:43 +0800
Message-ID: <9b2024807d354724e8b28afc3fb647fd07005de2.1513825904.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: cohuck@redhat.com, mst@redhat.com, jasowang@redhat.com
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

As mentioned at drivers/base/core.c:
/*
 * NOTE: _Never_ directly free @dev after calling this function, even
 * if it returned an error! Always use put_device() to give up the
 * reference initialized in this function instead.
 */
so we don't free vdev until vdev->vdev.dev.release be called.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/misc/mic/vop/vop_main.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index a341938..3633202 100644
--- a/drivers/misc/mic/vop/vop_main.c
+++ b/drivers/misc/mic/vop/vop_main.c
@@ -452,10 +452,12 @@ static irqreturn_t vop_virtio_intr_handler(int irq, void *data)
 
 static void vop_virtio_release_dev(struct device *_d)
 {
-	/*
-	 * No need for a release method similar to virtio PCI.
-	 * Provide an empty one to avoid getting a warning from core.
-	 */
+	struct virtio_device *vdev =
+			container_of(_d, struct virtio_device, dev);
+	struct _vop_vdev *vop_vdev =
+			container_of(vdev, struct _vop_vdev, vdev);
+
+	kfree(vop_vdev);
 }
 
 /*
@@ -466,7 +468,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 			   unsigned int offset, struct vop_device *vpdev,
 			   int dnode)
 {
-	struct _vop_vdev *vdev;
+	struct _vop_vdev *vdev, *reg_dev = NULL;
 	int ret;
 	u8 type = ioread8(&d->type);
 
@@ -497,6 +499,7 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 	vdev->c2h_vdev_db = ioread8(&vdev->dc->c2h_vdev_db);
 
 	ret = register_virtio_device(&vdev->vdev);
+	reg_dev = vdev;
 	if (ret) {
 		dev_err(_vop_dev(vdev),
 			"Failed to register vop device %u type %u\n",
@@ -512,7 +515,10 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 free_irq:
 	vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
 kfree:
-	kfree(vdev);
+	if (reg_dev)
+		put_device(&vdev->vdev.dev);
+	else
+		kfree(vdev);
 	return ret;
 }
 
@@ -568,7 +574,7 @@ static int _vop_remove_device(struct mic_device_desc __iomem *d,
 		iowrite8(-1, &dc->h2c_vdev_db);
 		if (status & VIRTIO_CONFIG_S_DRIVER_OK)
 			wait_for_completion(&vdev->reset_done);
-		kfree(vdev);
+		put_device(&vdev->vdev.dev);
 		iowrite8(1, &dc->guest_ack);
 		dev_dbg(&vpdev->dev, "%s %d guest_ack %d\n",
 			__func__, __LINE__, ioread8(&dc->guest_ack));
-- 
2.9.4
