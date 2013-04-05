From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 4/7] virtio_config: make transports implement accessors.
Date: Fri,  5 Apr 2013 14:07:02 +1030
Message-ID: <1365133025-5397-5-git-send-email-rusty@rustcorp.com.au>
References: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1365133025-5397-1-git-send-email-rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Pawel Moll <pawel.moll@arm.com>, Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

All transports just pass through at the moment.

s390/kvm/virtio_ccw.c doesn't use the helper wrappers, since it does quite a lot
of work for each config read.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest_device.c |   20 ++++++------
 drivers/net/caif/caif_virtio.c |    2 +-
 drivers/s390/kvm/kvm_virtio.c  |   24 +++++++-------
 drivers/s390/kvm/virtio_ccw.c  |   39 ++++++++++++++++++++--
 drivers/virtio/virtio_mmio.c   |   21 ++++--------
 drivers/virtio/virtio_pci.c    |   25 +++++---------
 include/linux/virtio_config.h  |   70 ++++++++++++++++++++++++----------------
 7 files changed, 118 insertions(+), 83 deletions(-)

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index b3256ff..baee77e 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -153,25 +153,22 @@ static void lg_finalize_features(struct virtio_device *vdev)
 }
 
 /* Once they've found a field, getting a copy of it is easy. */
-static void lg_get(struct virtio_device *vdev, unsigned int offset,
-		   void *buf, unsigned len)
+static u8 lg_get8(struct virtio_device *vdev, unsigned int offset)
 {
 	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 
 	/* Check they didn't ask for more than the length of the config! */
-	BUG_ON(offset + len > desc->config_len);
-	memcpy(buf, lg_config(desc) + offset, len);
+	BUG_ON(offset + sizeof(u8) > desc->config_len);
+	return *(u8 *)(lg_config(desc) + offset);
 }
 
-/* Setting the contents is also trivial. */
-static void lg_set(struct virtio_device *vdev, unsigned int offset,
-		   const void *buf, unsigned len)
+static void lg_set8(struct virtio_device *vdev, unsigned int offset, u8 val)
 {
 	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 
 	/* Check they didn't ask for more than the length of the config! */
-	BUG_ON(offset + len > desc->config_len);
-	memcpy(lg_config(desc) + offset, buf, len);
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u8 *)(lg_config(desc) + offset) = val;
 }
 
 /*
@@ -399,8 +396,9 @@ static const char *lg_bus_name(struct virtio_device *vdev)
 static const struct virtio_config_ops lguest_config_ops = {
 	.get_features = lg_get_features,
 	.finalize_features = lg_finalize_features,
-	.get = lg_get,
-	.set = lg_set,
+	.get8 = lg_get8,
+	.set8 = lg_set8,
+	VIRTIO_CONFIG_OPS_NOCONV,
 	.get_status = lg_get_status,
 	.set_status = lg_set_status,
 	.reset = lg_reset,
diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index ef602e3..0f9bae0 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -682,7 +682,7 @@ static int cfv_probe(struct virtio_device *vdev)
 		goto err;
 
 	/* Get the CAIF configuration from virtio config space, if available */
-	if (vdev->config->get) {
+	if (vdev->config->get8) {
 		virtio_cread(vdev, struct virtio_caif_transf_config, headroom,
 			     &cfv->tx_hr);
 		virtio_cread(vdev, struct virtio_caif_transf_config, headroom,
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index 6711e65..cde64d5 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -112,24 +112,25 @@ static void kvm_finalize_features(struct virtio_device *vdev)
 }
 
 /*
- * Reading and writing elements in config space
+ * Reading and writing elements in config space.  Host and guest are always
+ * big-endian, so no conversion necessary.
  */
-static void kvm_get(struct virtio_device *vdev, unsigned int offset,
-		   void *buf, unsigned len)
+static u8 kvm_get8(struct virtio_device *vdev, unsigned int offset)
 {
 	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
 
-	BUG_ON(offset + len > desc->config_len);
-	memcpy(buf, kvm_vq_configspace(desc) + offset, len);
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u8) > desc->config_len);
+	return *(u8 *)(kvm_vq_configspace(desc) + offset);
 }
 
