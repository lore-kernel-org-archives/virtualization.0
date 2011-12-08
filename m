From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [RFC 1/11] virtio: use u32,
	not bitmap for struct virtio_device's features
Date: Thu, 08 Dec 2011 21:00:39 +1030
Message-ID: <87mxb3gxtc.fsf@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, Sasha Levin <levinsasha928@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

It seemed like a good idea, but it's actually a pain when we get more
than 32 feature bits.  Just change it to a u32 for now.
---
 drivers/char/virtio_console.c  |    2 +-
 drivers/lguest/lguest_device.c |    2 +-
 drivers/s390/kvm/kvm_virtio.c  |    2 +-
 drivers/virtio/virtio.c        |   10 +++++-----
 drivers/virtio/virtio_mmio.c   |    8 ++------
 drivers/virtio/virtio_pci.c    |    3 +--
 drivers/virtio/virtio_ring.c   |    2 +-
 include/linux/virtio.h         |    3 +--
 include/linux/virtio_config.h  |    2 +-
 tools/virtio/linux/virtio.h    |   18 ++----------------
 tools/virtio/virtio_test.c     |    5 ++---
 11 files changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -331,7 +331,7 @@ static inline bool use_multiport(struct 
 	 */
 	if (!portdev->vdev)
 		return 0;
-	return portdev->vdev->features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+	return portdev->vdev->features & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
 static void free_buf(struct port_buffer *buf)
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -144,7 +144,7 @@ static void lg_finalize_features(struct 
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++) {
-		if (test_bit(i, vdev->features))
+		if (vdev->features & (1 << i))
 			out_features[i / 8] |= (1 << (i % 8));
 	}
 
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -105,7 +105,7 @@ static void kvm_finalize_features(struct
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++) {
-		if (test_bit(i, vdev->features))
+		if (vdev->features & (1 << i))
 			out_features[i / 8] |= (1 << (i % 8));
 	}
 }
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -41,9 +41,9 @@ static ssize_t features_show(struct devi
 
 	/* We actually represent this as a bitstring, as it could be
 	 * arbitrary length in future. */
-	for (i = 0; i < ARRAY_SIZE(dev->features)*BITS_PER_LONG; i++)
+	for (i = 0; i < sizeof(dev->features)*8; i++)
 		len += sprintf(buf+len, "%c",
-			       test_bit(i, dev->features) ? '1' : '0');
+			       dev->features & (1ULL << i) ? '1' : '0');
 	len += sprintf(buf+len, "\n");
 	return len;
 }
@@ -122,18 +122,18 @@ static int virtio_dev_probe(struct devic
 	device_features = dev->config->get_features(dev);
 
 	/* Features supported by both device and driver into dev->features. */
-	memset(dev->features, 0, sizeof(dev->features));
+	dev->features = 0;
 	for (i = 0; i < drv->feature_table_size; i++) {
 		unsigned int f = drv->feature_table[i];
 		BUG_ON(f >= 32);
 		if (device_features & (1 << f))
-			set_bit(f, dev->features);
+			dev->features |= (1 << f);
 	}
 
 	/* Transport features always preserved to pass to finalize_features. */
 	for (i = VIRTIO_TRANSPORT_F_START; i < VIRTIO_TRANSPORT_F_END; i++)
 		if (device_features & (1 << i))
-			set_bit(i, dev->features);
+			dev->features |= (1 << i);
 
 	dev->config->finalize_features(dev);
 
diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -112,16 +112,12 @@ static u32 vm_get_features(struct virtio
 static void vm_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	int i;
 
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	for (i = 0; i < ARRAY_SIZE(vdev->features); i++) {
-		writel(i, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
-		writel(vdev->features[i],
-				vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
-	}
+	writel(0, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES_SEL);
+	writel(vdev->features, vm_dev->base + VIRTIO_MMIO_GUEST_FEATURES);
 }
 
 static void vm_get(struct virtio_device *vdev, unsigned offset,
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -121,8 +121,7 @@ static void vp_finalize_features(struct 
 	vring_transport_features(vdev);
 
 	/* We only support 32 feature bits. */
-	BUILD_BUG_ON(ARRAY_SIZE(vdev->features) != 1);
-	iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
+	iowrite32(vdev->features, vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
 }
 
 /* virtio config->get() implementation */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -685,7 +685,7 @@ void vring_transport_features(struct vir
 			break;
 		default:
 			/* We don't understand this bit. */
-			clear_bit(i, vdev->features);
+			vdev->features &= ~(1 << i);
 		}
 	}
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -66,8 +66,7 @@ struct virtio_device {
 	struct virtio_device_id id;
 	struct virtio_config_ops *config;
 	struct list_head vqs;
-	/* Note that this is a Linux set_bit-style bitmap. */
-	unsigned long features[1];
+	u32 features;
 	void *priv;
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -142,7 +142,7 @@ static inline bool virtio_has_feature(co
 	if (fbit < VIRTIO_TRANSPORT_F_START)
 		virtio_check_driver_offered_feature(vdev, fbit);
 
-	return test_bit(fbit, vdev->features);
+	return vdev->features & (1 << fbit);
 }
 
 /**
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -131,29 +131,15 @@ static inline void kfree(void *p)
 #define BITS_PER_BYTE		8
 #define BITS_PER_LONG (sizeof(long) * BITS_PER_BYTE)
 #define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-/* TODO: Not atomic as it should be:
- * we don't use this for anything important. */
-static inline void clear_bit(int nr, volatile unsigned long *addr)
-{
-	unsigned long mask = BIT_MASK(nr);
-	unsigned long *p = ((unsigned long *)addr) + BIT_WORD(nr);
-
-	*p &= ~mask;
-}
-
-static inline int test_bit(int nr, const volatile unsigned long *addr)
-{
-        return 1UL & (addr[BIT_WORD(nr)] >> (nr & (BITS_PER_LONG-1)));
-}
 
 /* The only feature we care to support */
 #define virtio_has_feature(dev, feature) \
-	test_bit((feature), (dev)->features)
+	((dev)->features & (1 << (feature)))
 /* end of stubs */
 
 struct virtio_device {
 	void *dev;
-	unsigned long features[1];
+	u32 features;
 };
 
 struct virtqueue {
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -55,7 +55,7 @@ void vhost_vq_setup(struct vdev_info *de
 {
 	struct vhost_vring_state state = { .index = info->idx };
 	struct vhost_vring_file file = { .index = info->idx };
-	unsigned long long features = dev->vdev.features[0];
+	unsigned long long features = dev->vdev.features;
 	struct vhost_vring_addr addr = {
 		.index = info->idx,
 		.desc_user_addr = (uint64_t)(unsigned long)info->vring.desc,
@@ -106,8 +106,7 @@ static void vdev_info_init(struct vdev_i
 {
 	int r;
 	memset(dev, 0, sizeof *dev);
-	dev->vdev.features[0] = features;
-	dev->vdev.features[1] = features >> 32;
+	dev->vdev.features = features;
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
