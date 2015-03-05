From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH] virtio_mmio: fix endian-ness for mmio
Date: Thu, 5 Mar 2015 22:54:31 +0100
Message-ID: <1425592060-18474-1-git-send-email-mst@redhat.com>
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
To: linux-kernel@vger.kernel.org
Cc: Pawel Moll <pawel.moll@arm.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Going over the virtio mmio code, I noticed that it doesn't correctly
return device config values in LE format when using virtio 1.0.
Borrow code from virtio_pci_modern to do this correctly.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Note: untested: QEMU doesn't support virtio 1.0 for virtio-mmio.
Pawel, could you please confirm this patch makes sense?

 drivers/virtio/virtio_mmio.c | 79 +++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 71 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index cad5698..0375456 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -156,22 +156,85 @@ static void vm_get(struct virtio_device *vdev, unsigned offset,
 		   void *buf, unsigned len)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	u8 *ptr = buf;
-	int i;
+	void __iomem *base = vm_dev->base + VIRTIO_MMIO_CONFIG;
+	u8 b;
+	__le16 w;
+	__le32 l;
 
-	for (i = 0; i < len; i++)
-		ptr[i] = readb(vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+	if (vm_dev->version == 1) {
+		u8 *ptr = buf;
+		int i;
+
+		for (i = 0; i < len; i++)
+			ptr[i] = readb(base + offset + i);
+		return;
+	}
+
+	switch (len) {
+	case 1:
+		b = readb(base + offset);
+		memcpy(buf, &b, sizeof b);
+		break;
+	case 2:
+		w = cpu_to_le16(readw(base + offset));
+		memcpy(buf, &w, sizeof w);
+		break;
+	case 4:
+		l = cpu_to_le32(readl(base + offset));
+		memcpy(buf, &l, sizeof l);
+		break;
+	case 8:
+		l = cpu_to_le32(readl(base + offset));
+		memcpy(buf, &l, sizeof l);
+		l = cpu_to_le32(ioread32(base + offset + sizeof l));
+		memcpy(buf + sizeof l, &l, sizeof l);
+		break;
+	default:
+		BUG();
+	}
 }
 
 static void vm_set(struct virtio_device *vdev, unsigned offset,
 		   const void *buf, unsigned len)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
-	const u8 *ptr = buf;
-	int i;
+	void __iomem *base = vm_dev->base + VIRTIO_MMIO_CONFIG;
+	u8 b;
+	__le16 w;
+	__le32 l;
 
-	for (i = 0; i < len; i++)
-		writeb(ptr[i], vm_dev->base + VIRTIO_MMIO_CONFIG + offset + i);
+	if (vm_dev->version == 1) {
+		const u8 *ptr = buf;
+		int i;
+
+		for (i = 0; i < len; i++)
+			writeb(ptr[i], base + offset + i);
+
+		return;
+	}
+
+	switch (len) {
+	case 1:
+		memcpy(&b, buf, sizeof b);
+		writeb(b, base + offset);
+		break;
+	case 2:
+		memcpy(&w, buf, sizeof w);
+		writew(le16_to_cpu(w), base + offset);
+		break;
+	case 4:
+		memcpy(&l, buf, sizeof l);
+		writel(le32_to_cpu(l), base + offset);
+		break;
+	case 8:
+		memcpy(&l, buf, sizeof l);
+		writel(le32_to_cpu(l), base + offset);
+		memcpy(&l, buf + sizeof l, sizeof l);
+		writel(le32_to_cpu(l), base + offset + sizeof l);
+		break;
+	default:
+		BUG();
+	}
 }
 
 static u8 vm_get_status(struct virtio_device *vdev)
-- 
MST