-static void kvm_set(struct virtio_device *vdev, unsigned int offset,
-		   const void *buf, unsigned len)
+static void kvm_set8(struct virtio_device *vdev, unsigned int offset, u8 val)
 {
 	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
 
-	BUG_ON(offset + len > desc->config_len);
-	memcpy(kvm_vq_configspace(desc) + offset, buf, len);
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u8 *)(kvm_vq_configspace(desc) + offset) = val;
 }
 
 /*
@@ -278,8 +279,9 @@ static const char *kvm_bus_name(struct virtio_device *vdev)
 static const struct virtio_config_ops kvm_vq_configspace_ops = {
 	.get_features = kvm_get_features,
 	.finalize_features = kvm_finalize_features,
-	.get = kvm_get,
-	.set = kvm_set,
+	.get8 = kvm_get8,
+	.set8 = kvm_set8,
+	VIRTIO_CONFIG_OPS_NOCONV,
 	.get_status = kvm_get_status,
 	.set_status = kvm_set_status,
 	.reset = kvm_reset,
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 2029b6c..3652473 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -472,6 +472,7 @@ out_free:
 	kfree(ccw);
 }
 
+/* We don't need to do endian conversion, as it's always big endian like us */
 static void virtio_ccw_get_config(struct virtio_device *vdev,
 				  unsigned int offset, void *buf, unsigned len)
 {
@@ -505,6 +506,21 @@ out_free:
 	kfree(ccw);
 }
 
+
+#define VIRTIO_CCW_GET_CONFIGx(bits)					\
+static u##bits virtio_ccw_get_config##bits(struct virtio_device *vdev,	\
+					   unsigned int offset)		\
+{									\
+	u##bits v;							\
+	virtio_ccw_get_config(vdev, offset, &v, sizeof(v));		\
+	return v;							\
+}
+
+VIRTIO_CCW_GET_CONFIGx(8)
+VIRTIO_CCW_GET_CONFIGx(16)
+VIRTIO_CCW_GET_CONFIGx(32)
+VIRTIO_CCW_GET_CONFIGx(64)
+
 static void virtio_ccw_set_config(struct virtio_device *vdev,
 				  unsigned int offset, const void *buf,
 				  unsigned len)
@@ -535,6 +551,19 @@ out_free:
 	kfree(ccw);
 }
 
+#define VIRTIO_CCW_SET_CONFIGx(bits)					\
+static void virtio_ccw_set_config##bits(struct virtio_device *vdev,	\
+					unsigned int offset,		\
+					u##bits v)			\
+{									\
+	virtio_ccw_set_config(vdev, offset, &v, sizeof(v));		\
+}
+
+VIRTIO_CCW_SET_CONFIGx(8)
+VIRTIO_CCW_SET_CONFIGx(16)
+VIRTIO_CCW_SET_CONFIGx(32)
+VIRTIO_CCW_SET_CONFIGx(64)
+
 static u8 virtio_ccw_get_status(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
@@ -564,8 +593,14 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
 static struct virtio_config_ops virtio_ccw_config_ops = {
 	.get_features = virtio_ccw_get_features,
 	.finalize_features = virtio_ccw_finalize_features,
-	.get = virtio_ccw_get_config,
-	.set = virtio_ccw_set_config,
+	.get8 = virtio_ccw_get_config8,
+	.set8 = virtio_ccw_set_config8,
+	.get16 = virtio_ccw_get_config16,
+	.set16 = virtio_ccw_set_config16,
+	.get32 = virtio_ccw_get_config32,
+	.set32 = virtio_ccw_set_config32,
+	.get64 = virtio_ccw_get_config64,
+	.set64 = virtio_ccw_set_config64,
 	.get_status = virtio_ccw_get_status,
 	.set_status = virtio_ccw_set_status,
 	.reset = virtio_ccw_reset,
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 1ba0d68..4c2c6be 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -167,26 +167,18 @@ static void vm_finalize_features(struct virtio_device *vdev)
 	}
 }
 
