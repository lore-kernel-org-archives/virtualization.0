From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 1/6] virtio: add API to detect legacy devices
Date: Mon, 8 Dec 2014 15:05:51 +0200
Message-ID: <1418042769-25539-2-git-send-email-mst@redhat.com>
References: <1418042769-25539-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1418042769-25539-1-git-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: dahi@linux.vnet.ibm.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

transports need to be able to detect legacy-only
devices (ATM balloon only) to use legacy path
to drive them.

Add a core API to do just that.
The implementation just blacklists balloon:
not too pretty, but let's not over-engineer.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/virtio.h  | 2 ++
 drivers/virtio/virtio.c | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 2bbf626..d666bcb 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -108,6 +108,8 @@ struct virtio_device {
 	void *priv;
 };
 
+bool virtio_device_is_legacy_only(struct virtio_device_id id);
+
 static inline struct virtio_device *dev_to_virtio(struct device *_dev)
 {
 	return container_of(_dev, struct virtio_device, dev);
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index fa6b75d..224f854 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -3,6 +3,7 @@
 #include <linux/virtio_config.h>
 #include <linux/module.h>
 #include <linux/idr.h>
+#include <uapi/linux/virtio_ids.h>
 
 /* Unique numbering for virtio devices. */
 static DEFINE_IDA(virtio_index_ida);
@@ -267,6 +268,12 @@ static struct bus_type virtio_bus = {
 	.remove = virtio_dev_remove,
 };
 
+bool virtio_device_is_legacy_only(struct virtio_device_id id)
+{
+	return id.device == VIRTIO_ID_BALLOON;
+}
+EXPORT_SYMBOL_GPL(virtio_device_is_legacy_only);
+
 int register_virtio_driver(struct virtio_driver *driver)
 {
 	/* Catch this early. */
-- 
MST
