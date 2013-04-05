From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 5/7] virtio: use u32,
	not bitmap for struct virtio_device's features
Date: Fri,  5 Apr 2013 14:07:03 +1030
Message-ID: <1365133025-5397-6-git-send-email-rusty@rustcorp.com.au>
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
Cc: Brian Swetland <swetland@google.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

It seemed like a good idea, but it's actually a pain when we get more
than 32 feature bits.  Just change it to a u32 for now.

Cc: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Brian Swetland <swetland@google.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Acked-by: Pawel Moll <pawel.moll@arm.com>
---
 drivers/char/virtio_console.c          |    2 +-
 drivers/lguest/lguest_device.c         |    8 ++++----
 drivers/remoteproc/remoteproc_virtio.c |    2 +-
 drivers/s390/kvm/kvm_virtio.c          |    2 +-
 drivers/s390/kvm/virtio_ccw.c          |   23 +++++++++--------------
 drivers/virtio/virtio.c                |   10 +++++-----
 drivers/virtio/virtio_mmio.c           |    8 ++------
 drivers/virtio/virtio_pci.c            |    3 +--
 drivers/virtio/virtio_ring.c           |    2 +-
 include/linux/virtio.h                 |    3 +--
 include/linux/virtio_config.h          |    2 +-
 tools/virtio/linux/virtio.h            |   22 +---------------------
 tools/virtio/linux/virtio_config.h     |    2 +-
 tools/virtio/virtio_test.c             |    5 ++---
 tools/virtio/vringh_test.c             |   16 ++++++++--------
 15 files changed, 39 insertions(+), 71 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 1735c38..9d9f717 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -351,7 +351,7 @@ static inline bool use_multiport(struct ports_device *portdev)
 	 */
 	if (!portdev->vdev)
 		return 0;
-	return portdev->vdev->features[0] & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
+	return portdev->vdev->features & (1 << VIRTIO_CONSOLE_F_MULTIPORT);
 }
 
 static DEFINE_SPINLOCK(dma_bufs_lock);
diff --git a/drivers/lguest/lguest_device.c b/drivers/lguest/lguest_device.c
index baee77e..9528e64 100644
--- a/drivers/lguest/lguest_device.c
+++ b/drivers/lguest/lguest_device.c
@@ -137,14 +137,14 @@ static void lg_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/*
-	 * The vdev->feature array is a Linux bitmask: this isn't the same as a
-	 * the simple array of bits used by lguest devices for features.  So we
-	 * do this slow, manual conversion which is completely general.
+	 * Since lguest is currently x86-only, we're little-endian.  That
+	 * means we could just memcpy.  But it's not time critical, and in
+	 * case someone copies this code, we do it the slow, obvious way.
 	 */
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++) {
-		if (test_bit(i, vdev->features))
+		if (vdev->features & (1 << i))
 			out_features[i / 8] |= (1 << (i % 8));
 	}
 
diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/remoteproc_virtio.c
index afed9b7..fb8faee 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -219,7 +219,7 @@ static void rproc_virtio_finalize_features(struct virtio_device *vdev)
 	 * fixed as part of a small resource table overhaul and then an
 	 * extension of the virtio resource entries.
 	 */
-	rvdev->gfeatures = vdev->features[0];
+	rvdev->gfeatures = vdev->features;
 }
 
 static const struct virtio_config_ops rproc_virtio_config_ops = {
diff --git a/drivers/s390/kvm/kvm_virtio.c b/drivers/s390/kvm/kvm_virtio.c
index cde64d5..8779224 100644
--- a/drivers/s390/kvm/kvm_virtio.c
+++ b/drivers/s390/kvm/kvm_virtio.c
@@ -106,7 +106,7 @@ static void kvm_finalize_features(struct virtio_device *vdev)
 	memset(out_features, 0, desc->feature_len);
 	bits = min_t(unsigned, desc->feature_len, sizeof(vdev->features)) * 8;
 	for (i = 0; i < bits; i++) {
-		if (test_bit(i, vdev->features))
+		if (vdev->features & (1 << i))
 			out_features[i / 8] |= (1 << (i % 8));
 	}
 }
