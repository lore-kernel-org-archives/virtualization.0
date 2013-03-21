From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 03/22] virtio_config: make transports implement accessors.
Date: Thu, 21 Mar 2013 18:59:24 +1030
Message-ID: <1363854584-25795-4-git-send-email-rusty@rustcorp.com.au>
References: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1363854584-25795-1-git-send-email-rusty@rustcorp.com.au>
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

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/lguest/lguest_device.c |   79 ++++++++++++++++++++++++++++++++++------
 drivers/net/caif/caif_virtio.c |    2 +-
 drivers/s390/kvm/kvm_virtio.c  |   78 +++++++++++++++++++++++++++++++++------
 drivers/s390/kvm/virtio_ccw.c  |   39 +++++++++++++++++++-
 drivers/virtio/virtio_mmio.c   |   35 +++++++++++++++++-
 drivers/virtio/virtio_pci.c    |   39 +++++++++++++++++---
 include/linux/virtio_config.h  |   70 +++++++++++++++++++++--------------
 7 files changed, 283 insertions(+), 59 deletions(-)

diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index b3256ff..8554d41 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -153,25 +153,76 @@ static void lg_finalize_features(struct virtio_device *vdev)
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
+}
+
+static u16 lg_get16(struct virtio_device *vdev, unsigned int offset)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u16) > desc->config_len);
+	return *(u16 *)(lg_config(desc) + offset);
+}
+
+static void lg_set16(struct virtio_device *vdev, unsigned int offset, u16 val)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u16 *)(lg_config(desc) + offset) = val;
+}
+
+static u32 lg_get32(struct virtio_device *vdev, unsigned int offset)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u32) > desc->config_len);
+	return *(u32 *)(lg_config(desc) + offset);
+}
+
+static void lg_set32(struct virtio_device *vdev, unsigned int offset, u32 val)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u32 *)(lg_config(desc) + offset) = val;
+}
+
+static u64 lg_get64(struct virtio_device *vdev, unsigned int offset)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u64) > desc->config_len);
+	return *(u64 *)(lg_config(desc) + offset);
+}
+
+static void lg_set64(struct virtio_device *vdev, unsigned int offset, u64 val)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u64 *)(lg_config(desc) + offset) = val;
 }
 
 /*
@@ -399,8 +450,14 @@ static const char *lg_bus_name(struct virtio_device *vdev)
 static const struct virtio_config_ops lguest_config_ops = {
 	.get_features = lg_get_features,
 	.finalize_features = lg_finalize_features,
-	.get = lg_get,
-	.set = lg_set,
+	.get8 = lg_get8,
+	.set8 = lg_set8,
+	.get16 = lg_get16,
+	.set16 = lg_set16,
+	.get32 = lg_get32,
+	.set32 = lg_set32,
+	.get64 = lg_get64,
+	.set64 = lg_set64,
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
index 6711e65..dcf35b1 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -112,26 +112,82 @@ static void kvm_finalize_features(struct virtio_device *vdev)
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
-	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 
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
-	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u8 *)(kvm_vq_configspace(desc) + offset) = val;
+}
+
+static u16 kvm_get16(struct virtio_device *vdev, unsigned int offset)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u16) > desc->config_len);
+	return *(u16 *)(kvm_vq_configspace(desc) + offset);
+}
+
+static void kvm_set16(struct virtio_device *vdev, unsigned int offset, u16 val)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u16 *)(kvm_vq_configspace(desc) + offset) = val;
+}
+
+static u32 kvm_get32(struct virtio_device *vdev, unsigned int offset)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 
-	BUG_ON(offset + len > desc->config_len);
-	memcpy(kvm_vq_configspace(desc) + offset, buf, len);
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u32) > desc->config_len);
+	return *(u32 *)(kvm_vq_configspace(desc) + offset);
 }
 
+static void kvm_set32(struct virtio_device *vdev, unsigned int offset, u32 val)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u32 *)(kvm_vq_configspace(desc) + offset) = val;
+}
+
+static u64 kvm_get64(struct virtio_device *vdev, unsigned int offset)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(u64) > desc->config_len);
+	return *(u64 *)(kvm_vq_configspace(desc) + offset);
+}
+
+static void kvm_set64(struct virtio_device *vdev, unsigned int offset, u64 val)
+{
+	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
+
+	/* Check they didn't ask for more than the length of the config! */
+	BUG_ON(offset + sizeof(val) > desc->config_len);
+	*(u64 *)(kvm_vq_configspace(desc) + offset) = val;
+}
+
+
 /*
  * The operations to get and set the status word just access
  * the status field of the device descriptor. set_status will also
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
index 1ba0d68..ad7f38f 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -178,6 +178,19 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
 		ptr[i] = readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
 }
 
+#define VM_GETx(bits)							\
+static u##bits vm_get##bits(struct virtio_device *vdev, unsigned int offset) \
+{									\
+	u##bits v;							\
+	vm_get(vdev, offset, &v, sizeof(v));				\
+	return v;							\
+}
+
+VM_GETx(8)
+VM_GETx(16)
+VM_GETx(32)
+VM_GETx(64)
+
 static void vm_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
@@ -189,6 +202,18 @@ static void vm_set(struct virtio_device *vdev, unsigned offset,
 		writeb(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
 }
 
+#define VM_SETx(bits)							\
+static void vm_set##bits(struct virtio_device *vdev, unsigned int offset, \
+			 u##bits v)					\
+{									\
+	vm_set(vdev, offset, &v, sizeof(v));				\
+}
+
+VM_SETx(8)
+VM_SETx(16)
+VM_SETx(32)
+VM_SETx(64)
+
 static u8 vm_get_status(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
@@ -424,8 +449,14 @@ static const char *vm_bus_name(struct virtio_device *vdev)
 }
 
 static const struct virtio_config_ops virtio_mmio_config_ops = {
-	.get		= vm_get,
-	.set		= vm_set,
+	.get8		= vm_get8,
+	.set8		= vm_set8,
+	.get16		= vm_get16,
+	.set16		= vm_set16,
+	.get32		= vm_get32,
+	.set32		= vm_set32,
+	.get64		= vm_get64,
+	.set64		= vm_set64,
 	.get_status	= vm_get_status,
 	.set_status	= vm_set_status,
 	.reset		= vm_reset,
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index a7ce730..96a988b 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -127,7 +127,7 @@ static void vp_finalize_features(struct virtio_device *vdev)
 	iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
 }
 
-/* virtio config->get() implementation */
+/* Device config access: we use guest endian, as per spec. */
 static void vp_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
