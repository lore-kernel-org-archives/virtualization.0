From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 2/11] virtio: add support for 64 bit features.
Date: Thu, 08 Dec 2011 21:01:48 +1030
Message-ID: <87k467gxrf.fsf@rustcorp.com.au>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pqfzgy6p.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization <virtualization@lists.linux-foundation.org>
Cc: Sasha Levin <levinsasha928@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Change the u32 to a u64, and make sure to use 1ULL everywhere!
---
 drivers/char/virtio_console.c  |    2 +-
 drivers/lguest/lguest_device.c |   10 +++++-----
 drivers/s390/kvm/kvm_virtio.c  |   10 +++++-----
 drivers/virtio/virtio.c        |   12 ++++++------
 drivers/virtio/virtio_mmio.c   |   14 +++++++++-----
 drivers/virtio/virtio_pci.c    |    5 ++---
 drivers/virtio/virtio_ring.c   |    2 +-
 include/linux/virtio.h         |    2 +-
 include/linux/virtio_config.h  |    8 ++++----
 tools/virtio/linux/virtio.h    |    4 ++--
 10 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -331,7 +331,7 @@ static inline bool use_multiport(struct 
 	 */
 	if (!portdev->vdev)
 		return 0;
-	return portdev->vdev->features & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+	return portdev->vdev->features & (1ULL << VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
 static void free_buf(struct port_buffer *buf)
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -94,17 +94,17 @@ static unsigned desc_size(const struct l
 }
 
 /* This gets the device's feature bits. */
-static u32 lg_get_features(struct virtio_device *vdev)
+static u64 lg_get_features(struct virtio_device *vdev)
 {
 	unsigned int i;
-	u32 features = 0;
+	u64 features = 0;
 	struct lguest_device_desc *desc = to_lgdev(vdev)->desc;
 	u8 *in_features = lg_features(desc);
 
 	/* We do this the slow but generic way. */
-	for (i = 0; i < min(desc->feature_len * 8, 32); i++)
+	for (i = 0; i < min(desc->feature_len * 8, 64); i++)
 		if (in_features[i / 8] & (1 << (i % 8)))
-			features |= (1 << i);
+			features |= (1ULL << i);
 
 	return features;
 }
@@ -144,7 +144,7 @@ static void lg_finalize_features(struct 
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++) {
-		if (vdev->features & (1 << i))
+		if (vdev->features & (1ULL << i))
 			out_features[i / 8] |= (1 << (i % 8));
 	}
 
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -79,16 +79,16 @@ static unsigned desc_size(const struct k
 }
 
 /* This gets the device's feature bits. */
-static u32 kvm_get_features(struct virtio_device *vdev)
+static u64 kvm_get_features(struct virtio_device *vdev)
 {
 	unsigned int i;
-	u32 features = 0;
+	u64 features = 0;
 	struct kvm_device_desc *desc = to_kvmdev(vdev)->desc;
 	u8 *in_features = kvm_vq_features(desc);
 
-	for (i = 0; i < min(desc->feature_len * 8, 32); i++)
+	for (i = 0; i < min(desc->feature_len * 8, 64); i++)
 		if (in_features[i / 8] & (1 << (i % 8)))
-			features |= (1 << i);
+			features |= (1ULL << i);
 	return features;
 }
 
@@ -105,7 +105,7 @@ static void kvm_finalize_features(struct
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++) {
-		if (vdev->features & (1 << i))
+		if (vdev->features & (1ULL << i))
 			out_features[i / 8] |= (1 << (i % 8));
 	}
 }
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -113,7 +113,7 @@ static int virtio_dev_probe(struct devic
 	struct virtio_device *dev = container_of(_d,struct virtio_device,dev);
 	struct virtio_driver *drv = container_of(dev->dev.driver,
 						 struct virtio_driver, driver);
-	u32 device_features;
+	u64 device_features;
 
 	/* We have a driver! */
 	add_status(dev, VIRTIO_CONFIG_S_DRIVER);
@@ -125,15 +125,15 @@ static int virtio_dev_probe(struct devic
 	dev->features = 0;
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
-		BUG_ON(f >= 32);
-		if (device_features & (1 << f))
-			dev->features |= (1 << f);
+		BUG_ON(f >= 64);
+		if (device_features & (1ULL << f))
+			dev->features |= (1ULL << f);
 	}
 
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
-		if (device_features & (1 << i))
-			dev->features |= (1 << i);
+		if (device_features & (1ULL << i))
+			dev->features |= (1ULL << i);
 
 	dev->config->finalize_features(dev);
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -99,14 +99,16 @@ struct virtio_mmio_vq_info {
 
 /* Configuration interface */
 
-static u32 vm_get_features(struct virtio_device *vdev)
+static u64 vm_get_features(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
+	u64 features;
 
-	/* TODO: Features > 32 bits */
 	writel(0, vm_dev->base + VIRTIO_MMIO_HOST_FEATURES_SEL);
-
-	return readl(vm_dev->base + VIRTIO_MMIO_HOST_FEATURES);
+	features = readl(vm_dev->base + VIRTIO_MMIO_HOST_FEATURES);
+	writel(1, vm_dev->base + VIRTIO_MMIO_HOST_FEATURES_SEL);
+	features |= ((u64)readl(vm_dev->base + VIRTIO_MMIO_HOST_FEATURES) << 32);
+	return features;
 }
 
 static void vm_finalize_features(struct virtio_device *vdev)
@@ -117,7 +119,9 @@ static void vm_finalize_features(struct 
 	vring_transport_features(vdev);
 
 	writel(0, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
-	writel(vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
+	writel((u32)vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
+	writel(1, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
+	writel(vdev->features >> 32, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
 }
 
 static void vm_get(struct virtio_device *vdev, unsigned offset,
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -103,12 +103,11 @@ static struct virtio_pci_device *to_vp_d
 }
 
 /* virtio config->get_features() implementation */
-static u32 vp_get_features(struct virtio_device *vdev)
+static u64 vp_get_features(struct virtio_device *vdev)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-	/* When someone needs more than 32 feature bits, we'll need to
-	 * steal a bit to indicate that the rest are somewhere else. */
+	/* We only support 32 feature bits. */
 	return ioread32(vp_dev->ioaddr + VIRTIO_PCI_HOST_FEATURES);
 }
 
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -685,7 +685,7 @@ void vring_transport_features(struct vir
 			break;
 		default:
 			/* We don't understand this bit. */
-			vdev->features &= ~(1 << i);
+			vdev->features &= ~(1ULL << i);
 		}
 	}
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -66,7 +66,7 @@ struct virtio_device {
 	struct virtio_device_id id;
 	struct virtio_config_ops *config;
 	struct list_head vqs;
-	u32 features;
+	u64 features;
 	void *priv;
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -117,7 +117,7 @@ struct virtio_config_ops {
 			vq_callback_t *callbacks[],
 			const char *names[]);
 	void (*del_vqs)(struct virtio_device *);
-	u32 (*get_features)(struct virtio_device *vdev);
+	u64 (*get_features)(struct virtio_device *vdev);
 	void (*finalize_features)(struct virtio_device *vdev);
 };
 
@@ -135,14 +135,14 @@ static inline bool virtio_has_feature(co
 {
 	/* Did you forget to fix assumptions on max features? */
 	if (__builtin_constant_p(fbit))
-		BUILD_BUG_ON(fbit >= 32);
+		BUILD_BUG_ON(fbit >= 64);
 	else
-		BUG_ON(fbit >= 32);
+		BUG_ON(fbit >= 64);
 
 	if (fbit < VIRTIO_TRANSPORT_F_START)
 		virtio_check_driver_offered_feature(vdev, fbit);
 
-	return vdev->features & (1 << fbit);
+	return vdev->features & (1ULL << fbit);
 }
 
 /**
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -134,12 +134,12 @@ static inline void kfree(void *p)
 
 /* The only feature we care to support */
 #define virtio_has_feature(dev, feature) \
-	((dev)->features & (1 << (feature)))
+	((dev)->features & (1ULL << (feature)))
 /* end of stubs */
 
 struct virtio_device {
 	void *dev;
-	u32 features;
+	u64 features;
 };
 
 struct virtqueue {