diff --git a/drivers/s390/kvm/virtio_ccw.c b/drivers/s390/kvm/virtio_ccw.c
index 3652473..8c564bf 100644
--- a/drivers/s390/kvm/virtio_ccw.c
+++ b/drivers/s390/kvm/virtio_ccw.c
@@ -440,7 +440,6 @@ static void virtio_ccw_finalize_features(struct virtio_device *vdev)
 {
 	struct virtio_ccw_device *vcdev = to_vc_device(vdev);
 	struct virtio_feature_desc *features;
-	int i;
 	struct ccw1 *ccw;
 
 	ccw = kzalloc(sizeof(*ccw), GFP_DMA | GFP_KERNEL);
@@ -454,19 +453,15 @@ static void virtio_ccw_finalize_features(struct virtio_device *vdev)
 	/* Give virtio_ring a chance to accept features. */
 	vring_transport_features(vdev);
 
-	for (i = 0; i < sizeof(*vdev->features) / sizeof(features->features);
-	     i++) {
-		int highbits = i % 2 ? 32 : 0;
-		features->index = i;
-		features->features = cpu_to_le32(vdev->features[i / 2]
-						 >> highbits);
-		/* Write the feature bits to the host. */
-		ccw->cmd_code = CCW_CMD_WRITE_FEAT;
-		ccw->flags = 0;
-		ccw->count = sizeof(*features);
-		ccw->cda = (__u32)(unsigned long)features;
-		ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
-	}
+	features->index = 0;
+	features->features = cpu_to_le32(vdev->features);
+	/* Write the feature bits to the host. */
+	ccw->cmd_code = CCW_CMD_WRITE_FEAT;
+	ccw->flags = 0;
+	ccw->count = sizeof(*features);
+	ccw->cda = (__u32)(unsigned long)features;
+	ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_FEAT);
+
 out_free:
 	kfree(features);
 	kfree(ccw);
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index 2b154f3..8ebe913 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -41,9 +41,9 @@ static ssize_t features_show(struct device *_d,
 
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
@@ -120,18 +120,18 @@ static int virtio_dev_probe(struct device *_d)
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
index 4c2c6be..24d583a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -155,16 +155,12 @@ static u32 vm_get_features(struct virtio_device *vdev)
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
 
 static u8 vm_get8(struct virtio_device *vdev, unsigned offset)
diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index fc01b77..aa85fdd 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -123,8 +123,7 @@ static void vp_finalize_features(struct virtio_device *vdev)
 	vring_transport_features(vdev);
 
 	/* We only support 32 feature bits. */
-	BUILD_BUG_ON(ARRAY_SIZE(vdev->features) != 1);
-	iowrite32(vdev->features[0], vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
+	iowrite32(vdev->features, vp_dev->ioaddr+VIRTIO_PCI_GUEST_FEATURES);
 }
 
 /* Device config access: we use guest endian, as per spec. */
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index 5217baf..82afdd8 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -814,7 +814,7 @@ void vring_transport_features(struct virtio_device *vdev)
 			break;
 		default:
 			/* We don't understand this bit. */
-			clear_bit(i, vdev->features);
+			vdev->features &= ~(1 << i);
 		}
 	}
 }
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 833f17b..80f55a0 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -100,8 +100,7 @@ struct virtio_device {
 	const struct virtio_config_ops *config;
 	const struct vringh_config_ops *vringh_config;
 	struct list_head vqs;
-	/* Note that this is a Linux set_bit-style bitmap. */
-	unsigned long features[1];
+	u32 features;
 	void *priv;
 };
 
diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
index b7aa3b1..9a7f740 100644
--- a/include/linux/virtio_config.h
+++ b/include/linux/virtio_config.h
@@ -111,7 +111,7 @@ static inline bool virtio_has_feature(const struct virtio_device *vdev,
 	if (fbit < VIRTIO_TRANSPORT_F_START)
 		virtio_check_driver_offered_feature(vdev, fbit);
 
-	return test_bit(fbit, vdev->features);
+	return vdev->features & (1 << fbit);
 }
 
 static inline
diff --git a/tools/virtio/linux/virtio.h b/tools/virtio/linux/virtio.h
index 6df181a..02a38e8 100644
--- a/tools/virtio/linux/virtio.h
+++ b/tools/virtio/linux/virtio.h
@@ -6,31 +6,11 @@
 /* TODO: empty stubs for now. Broken but enough for virtio_ring.c */
 #define list_add_tail(a, b) do {} while (0)
 #define list_del(a) do {} while (0)
