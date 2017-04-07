From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 10/15] virtio-pci: translate MSIs with the virtual
	IOMMU
Date: Fri,  7 Apr 2017 20:24:50 +0100
Message-ID: <20170407192455.26814-11-jean-philippe.brucker__3232.61567759818$1491593226$gmane$org@arm.com>
References: <20170407191747.26618-1-jean-philippe.brucker@arm.com>
	<20170407192455.26814-1-jean-philippe.brucker@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20170407192455.26814-1-jean-philippe.brucker@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: iommu@lists.linux-foundation.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
Cc: cdall@linaro.org, lorenzo.pieralisi@arm.com, mst@redhat.com, marc.zyngier@arm.com, joro@8bytes.org, will.deacon@arm.com, robin.murphy@arm.com
List-Id: virtualization@lists.linuxfoundation.org

When the virtio device is behind a virtual IOMMU, the doorbell address
written into the MSI-X table by the guest is an IOVA, not a physical one.
When injecting an MSI, KVM needs a physical address to recognize the
doorbell and the associated IRQ chip. Translate the address given by the
guest into a physical one, and store it in a secondary table for easy
access.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/iommu.h      |  4 ++++
 include/kvm/virtio-pci.h |  1 +
 iommu.c                  | 23 +++++++++++++++++++++++
 virtio/pci.c             | 33 ++++++++++++++++++++++++---------
 4 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/include/kvm/iommu.h b/include/kvm/iommu.h
index 4164ba20..8f87ce5a 100644
--- a/include/kvm/iommu.h
+++ b/include/kvm/iommu.h
@@ -70,4 +70,8 @@ int iommu_unmap(void *address_space, u64 virt_addr, u64 size, int flags);
 u64 iommu_access(void *address_space, u64 addr, size_t size, size_t *out_size,
 		 int prot);
 
+struct msi_msg;
+
+int iommu_translate_msi(void *address_space, struct msi_msg *msi);
+
 #endif /* KVM_IOMMU_H */
diff --git a/include/kvm/virtio-pci.h b/include/kvm/virtio-pci.h
index 26772f74..cb5225d6 100644
--- a/include/kvm/virtio-pci.h
+++ b/include/kvm/virtio-pci.h
@@ -47,6 +47,7 @@ struct virtio_pci {
 	u32			msix_io_block;
 	u64			msix_pba;
 	struct msix_table	msix_table[VIRTIO_PCI_MAX_VQ + VIRTIO_PCI_MAX_CONFIG];
+	struct msi_msg		msix_msgs[VIRTIO_PCI_MAX_VQ + VIRTIO_PCI_MAX_CONFIG];
 
 	/* virtio queue */
 	u16			queue_selector;
diff --git a/iommu.c b/iommu.c
index 0a662404..c10a3f0b 100644
--- a/iommu.c
+++ b/iommu.c
@@ -5,6 +5,7 @@
 
 #include "kvm/iommu.h"
 #include "kvm/kvm.h"
+#include "kvm/msi.h"
 #include "kvm/mutex.h"
 #include "kvm/rbtree-interval.h"
 
@@ -160,3 +161,25 @@ out_unlock:
 
 	return out_addr;
 }
+
+int iommu_translate_msi(void *address_space, struct msi_msg *msg)
+{
+	size_t size = 4, out_size;
+	u64 addr = ((u64)msg->address_hi << 32) | msg->address_lo;
+
+	if (!address_space)
+		return 0;
+
+	addr = iommu_access(address_space, addr, size, &out_size,
+			    IOMMU_PROT_WRITE);
+
+	if (!addr || out_size != size) {
+		pr_err("could not translate MSI doorbell");
+		return -EFAULT;
+	}
+
+	msg->address_lo = addr & 0xffffffff;
+	msg->address_hi = addr >> 32;
+
+	return 0;
+}
diff --git a/virtio/pci.c b/virtio/pci.c
index 674d5143..88b1a129 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -156,6 +156,7 @@ static void update_msix_map(struct virtio_pci *vpci,
 			    struct msix_table *msix_entry, u32 vecnum)
 {
 	u32 gsi, i;
+	struct msi_msg *msg;
 
 	/* Find the GSI number used for that vector */
 	if (vecnum == vpci->config_vector) {
@@ -172,14 +173,20 @@ static void update_msix_map(struct virtio_pci *vpci,
 	if (gsi == 0)
 		return;
 
-	msix_entry = &msix_entry[vecnum];
-	irq__update_msix_route(vpci->kvm, gsi, &msix_entry->msg);
+	msg = &vpci->msix_msgs[vecnum];
+	*msg = msix_entry[vecnum].msg;
+
+	if (iommu_translate_msi(vpci->vdev->iotlb, msg))
+		return;
+
+	irq__update_msix_route(vpci->kvm, gsi, msg);
 }
 
 static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *vdev, u16 port,
 					void *data, int size, int offset)
 {
 	struct virtio_pci *vpci = vdev->virtio;
+	struct msi_msg *msg;
 	u32 config_offset, vec;
 	int gsi;
 	int type = virtio__get_dev_specific_field(offset - 20, virtio_pci__msix_enabled(vpci),
@@ -191,8 +198,12 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
 			if (vec == VIRTIO_MSI_NO_VECTOR)
 				break;
 
-			gsi = irq__add_msix_route(kvm,
-						  &vpci->msix_table[vec].msg,
+			msg = &vpci->msix_msgs[vec];
+			*msg = vpci->msix_table[vec].msg;
+			if (iommu_translate_msi(vdev->iotlb, msg))
+				break;
+
+			gsi = irq__add_msix_route(kvm, msg,
 						  vpci->dev_hdr.dev_num << 3);
 			if (gsi >= 0) {
 				vpci->config_gsi = gsi;
@@ -210,8 +221,12 @@ static bool virtio_pci__specific_io_out(struct kvm *kvm, struct virtio_device *v
 			if (vec == VIRTIO_MSI_NO_VECTOR)
 				break;
 
-			gsi = irq__add_msix_route(kvm,
-						  &vpci->msix_table[vec].msg,
+			msg = &vpci->msix_msgs[vec];
+			*msg = vpci->msix_table[vec].msg;
+			if (iommu_translate_msi(vdev->iotlb, msg))
+				break;
+
+			gsi = irq__add_msix_route(kvm, msg,
 						  vpci->dev_hdr.dev_num << 3);
 			if (gsi < 0) {
 				if (gsi == -ENXIO &&
@@ -328,9 +343,9 @@ static void virtio_pci__signal_msi(struct kvm *kvm, struct virtio_pci *vpci,
 {
 	static int needs_devid = 0;
 	struct kvm_msi msi = {
-		.address_lo = vpci->msix_table[vec].msg.address_lo,
-		.address_hi = vpci->msix_table[vec].msg.address_hi,
-		.data = vpci->msix_table[vec].msg.data,
+		.address_lo = vpci->msix_msgs[vec].address_lo,
+		.address_hi = vpci->msix_msgs[vec].address_hi,
+		.data = vpci->msix_msgs[vec].data,
 	};
 
 	if (needs_devid == 0) {
-- 
2.12.1
