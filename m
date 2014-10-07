From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC 03/11] virtio: endianess conversion helpers
Date: Tue,  7 Oct 2014 16:39:44 +0200
Message-ID: <1412692792-12325-4-git-send-email-cornelia.huck__11601.9226880328$1412704455$gmane$org@de.ibm.com>
References: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1412692792-12325-1-git-send-email-cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: thuth@linux.vnet.ibm.com
List-Id: virtualization@lists.linuxfoundation.org

Provide helper functions that convert from/to LE for virtio devices that
are not operating in legacy mode. We check for the VERSION_1 feature bit
to determine that.

Based on original patches by Rusty Russell and Thomas Huth.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 drivers/virtio/virtio.c            |    4 ++++
 include/linux/virtio.h             |   40 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/virtio_config.h |    3 +++
 3 files changed, 47 insertions(+)

diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index cfd5d00..8f74cd6 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -144,6 +144,10 @@ static int virtio_dev_probe(struct device *_d)
 		if (device_features & (1ULL << i))
 			dev->features |= (1ULL << i);
 
+	/* Version 1.0 compliant devices set the VIRTIO_F_VERSION_1 bit */
+	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
+		dev->features |= (1ULL << VIRTIO_F_VERSION_1);
+
 	dev->config->finalize_features(dev);
 
 	err = drv->probe(dev);
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index a24b41f..68cadd4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/gfp.h>
 #include <linux/vringh.h>
+#include <uapi/linux/virtio_config.h>
 
 /**
  * virtqueue - a queue to register buffers for sending or receiving.
@@ -102,6 +103,11 @@ static inline struct virtio_device *dev_to_virtio(struct device *_dev)
 	return container_of(_dev, struct virtio_device, dev);
 }
 
+static inline bool virtio_device_legacy(const struct virtio_device *dev)
+{
+	return !(dev->features & (1ULL << VIRTIO_F_VERSION_1));
+}
+
 int register_virtio_device(struct virtio_device *dev);
 void unregister_virtio_device(struct virtio_device *dev);
 
@@ -149,4 +155,38 @@ void unregister_virtio_driver(struct virtio_driver *drv);
 #define module_virtio_driver(__virtio_driver) \
 	module_driver(__virtio_driver, register_virtio_driver, \
 			unregister_virtio_driver)
+
+/*
+ * v1.0 specifies LE headers, legacy was native endian. Therefore, we must
+ * convert from/to LE if and only if vdev is not legacy.
+ */
+static inline u16 virtio_to_cpu_u16(const struct virtio_device *vdev, u16 v)
+{
+	return virtio_device_legacy(vdev) ? v : le16_to_cpu(v);
+}
+
+static inline u32 virtio_to_cpu_u32(const struct virtio_device *vdev, u32 v)
+{
+	return virtio_device_legacy(vdev) ? v : le32_to_cpu(v);
+}
+
+static inline u64 virtio_to_cpu_u64(const struct virtio_device *vdev, u64 v)
+{
+	return virtio_device_legacy(vdev) ? v : le64_to_cpu(v);
+}
+
+static inline u16 cpu_to_virtio_u16(const struct virtio_device *vdev, u16 v)
+{
+	return virtio_device_legacy(vdev) ? v : cpu_to_le16(v);
+}
+
+static inline u32 cpu_to_virtio_u32(const struct virtio_device *vdev, u32 v)
+{
+	return virtio_device_legacy(vdev) ? v : cpu_to_le32(v);
+}
+
+static inline u64 cpu_to_virtio_u64(const struct virtio_device *vdev, u64 v)
+{
+	return virtio_device_legacy(vdev) ? v : cpu_to_le64(v);
+}
 #endif /* _LINUX_VIRTIO_H */
diff --git a/include/uapi/linux/virtio_config.h b/include/uapi/linux/virtio_config.h
index 3ce768c..80e7381 100644
--- a/include/uapi/linux/virtio_config.h
+++ b/include/uapi/linux/virtio_config.h
@@ -54,4 +54,7 @@
 /* Can the device handle any descriptor layout? */
 #define VIRTIO_F_ANY_LAYOUT		27
 
+/* v1.0 compliant. */
+#define VIRTIO_F_VERSION_1		32
+
 #endif /* _UAPI_LINUX_VIRTIO_CONFIG_H */
-- 
1.7.9.5
