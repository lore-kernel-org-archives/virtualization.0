From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Subject: [RFC PATCH kvmtool 05/15] iommu: describe IOMMU topology in
	device-trees
Date: Fri,  7 Apr 2017 20:24:45 +0100
Message-ID: <20170407192455.26814-6-jean-philippe.brucker__22252.5292927914$1491593142$gmane$org@arm.com>
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

Add an "iommu-map" property to the PCI host controller, describing which
iommus translate which devices. We describe individual devices in
iommu-map, not ranges. This patch is incompatible with current mainline
Linux, which requires *all* devices under a host controller to be
described by the iommu-map property when present. Unfortunately all PCI
devices in kvmtool are under the same root complex, and we have to omit
RIDs of devices that aren't behind the virtual IOMMU in iommu-map. Fixing
this either requires a simple patch in Linux, or to implement multiple
host controllers in kvmtool.

Add an "iommus" property to plaform devices that are behind an iommu.

Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
---
 arm/pci.c         | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 fdt.c             | 20 ++++++++++++++++++++
 include/kvm/fdt.h |  7 +++++++
 virtio/mmio.c     |  1 +
 4 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/arm/pci.c b/arm/pci.c
index 557cfa98..968cbf5b 100644
--- a/arm/pci.c
+++ b/arm/pci.c
@@ -1,9 +1,11 @@
 #include "kvm/devices.h"
 #include "kvm/fdt.h"
+#include "kvm/iommu.h"
 #include "kvm/kvm.h"
 #include "kvm/of_pci.h"
 #include "kvm/pci.h"
 #include "kvm/util.h"
+#include "kvm/virtio-iommu.h"
 
 #include "arm-common/pci.h"
 
@@ -24,11 +26,20 @@ struct of_interrupt_map_entry {
 	struct of_gic_irq		gic_irq;
 } __attribute__((packed));
 
+struct of_iommu_map_entry {
+	u32				rid_base;
+	u32				iommu_phandle;
+	u32				iommu_base;
+	u32				length;
+} __attribute__((packed));
+
 void pci__generate_fdt_nodes(void *fdt)
 {
 	struct device_header *dev_hdr;
 	struct of_interrupt_map_entry irq_map[OF_PCI_IRQ_MAP_MAX];
-	unsigned nentries = 0;
+	struct of_iommu_map_entry *iommu_map;
+	unsigned nentries = 0, ntranslated = 0;
+	unsigned i;
 	/* Bus range */
 	u32 bus_range[] = { cpu_to_fdt32(0), cpu_to_fdt32(1), };
 	/* Configuration Space */
@@ -99,6 +110,9 @@ void pci__generate_fdt_nodes(void *fdt)
 			},
 		};
 
+		if (dev_hdr->iommu_ops)
+			ntranslated++;
+
 		nentries++;
 		dev_hdr = device__next_dev(dev_hdr);
 	}
@@ -121,5 +135,38 @@ void pci__generate_fdt_nodes(void *fdt)
 				  sizeof(irq_mask)));
 	}
 
+	if (ntranslated) {
+		const struct iommu_properties *props;
+
+		iommu_map = malloc(ntranslated * sizeof(struct of_iommu_map_entry));
+		if (!iommu_map) {
+			pr_err("cannot allocate iommu_map.");
+			return;
+		}
+
+		dev_hdr = device__first_dev(DEVICE_BUS_PCI);
+		for (i = 0; i < ntranslated; dev_hdr = device__next_dev(dev_hdr)) {
+			struct of_iommu_map_entry *entry = &iommu_map[i];
+
+			if (!dev_hdr->iommu_ops)
+				continue;
+
+			props = dev_hdr->iommu_ops->get_properties(dev_hdr);
+
+			*entry = (struct of_iommu_map_entry) {
+				.rid_base	= cpu_to_fdt32(dev_hdr->dev_num << 3),
+				.iommu_phandle	= cpu_to_fdt32(props->phandle),
+				.iommu_base	= cpu_to_fdt32(device_to_iommu_id(dev_hdr)),
+				.length		= cpu_to_fdt32(1 << 3),
+			};
+
+			i++;
+		}
+
+		_FDT(fdt_property(fdt, "iommu-map", iommu_map,
+				  ntranslated * sizeof(struct of_iommu_map_entry)));
+		free(iommu_map);
+	}
+
 	_FDT(fdt_end_node(fdt));
 }
diff --git a/fdt.c b/fdt.c
index 6db03d4e..15d7bb29 100644
--- a/fdt.c
+++ b/fdt.c
@@ -2,7 +2,10 @@
  * Commonly used FDT functions.
  */
 
+#include "kvm/devices.h"
 #include "kvm/fdt.h"
+#include "kvm/iommu.h"
+#include "kvm/util.h"
 
 static u32 next_phandle = PHANDLE_RESERVED;
 
@@ -13,3 +16,20 @@ u32 fdt_alloc_phandle(void)
 
 	return next_phandle++;
 }
+
+void fdt_generate_iommus_prop(void *fdt, struct device_header *dev_hdr)
+{
+	const struct iommu_properties *props;
+
+	if (!dev_hdr->iommu_ops)
+		return;
+
+	props = dev_hdr->iommu_ops->get_properties(dev_hdr);
+
+	u32 iommus[] = {
+		cpu_to_fdt32(props->phandle),
+		cpu_to_fdt32(device_to_iommu_id(dev_hdr)),
+	};
+
+	_FDT(fdt_property(fdt, "iommus", iommus, sizeof(iommus)));
+}
diff --git a/include/kvm/fdt.h b/include/kvm/fdt.h
index 503887f9..c64fe8a3 100644
--- a/include/kvm/fdt.h
+++ b/include/kvm/fdt.h
@@ -37,7 +37,10 @@ enum irq_type {
 
 #ifdef CONFIG_HAS_LIBFDT
 
+struct device_header;
+
 u32 fdt_alloc_phandle(void);
+void fdt_generate_iommus_prop(void *fdt, struct device_header *dev);
 
 #else
 
@@ -46,6 +49,10 @@ static inline u32 fdt_alloc_phandle(void)
 	return PHANDLE_RESERVED;
 }
 
+static inline void fdt_generate_iommus_prop(void *fdt, struct device_header *dev)
+{
+}
+
 #endif /* CONFIG_HAS_LIBFDT */
 
 #endif /* KVM__FDT_H */
diff --git a/virtio/mmio.c b/virtio/mmio.c
index b3dea51a..16b44fbb 100644
--- a/virtio/mmio.c
+++ b/virtio/mmio.c
@@ -258,6 +258,7 @@ void generate_virtio_mmio_fdt_node(void *fdt,
 	_FDT(fdt_property(fdt, "reg", reg_prop, sizeof(reg_prop)));
 	_FDT(fdt_property(fdt, "dma-coherent", NULL, 0));
 	generate_irq_prop(fdt, vmmio->irq, IRQ_TYPE_EDGE_RISING);
+	fdt_generate_iommus_prop(fdt, dev_hdr);
 
 	if (vmmio->hdr.device_id == VIRTIO_ID_IOMMU) {
 		props = viommu_get_properties(vmmio->dev);
-- 
2.12.1
