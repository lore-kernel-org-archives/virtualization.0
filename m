From: Rusty Russell <rusty@rustcorp.com.au>
Subject: [PATCH 15/22] virtio_pci: use little endian for config space.
Date: Thu, 21 Mar 2013 18:59:36 +1030
Message-ID: <1363854584-25795-16-git-send-email-rusty@rustcorp.com.au>
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
List-Id: virtualization@lists.linuxfoundation.org

Previously, it was defined as "guest-endian".  This was always confusing
for PCI, for which everything else is defined a little endian.

The ring itself is unchanged, this is just the per-device config info.

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
---
 drivers/virtio/virtio_pci.c |   77 +++++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 36 deletions(-)

diff --git a/drivers/virtio/virtio_pci.c b/drivers/virtio/virtio_pci.c
index 0169531..f252afe 100644
--- a/drivers/virtio/virtio_pci.c
+++ b/drivers/virtio/virtio_pci.c
@@ -140,57 +140,62 @@ static void vp_finalize_features(struct virtio_device *vdev)
 	iowrite32(vdev->features >> 32, &vp_dev->common->guest_feature);
 }
 
-/* virtio config->get() implementation */
-static void vp_get(struct virtio_device *vdev, unsigned offset,
-		   void *buf, unsigned len)
+/* virtio config is little-endian for virtio_pci (vs guest-endian for legacy) */
+static u8 vp_get8(struct virtio_device *vdev, unsigned offset)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->device + offset;
-	u8 *ptr = buf;
-	int i;
 
-	for (i = 0; i < len; i++)
-		ptr[i] = ioread8(ioaddr + i);
+	return ioread8(vp_dev->device + offset);
 }
 
-#define VP_GETx(bits)							\
-static u##bits vp_get##bits(struct virtio_device *vdev, unsigned int offset) \
-{									\
-	u##bits v;							\
-	vp_get(vdev, offset, &v, sizeof(v));				\
-	return v;							\
+static void vp_set8(struct virtio_device *vdev, unsigned offset, u8 val)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	iowrite8(val, vp_dev->device + offset);
 }
 
-VP_GETx(8)
-VP_GETx(16)
-VP_GETx(32)
-VP_GETx(64)
+static u16 vp_get16(struct virtio_device *vdev, unsigned offset)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
 
-/* the config->set() implementation.  it's symmetric to the config->get()
- * implementation */
-static void vp_set(struct virtio_device *vdev, unsigned offset,
-		   const void *buf, unsigned len)
+	return ioread16(vp_dev->device + offset);
+}
+
+static void vp_set16(struct virtio_device *vdev, unsigned offset, u16 val)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	iowrite16(val, vp_dev->device + offset);
+}
+
+static u32 vp_get32(struct virtio_device *vdev, unsigned offset)
 {
 	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
-	void __iomem *ioaddr = vp_dev->device + offset;
-	const u8 *ptr = buf;
-	int i;
 
-	for (i = 0; i < len; i++)
-		iowrite8(ptr[i], ioaddr + i);
+	return ioread32(vp_dev->device + offset);
 }
 
-#define VP_SETx(bits)							\
-static void vp_set##bits(struct virtio_device *vdev, unsigned int offset, \
-			 u##bits v)					\
-{									\
-	vp_set(vdev, offset, &v, sizeof(v));				\
+static void vp_set32(struct virtio_device *vdev, unsigned offset, u32 val)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	iowrite32(val, vp_dev->device + offset);
 }
 
-VP_SETx(8)
-VP_SETx(16)
-VP_SETx(32)
-VP_SETx(64)
+static u64 vp_get64(struct virtio_device *vdev, unsigned offset)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	return ioread64(vp_dev->device + offset);
+}
+
+static void vp_set64(struct virtio_device *vdev, unsigned offset, u64 val)
+{
+	struct virtio_pci_device *vp_dev = to_vp_device(vdev);
+
+	iowrite64(val, vp_dev->device + offset);
+}
 
 /* config->{get,set}_status() implementations */
 static u8 vp_get_status(struct virtio_device *vdev)
-- 
1.7.10.4