@@ -141,8 +141,19 @@ static void vp_get(struct virtio_device *vdev, unsigned offset,
 		ptr[i] = ioread8(ioaddr + i);
 }
 
-/* the config->set() implementation.  it's symmetric to the config->get()
- * implementation */
+#define VP_GETx(bits)							\
+static u##bits vp_get##bits(struct virtio_device *vdev, unsigned int offset) \
+{									\
+	u##bits v;							\
+	vp_get(vdev, offset, &v, sizeof(v));				\
+	return v;							\
+}
+
+VP_GETx(8)
+VP_GETx(16)
+VP_GETx(32)
+VP_GETx(64)
+
 static void vp_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
@@ -156,6 +167,18 @@ static void vp_set(struct virtio_device *vdev, unsigned offset,
 		iowrite8(ptr[i], ioaddr + i);
 }
 
+#define VP_SETx(bits)							\
+static void vp_set##bits(struct virtio_device *vdev, unsigned int offset, \
+			 u##bits v)					\
+{									\
+	vp_set(vdev, offset, &v, sizeof(v));				\
+}
+
+VP_SETx(8)
+VP_SETx(16)
+VP_SETx(32)
+VP_SETx(64)
+
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
 {
@@ -653,8 +676,14 @@ static int vp_set_vq_affinity(struct virtqueue *vq, int cpu)
 }
 
 static const struct virtio_config_ops virtio_pci_config_ops = {
-	.get		= vp_get,
-	.set		= vp_set,
+	.get8		= vp_get8,
+	.set8		= vp_set8,
+	.get16		= vp_get16,
+	.set16		= vp_set16,
+	.get32		= vp_get32,
+	.set32		= vp_set32,
+	.get64		= vp_get64,
+	.set64		= vp_set64,
 	.get_status	= vp_get_status,
 	.set_status	= vp_set_status,
 	.reset		= vp_reset,
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index e8f8f71..73841ee 100644
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