-
-#define BIT_WORD(nr)		((nr) / BITS_PER_LONG)
-#define BITS_PER_BYTE		8
-#define BITS_PER_LONG (sizeof(long) * BITS_PER_BYTE)
-#define BIT_MASK(nr)		(1UL << ((nr) % BITS_PER_LONG))
-
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
 /* end of stubs */
 
 struct virtio_device {
 	void *dev;
-	unsigned long features[1];
+	u32 features;
 };
 
 struct virtqueue {
diff --git a/tools/virtio/linux/virtio_config.h b/tools/virtio/linux/virtio_config.h
index 5049967..1f1636b 100644
--- a/tools/virtio/linux/virtio_config.h
+++ b/tools/virtio/linux/virtio_config.h
@@ -2,5 +2,5 @@
 #define VIRTIO_TRANSPORT_F_END		32
 
 #define virtio_has_feature(dev, feature) \
-	test_bit((feature), (dev)->features)
+	((dev)->features & (1 << feature))
 
diff --git a/tools/virtio/virtio_test.c b/tools/virtio/virtio_test.c
index 814ae80..59f0706 100644
--- a/tools/virtio/virtio_test.c
+++ b/tools/virtio/virtio_test.c
@@ -59,7 +59,7 @@ void vhost_vq_setup(struct vdev_info *dev, struct vq_info *info)
 {
 	struct vhost_vring_state state = { .index = info->idx };
 	struct vhost_vring_file file = { .index = info->idx };
-	unsigned long long features = dev->vdev.features[0];
+	unsigned long long features = dev->vdev.features;
 	struct vhost_vring_addr addr = {
 		.index = info->idx,
 		.desc_user_addr = (uint64_t)(unsigned long)info->vring.desc,
@@ -112,8 +112,7 @@ static void vdev_info_init(struct vdev_info* dev, unsigned long long features)
 {
 	int r;
 	memset(dev, 0, sizeof *dev);
-	dev->vdev.features[0] = features;
-	dev->vdev.features[1] = features >> 32;
+	dev->vdev.features = features;
 	dev->buf_size = 1024;
 	dev->buf = malloc(dev->buf_size);
 	assert(dev->buf);
diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 88fe02a..d71fc05 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -299,7 +299,7 @@ static int parallel_test(unsigned long features,
 		close(to_guest[1]);
 		close(to_host[0]);
 
-		gvdev.vdev.features[0] = features;
+		gvdev.vdev.features = features;
 		gvdev.to_host_fd = to_host[1];
 		gvdev.notifies = 0;
 
@@ -444,13 +444,13 @@ int main(int argc, char *argv[])
 	bool fast_vringh = false, parallel = false;
 
 	getrange = getrange_iov;
-	vdev.features[0] = 0;
+	vdev.features = 0;
 
 	while (argv[1]) {
 		if (strcmp(argv[1], "--indirect") == 0)
-			vdev.features[0] |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
+			vdev.features |= (1 << VIRTIO_RING_F_INDIRECT_DESC);
 		else if (strcmp(argv[1], "--eventidx") == 0)
-			vdev.features[0] |= (1 << VIRTIO_RING_F_EVENT_IDX);
+			vdev.features |= (1 << VIRTIO_RING_F_EVENT_IDX);
 		else if (strcmp(argv[1], "--slow-range") == 0)
 			getrange = getrange_slow;
 		else if (strcmp(argv[1], "--fast-vringh") == 0)
@@ -463,7 +463,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (parallel)
-		return parallel_test(vdev.features[0], getrange, fast_vringh);
+		return parallel_test(vdev.features, getrange, fast_vringh);
 
 	if (posix_memalign(&__user_addr_min, PAGE_SIZE, USER_MEM) != 0)
 		abort();
@@ -478,7 +478,7 @@ int main(int argc, char *argv[])
 
 	/* Set up host side. */
 	vring_init(&vrh.vring, RINGSIZE, __user_addr_min, ALIGN);
-	vringh_init_user(&vrh, vdev.features[0], RINGSIZE, true,
+	vringh_init_user(&vrh, vdev.features, RINGSIZE, true,
 			 vrh.vring.desc, vrh.vring.avail, vrh.vring.used);
 
 	/* No descriptor to get yet... */
@@ -646,13 +646,13 @@ int main(int argc, char *argv[])
 	}
 
 	/* Test weird (but legal!) indirect. */
-	if (vdev.features[0] & (1 << VIRTIO_RING_F_INDIRECT_DESC)) {
+	if (vdev.features & (1 << VIRTIO_RING_F_INDIRECT_DESC)) {
 		char *data = __user_addr_max - USER_MEM/4;
 		struct vring_desc *d = __user_addr_max - USER_MEM/2;
 		struct vring vring;
 
 		/* Force creation of direct, which we modify. */
-		vdev.features[0] &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
+		vdev.features &= ~(1 << VIRTIO_RING_F_INDIRECT_DESC);
 		vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true,
 					 __user_addr_min,
 					 never_notify_host,
-- 
1.7.10.4