-static void vm_get(struct virtio_device *vdev, unsigned offset,
-		   void *buf, unsigned len)
+static u8 vm_get8(struct virtio_device *vdev, unsigned offset)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	u8 *ptr = buf;
-	int i;
 
-	for (i = 0; i < len; i++)
-		ptr[i] = readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+	return readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset);
 }
 
-static void vm_set(struct virtio_device *vdev, unsigned offset,
-		   const void *buf, unsigned len)
+static void vm_set8(struct virtio_device *vdev, unsigned offset, u8 v)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	const u8 *ptr = buf;
-	int i;
 
-	for (i = 0; i < len; i++)
-		writeb(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+	writeb(v, vm_dev->base + VIRTIO_MMIO_CONFIG + offset);
 }
 
 static u8 vm_get_status(struct virtio_device *vdev)
@@ -424,8 +416,9 @@ static const char *vm_bus_name(struct virtio_device *vdev)
 }
 
 static const struct virtio_config_ops virtio_mmio_config_ops = {
-	.get		= vm_get,
-	.set		= vm_set,
+	.get8		= vm_get8,
+	.set8		= vm_set8,
+	VIRTIO_CONFIG_OPS_NOCONV,
 	.get_status	= vm_get_status,
 	.set_status	= vm_set_status,
 	.reset		= vm_reset,
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a7ce730..fc01b77 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -127,33 +127,23 @@ static void vp_finalize_features(struct virtio_device *vdev)
 	iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
 }
 
-/* virtio config->get() implementation */
-static void vp_get(struct virtio_device *vdev, unsigned offset,
-		   void *buf, unsigned len)
+/* Device config access: we use guest endian, as per spec. */
+static u8 vp_get8(struct virtio_device *vdev, unsigned offset)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
 				VIRTIO_PCI_CONFIG(vp_dev) + offset;
-	u8 *ptr = buf;
-	int i;
 
-	for (i = 0; i < len; i++)
-		ptr[i] = ioread8(ioaddr + i);
+	return ioread8(ioaddr);
 }
 
-/* the config->set() implementation.  it's symmetric to the config->get()
- * implementation */
-static void vp_set(struct virtio_device *vdev, unsigned offset,
-		   const void *buf, unsigned len)
+static void vp_set8(struct virtio_device *vdev, unsigned offset, u8 v)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 	void __iomem *ioaddr = vp_dev->ioaddr +
 				VIRTIO_PCI_CONFIG(vp_dev) + offset;
-	const u8 *ptr = buf;
-	int i;
 
-	for (i = 0; i < len; i++)
-		iowrite8(ptr[i], ioaddr + i);
+	iowrite8(v, ioaddr);
 }
 
 /* config->{get,set}_status() implementations */
