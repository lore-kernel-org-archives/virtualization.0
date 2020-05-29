From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH 6/6] vdpa: vp_vdpa: report doorbell location
Date: Fri, 29 May 2020 16:03:03 +0800
Message-ID: <20200529080303.15449-7-jasowang@redhat.com>
References: <20200529080303.15449-1-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20200529080303.15449-1-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: mst@redhat.com, jasowang@redhat.com
Cc: shahafs@mellanox.com, lulu@redhat.com, kvm@vger.kernel.org, saugatm@xilinx.com, netdev@vger.kernel.org, mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org, gdawar@xilinx.com, virtualization@lists.linux-foundation.org, eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn, eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
List-Id: virtualization@lists.linuxfoundation.org

This patch adds support for reporting doorbell location in vp_vdpa
driver. The doorbell mapping could be then enabled by e.g launching
qemu's virtio-net-pci device with page-per-vq enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/vdpa/vp_vdpa/vp_vdpa.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/vp_vdpa/vp_vdpa.c b/drivers/vdpa/vp_vdpa/vp_vdpa.c
index e59c310e2156..a5ca49533138 100644
--- a/drivers/vdpa/vp_vdpa/vp_vdpa.c
+++ b/drivers/vdpa/vp_vdpa/vp_vdpa.c
@@ -30,6 +30,7 @@
 struct vp_vring {
 	void __iomem *notify;
 	char msix_name[256];
+	resource_size_t notify_pa;
 	struct vdpa_callback cb;
 	int irq;
 };
@@ -136,7 +137,8 @@ static int find_capability(struct pci_dev *dev, u8 cfg_type,
 	return 0;
 }
 
-static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off)
+static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off,
+				    resource_size_t *pa)
 {
 	struct pci_dev *pdev = vp_vdpa->pdev;
 	u32 offset;
@@ -149,6 +151,9 @@ static void __iomem *map_capability(struct vp_vdpa *vp_vdpa, int off)
 			      off + offsetof(struct virtio_pci_cap, offset),
 			      &offset);
 
+	if (pa)
+		*pa = pci_resource_start(pdev, bar) + offset;
+
 	return vp_vdpa->base[bar] + offset;
 }
 
@@ -283,6 +288,18 @@ static u64 vp_vdpa_get_vq_state(struct vdpa_device *vdpa, u16 qid)
 	return 0;
 }
 
+static struct vdpa_notification_area
+vp_vdpa_get_vq_notification(struct vdpa_device *vdpa, u16 qid)
+{
+	struct vp_vdpa *vp_vdpa = vdpa_to_vp(vdpa);
+	struct vdpa_notification_area notify;
+
+	notify.addr = vp_vdpa->vring[qid].notify_pa;
+	notify.size = vp_vdpa->notify_off_multiplier;
+
+	return notify;
+}
+
 static int vp_vdpa_set_vq_state(struct vdpa_device *vdpa, u16 qid,
 				u64 num)
 {
@@ -423,6 +440,7 @@ static const struct vdpa_config_ops vp_vdpa_ops = {
 	.set_status	= vp_vdpa_set_status,
 	.get_vq_num_max	= vp_vdpa_get_vq_num_max,
 	.get_vq_state	= vp_vdpa_get_vq_state,
+	.get_vq_notification = vp_vdpa_get_vq_notification,
 	.set_vq_state	= vp_vdpa_set_vq_state,
 	.set_vq_cb	= vp_vdpa_set_vq_cb,
 	.set_vq_ready	= vp_vdpa_set_vq_ready,
@@ -445,6 +463,7 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	struct vp_vdpa *vp_vdpa;
 	int common, notify, device, ret, i;
 	struct virtio_device_id virtio_id;
+	resource_size_t notify_pa;
 	u16 notify_off;
 
 	/* We only own devices >= 0x1000 and <= 0x107f: leave the rest. */
@@ -525,9 +544,9 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		dev_warn(&pdev->dev, "Failed to enable 64-bit or 32-bit DMA.  Trying to continue, but this might not work.\n");
 
-	vp_vdpa->device = map_capability(vp_vdpa, device);
-	vp_vdpa->notify = map_capability(vp_vdpa, notify);
-	vp_vdpa->common = map_capability(vp_vdpa, common);
+	vp_vdpa->device = map_capability(vp_vdpa, device, NULL);
+	vp_vdpa->notify = map_capability(vp_vdpa, notify, &notify_pa);
+	vp_vdpa->common = map_capability(vp_vdpa, common, NULL);
 	vp_vdpa->id = virtio_id;
 
 	ret = vdpa_register_device(&vp_vdpa->vdpa);
@@ -545,6 +564,8 @@ static int vp_vdpa_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		vp_vdpa->vring[i].irq = -1;
 		vp_vdpa->vring[i].notify = vp_vdpa->notify +
 			notify_off * vp_vdpa->notify_off_multiplier;
+		vp_vdpa->vring[i].notify_pa = notify_pa +
+			notify_off * vp_vdpa->notify_off_multiplier;
 	}
 
 	return 0;
-- 
2.20.1
