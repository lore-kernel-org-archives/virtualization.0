From: weiping zhang <zwp10758@gmail.com>
Subject: [PATCH v3 3/5] virtio_vop: don't kfree device on register failure
Date: Sun, 17 Dec 2017 21:47:09 +0800
Message-ID: <b88c60110467f1c5c516bf8d185a0df2ca262bab.1513517240.git.zhangweiping@didichuxing.com>
References: <cover.1513517240.git.zhangweiping@didichuxing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1513517240.git.zhangweiping@didichuxing.com>
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
---
 drivers/misc/mic/vop/vop_main.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/misc/mic/vop/vop_main.c b/drivers/misc/mic/vop/vop_main.c
index a341938..53eaa9d 100644
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
@@ -512,7 +514,10 @@ static int _vop_add_device(struct mic_device_desc __iomem *d,
 free_irq:
 	vpdev->hw_ops->free_irq(vpdev, vdev->virtio_cookie, vdev);
 kfree:
-	kfree(vdev);
+	if (VIRTIO_CONFIG_S_ACKNOWLEDGE & virtio_get_status(&vdev->vdev))
+		put_device(&vdev->vdev.dev);
+	else
+		kfree(vdev);
 	return ret;
 }
 
@@ -568,7 +573,7 @@ static int _vop_remove_device(struct mic_device_desc __iomem *d,
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
