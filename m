From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 08/15] virtio: add vIOMMU instance for virtio
	devices
Date: Fri,  7 Apr 2017 20:24:48 +0100
Message-ID: <20170407192455.26814-9-jean-philippe.brucker__43813.5041892112$1491593183$gmane$org@arm.com>
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

Virtio devices can now opt-in to use an IOMMU, by setting the use_iommu
field. None of this will work in the current state, since virtio devices
still access memory linearly. A subsequent patch implements sg accesses.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 include/kvm/virtio-mmio.h |  1 +
 include/kvm/virtio-pci.h  |  1 +
 include/kvm/virtio.h      | 13 ++++++++++++
 virtio/core.c             | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 virtio/mmio.c             | 27 ++++++++++++++++++++++++
 virtio/pci.c              | 26 ++++++++++++++++++++++++
 6 files changed, 120 insertions(+)

diff --git a/include/kvm/virtio-mmio.h b/include/kvm/virtio-mmio.h
index 835f421b..c25a4fd7 100644
--- a/include/kvm/virtio-mmio.h
+++ b/include/kvm/virtio-mmio.h
@@ -44,6 +44,7 @@ struct virtio_mmio_hdr {
 struct virtio_mmio {
 	u32			addr;
 	void			*dev;
+	struct virtio_device	*vdev;
 	struct kvm		*kvm;
 	u8			irq;
 	struct virtio_mmio_hdr	hdr;
diff --git a/include/kvm/virtio-pci.h b/include/kvm/virtio-pci.h
index b70cadd8..26772f74 100644
--- a/include/kvm/virtio-pci.h
+++ b/include/kvm/virtio-pci.h
@@ -22,6 +22,7 @@ struct virtio_pci {
 	struct pci_device_header pci_hdr;
 	struct device_header	dev_hdr;
 	void			*dev;
+	struct virtio_device	*vdev;
 	struct kvm		*kvm;
 
 	u16			port_addr;
diff --git a/include/kvm/virtio.h b/include/kvm/virtio.h
index 24c0c487..9f2ff237 100644
--- a/include/kvm/virtio.h
+++ b/include/kvm/virtio.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <sys/uio.h>
 
+#include "kvm/iommu.h"
 #include "kvm/kvm.h"
 
 #define VIRTIO_IRQ_LOW		0
@@ -137,10 +138,12 @@ enum virtio_trans {
 };
 
 struct virtio_device {
+	bool			use_iommu;
 	bool			use_vhost;
 	void			*virtio;
 	struct virtio_ops	*ops;
 	u16			endian;
+	void			*iotlb;
 };
 
 struct virtio_ops {
@@ -182,4 +185,14 @@ static inline void virtio_init_device_vq(struct kvm *kvm,
 	vring_init(&vq->vring, nr_descs, p, align);
 }
 
+/*
+ * These are callbacks for IOMMU operations on virtio devices. They are not
+ * operations on the virtio-iommu device. Confusing, I know.
+ */
+const struct iommu_properties *
+virtio__iommu_get_properties(struct device_header *dev);
+
+int virtio__iommu_attach(void *, struct virtio_device *vdev, int flags);
+int virtio__iommu_detach(void *, struct virtio_device *vdev);
+
 #endif /* KVM__VIRTIO_H */
diff --git a/virtio/core.c b/virtio/core.c
index d6ac289d..32bd4ebc 100644
--- a/virtio/core.c
+++ b/virtio/core.c
@@ -6,11 +6,16 @@
 #include "kvm/guest_compat.h"
 #include "kvm/barrier.h"
 #include "kvm/virtio.h"
+#include "kvm/virtio-iommu.h"
 #include "kvm/virtio-pci.h"
 #include "kvm/virtio-mmio.h"
 #include "kvm/util.h"
 #include "kvm/kvm.h"
 
+static void *iommu = NULL;
+static struct iommu_properties iommu_props = {
+	.name		= "viommu-virtio",
+};
 
 const char* virtio_trans_name(enum virtio_trans trans)
 {
@@ -198,6 +203,41 @@ bool virtio_queue__should_signal(struct virt_queue *vq)
 	return false;
 }
 
+const struct iommu_properties *
+virtio__iommu_get_properties(struct device_header *dev)
+{
+	return &iommu_props;
+}
+
+int virtio__iommu_attach(void *priv, struct virtio_device *vdev, int flags)
+{
+	struct virtio_tlb *iotlb = priv;
+
+	if (!iotlb)
+		return -ENOMEM;
+
+	if (vdev->iotlb) {
+		pr_err("device already attached");
+		return -EINVAL;
+	}
+
+	vdev->iotlb = iotlb;
+
+	return 0;
+}
+
+int virtio__iommu_detach(void *priv, struct virtio_device *vdev)
+{
+	if (vdev->iotlb != priv) {
+		pr_err("wrong iotlb"); /* bug */
+		return -EINVAL;
+	}
+
+	vdev->iotlb = NULL;
+
+	return 0;
+}
+
 int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		struct virtio_ops *ops, enum virtio_trans trans,
 		int device_id, int subsys_id, int class)
@@ -233,6 +273,18 @@ int virtio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		return -1;
 	};
 
+	if (!iommu && vdev->use_iommu) {
+		iommu_props.pgsize_mask = ~(PAGE_SIZE - 1);
+		/*
+		 * With legacy MMIO, we only have 32-bit to hold the vring PFN.
+		 * This limits the IOVA size to (32 + 12) = 44 bits, when using
+		 * 4k pages.
+		 */
+		iommu_props.input_addr_size = 44;
+		iommu = viommu_register(kvm, &iommu_props);
+	}
+
+
 	return 0;
 }
 
diff --git a/virtio/mmio.c b/virtio/mmio.c
index 16b44fbb..24a14a71 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -1,4 +1,5 @@
 #include "kvm/devices.h"
+#include "kvm/virtio-iommu.h"
 #include "kvm/virtio-mmio.h"
 #include "kvm/ioeventfd.h"
 #include "kvm/iommu.h"
@@ -286,6 +287,30 @@ void virtio_mmio_assign_irq(struct device_header *dev_hdr)
 	vmmio->irq = irq__alloc_line();
 }
 