@@ -653,8 +643,9 @@ static int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
-	.get		= vp_get,
-	.set		= vp_set,
+	.get8		= vp_get8,
+	.set8		= vp_set8,
+	VIRTIO_CONFIG_OPS_NOCONV,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index 12a777f..b7aa3b1 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -8,16 +8,30 @@
 
 /**
  * virtio_config_ops - operations for configuring a virtio device
- * @get: read the value of a configuration field
+ * @get8: read a byte from a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
- *	buf: the buffer to write the field value into.
- *	len: the length of the buffer
- * @set: write the value of a configuration field
+ * @set8: write a byte to a configuration field
+ *	vdev: the virtio_device
+ *	offset: the offset of the configuration field
+ * @get16: read a short from a configuration field
+ *	vdev: the virtio_device
+ *	offset: the offset of the configuration field
+ * @set16: write a short to a configuration field
+ *	vdev: the virtio_device
+ *	offset: the offset of the configuration field
+ * @get32: read a u32 from a configuration field
+ *	vdev: the virtio_device
+ *	offset: the offset of the configuration field
+ * @set32: write a u32 to a configuration field
+ *	vdev: the virtio_device
+ *	offset: the offset of the configuration field
+ * @get64: read a u64 from a configuration field
+ *	vdev: the virtio_device
+ *	offset: the offset of the configuration field
+ * @set64: write a u64 to a configuration field
  *	vdev: the virtio_device
  *	offset: the offset of the configuration field
- *	buf: the buffer to read the field value from.
- *	len: the length of the buffer
  * @get_status: read the status byte
  *	vdev: the virtio_device
  *	Returns the status byte
@@ -54,10 +68,14 @@
  */
 typedef void vq_callback_t(struct virtqueue *);
 struct virtio_config_ops {
-	void (*get)(struct virtio_device *vdev, unsigned offset,
-		    void *buf, unsigned len);
-	void (*set)(struct virtio_device *vdev, unsigned offset,
-		    const void *buf, unsigned len);
+	u8 (*get8)(struct virtio_device *vdev, unsigned offset);
+	void (*set8)(struct virtio_device *vdev, unsigned offset, u8 val);
+	u16 (*get16)(struct virtio_device *vdev, unsigned offset);
+	void (*set16)(struct virtio_device *vdev, unsigned offset, u16 val);
+	u32 (*get32)(struct virtio_device *vdev, unsigned offset);
+	void (*set32)(struct virtio_device *vdev, unsigned offset, u32 val);
+	u64 (*get64)(struct virtio_device *vdev, unsigned offset);
+	void (*set64)(struct virtio_device *vdev, unsigned offset, u64 val);
 	u8 (*get_status)(struct virtio_device *vdev);
 	void (*set_status)(struct virtio_device *vdev, u8 status);
 	void (*reset)(struct virtio_device *vdev);
@@ -199,64 +217,62 @@ int virtqueue_set_affinity(struct virtqueue *vq, int cpu)
 
 static inline u8 virtio_cread8(struct virtio_device *vdev, unsigned int offset)
 {
-	u8 ret;
-	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return vdev->config->get8(vdev, offset);
 }
 
 static inline void virtio_cread_bytes(struct virtio_device *vdev,
 				      unsigned int offset,
 				      void *buf, size_t len)
 {
-	vdev->config->get(vdev, offset, buf, len);
+	u8 *dst = buf;
+	while (len) {
+		*dst = vdev->config->get8(vdev, offset);
+		dst++;
+		offset++;
+		len--;
+	}
 }
 
 static inline void virtio_cwrite8(struct virtio_device *vdev,
 				  unsigned int offset, u8 val)
 {
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	vdev->config->set8(vdev, offset, val);
 }
 
 static inline u16 virtio_cread16(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u16 ret;
-	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return vdev->config->get16(vdev, offset);
 }
 
 static inline void virtio_cwrite16(struct virtio_device *vdev,
 				   unsigned int offset, u16 val)
 {
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	vdev->config->set16(vdev, offset, val);
 }
 
 static inline u32 virtio_cread32(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u32 ret;
-	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return vdev->config->get32(vdev, offset);
 }
 
 static inline void virtio_cwrite32(struct virtio_device *vdev,
 				   unsigned int offset, u32 val)
 {
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	vdev->config->set32(vdev, offset, val);
 }
 
 static inline u64 virtio_cread64(struct virtio_device *vdev,
 				 unsigned int offset)
 {
-	u64 ret;
-	vdev->config->get(vdev, offset, &ret, sizeof(ret));
-	return ret;
+	return vdev->config->get64(vdev, offset);
 }
 
 static inline void virtio_cwrite64(struct virtio_device *vdev,
 				   unsigned int offset, u64 val)
 {
-	vdev->config->set(vdev, offset, &val, sizeof(val));
+	vdev->config->set64(vdev, offset, val);
 }
 
 /* Conditional config space accessors. */
-- 
1.7.10.4
