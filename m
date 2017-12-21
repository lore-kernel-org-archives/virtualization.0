From: weiping zhang <zhangweiping@didichuxing.com>
Subject: [PATCH v5 1/4] virtio: split device_register into device_initialize
	and device_add
Date: Thu, 21 Dec 2017 20:39:50 +0800
Message-ID: <0a8c1c071eef26bc4dfdf796778fd590d0f8e7e7.1513825904.git.zhangweiping@didichuxing.com>
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

In order to make caller do a simple cleanup, we split device_register
into device_initialize and device_add. device_initialize always succeeds,
so the caller can always use put_device when register_virtio_device faild.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
Suggested-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/virtio/virtio.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index bf7ff39..59e36ef 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -303,11 +303,21 @@ void unregister_virtio_driver(struct virtio_driver *driver)
 }
 EXPORT_SYMBOL_GPL(unregister_virtio_driver);
 
+/**
+ * register_virtio_device - register virtio device
+ * @dev        : virtio device to be registered
+ *
+ * On error, the caller must call put_device on &@dev->dev (and not kfree),
+ * as another code path may have obtained a reference to @dev.
+ *
+ * Returns: 0 on suceess, -error on failure
+ */
 int register_virtio_device(struct virtio_device *dev)
 {
 	int err;
 
 	dev->dev.bus = &virtio_bus;
+	device_initialize(&dev->dev);
 
 	/* Assign a unique device index and hence name. */
 	err = ida_simple_get(&virtio_index_ida, 0, 0, GFP_KERNEL);
@@ -330,9 +340,11 @@ int register_virtio_device(struct virtio_device *dev)
 
 	INIT_LIST_HEAD(&dev->vqs);
 
-	/* device_register() causes the bus infrastructure to look for a
-	 * matching driver. */
-	err = device_register(&dev->dev);
+	/*
+	 * device_add() causes the bus infrastructure to look for a matching
+	 * driver.
+	 */
+	err = device_add(&dev->dev);
 	if (err)
 		ida_simple_remove(&virtio_index_ida, dev->index);
 out:
-- 
2.9.4