+#define mmio_dev_to_virtio(dev_hdr)					\
+	container_of(dev_hdr, struct virtio_mmio, dev_hdr)->vdev
+
+static int virtio_mmio_iommu_attach(void *priv, struct device_header *dev_hdr,
+				    int flags)
+{
+	return virtio__iommu_attach(priv, mmio_dev_to_virtio(dev_hdr), flags);
+}
+
+static int virtio_mmio_iommu_detach(void *priv, struct device_header *dev_hdr)
+{
+	return virtio__iommu_detach(priv, mmio_dev_to_virtio(dev_hdr));
+}
+
+static struct iommu_ops virtio_mmio_iommu_ops = {
+	.get_properties		= virtio__iommu_get_properties,
+	.alloc_address_space	= iommu_alloc_address_space,
+	.free_address_space	= iommu_free_address_space,
+	.attach			= virtio_mmio_iommu_attach,
+	.detach			= virtio_mmio_iommu_detach,
+	.map			= iommu_map,
+	.unmap			= iommu_unmap,
+};
+
 int virtio_mmio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		     int device_id, int subsys_id, int class)
 {
@@ -294,6 +319,7 @@ int virtio_mmio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 	vmmio->addr	= virtio_mmio_get_io_space_block(VIRTIO_MMIO_IO_SIZE);
 	vmmio->kvm	= kvm;
 	vmmio->dev	= dev;
+	vmmio->vdev	= vdev;
 
 	kvm__register_mmio(kvm, vmmio->addr, VIRTIO_MMIO_IO_SIZE,
 			   false, virtio_mmio_mmio_callback, vdev);
@@ -309,6 +335,7 @@ int virtio_mmio_init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 	vmmio->dev_hdr = (struct device_header) {
 		.bus_type	= DEVICE_BUS_MMIO,
 		.data		= generate_virtio_mmio_fdt_node,
+		.iommu_ops	= vdev->use_iommu ? &virtio_mmio_iommu_ops : NULL,
 	};
 
 	device__register(&vmmio->dev_hdr);
diff --git a/virtio/pci.c b/virtio/pci.c
index b6ef389e..674d5143 100644
--- a/virtio/pci.c
+++ b/virtio/pci.c
@@ -408,6 +408,30 @@ static void virtio_pci__io_mmio_callback(struct kvm_cpu *vcpu,
 	kvm__emulate_io(vcpu, port, data, direction, len, 1);
 }
 
+#define pci_dev_to_virtio(dev_hdr)				\
+	(container_of(dev_hdr, struct virtio_pci, dev_hdr)->vdev)
+
+static int virtio_pci_iommu_attach(void *priv, struct device_header *dev_hdr,
+				   int flags)
+{
+	return virtio__iommu_attach(priv, pci_dev_to_virtio(dev_hdr), flags);
+}
+
+static int virtio_pci_iommu_detach(void *priv, struct device_header *dev_hdr)
+{
+	return virtio__iommu_detach(priv, pci_dev_to_virtio(dev_hdr));
+}
+
+static struct iommu_ops virtio_pci_iommu_ops = {
+	.get_properties		= virtio__iommu_get_properties,
+	.alloc_address_space	= iommu_alloc_address_space,
+	.free_address_space	= iommu_free_address_space,
+	.attach			= virtio_pci_iommu_attach,
+	.detach			= virtio_pci_iommu_detach,
+	.map			= iommu_map,
+	.unmap			= iommu_unmap,
+};
+
 int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 		     int device_id, int subsys_id, int class)
 {
@@ -416,6 +440,7 @@ int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 
 	vpci->kvm = kvm;
 	vpci->dev = dev;
+	vpci->vdev = vdev;
 
 	r = ioport__register(kvm, IOPORT_EMPTY, &virtio_pci__io_ops, IOPORT_SIZE, vdev);
 	if (r < 0)
@@ -461,6 +486,7 @@ int virtio_pci__init(struct kvm *kvm, void *dev, struct virtio_device *vdev,
 	vpci->dev_hdr = (struct device_header) {
 		.bus_type		= DEVICE_BUS_PCI,
 		.data			= &vpci->pci_hdr,
+		.iommu_ops		= vdev->use_iommu ? &virtio_pci_iommu_ops : NULL,
 	};
 
 	vpci->pci_hdr.msix.cap = PCI_CAP_ID_MSIX;
-- 
2.12.1
