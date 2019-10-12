From: Ram Pai <linuxram@us.ibm.com>
Subject: [PATCH 1/2] dma-mapping: Add dma_addr_is_phys_addr()
Date: Fri, 11 Oct 2019 18:25:18 -0700
Message-ID: <1570843519-8696-2-git-send-email-linuxram__42609.1452407249$1570844096$gmane$org@us.ibm.com>
References: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1570843519-8696-1-git-send-email-linuxram@us.ibm.com>
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
Cc: andmike@us.ibm.com, sukadev@linux.vnet.ibm.com, b.zolnierkie@samsung.com, benh@kernel.crashing.org, aik@linux.ibm.com, linuxram@us.ibm.com, virtualization@lists.linux-foundation.org, paulus@ozlabs.org, iommu@lists.linux-foundation.org, paul.burton@mips.com, mpe@ellerman.id.au, robin.murphy@arm.com, m.szyprowski@samsung.com, linuxppc-dev@lists.ozlabs.org, hch@lst.de, david@gibson.dropbear.id.au
List-Id: virtualization@lists.linuxfoundation.org

From: Thiago Jung Bauermann <bauerman@linux.ibm.com>

In order to safely use the DMA API, virtio needs to know whether DMA
addresses are in fact physical addresses and for that purpose,
dma_addr_is_phys_addr() is introduced.

cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: David Gibson <david@gibson.dropbear.id.au>
cc: Michael Ellerman <mpe@ellerman.id.au>
cc: Paul Mackerras <paulus@ozlabs.org>
cc: Michael Roth <mdroth@linux.vnet.ibm.com>
cc: Alexey Kardashevskiy <aik@linux.ibm.com>
cc: Paul Burton <paul.burton@mips.com>
cc: Robin Murphy <robin.murphy@arm.com>
cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
cc: Marek Szyprowski <m.szyprowski@samsung.com>
cc: Christoph Hellwig <hch@lst.de>
Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Ram Pai <linuxram@us.ibm.com>
Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
---
 arch/powerpc/include/asm/dma-mapping.h | 21 +++++++++++++++++++++
 arch/powerpc/platforms/pseries/Kconfig |  1 +
 include/linux/dma-mapping.h            | 20 ++++++++++++++++++++
 kernel/dma/Kconfig                     |  3 +++
 4 files changed, 45 insertions(+)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 565d6f7..f92c0a4b 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_DMA_MAPPING_H
 #define _ASM_DMA_MAPPING_H
 
+#include <asm/svm.h>
+
 static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 {
 	/* We don't handle the NULL dev case for ISA for now. We could
@@ -15,4 +17,23 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
+#ifdef CONFIG_ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
+/**
+ * dma_addr_is_phys_addr - check whether a device DMA address is a physical
+ *		address
+ * @dev:	device to check
+ *
+ * Returns %true if any DMA address for this device happens to also be a valid
+ * physical address (not necessarily of the same page).
+ */
+static inline bool dma_addr_is_phys_addr(struct device *dev)
+{
+	/*
+	 * Secure guests always use the SWIOTLB, therefore DMA addresses are
+	 * actually the physical address of the bounce buffer.
+	 */
+	return is_secure_guest();
+}
+#endif
+
 #endif	/* _ASM_DMA_MAPPING_H */
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index 9e35cdd..0108150 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -152,6 +152,7 @@ config PPC_SVM
 	select SWIOTLB
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
+	select ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
 	help
 	 There are certain POWER platforms which support secure guests using
 	 the Protected Execution Facility, with the help of an Ultravisor
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index f7d1eea..6df5664 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -693,6 +693,26 @@ static inline bool dma_addressing_limited(struct device *dev)
 			    dma_get_required_mask(dev);
 }
 
+#ifndef CONFIG_ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
+/**
+ * dma_addr_is_phys_addr - check whether a device DMA address is a physical
+ *		address
+ * @dev:	device to check
+ *
+ * Returns %true if any DMA address for this device happens to also be a valid
+ * physical address (not necessarily of the same page).
+ */
+static inline bool dma_addr_is_phys_addr(struct device *dev)
+{
+	/*
+	 * Except in very specific setups, DMA addresses exist in a different
+	 * address space from CPU physical addresses and cannot be directly used
+	 * to reference system memory.
+	 */
+	return false;
+}
+#endif
+
 #ifdef CONFIG_ARCH_HAS_SETUP_DMA_OPS
 void arch_setup_dma_ops(struct device *dev, u64 dma_base, u64 size,
 		const struct iommu_ops *iommu, bool coherent);
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 9decbba..6209b46 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -51,6 +51,9 @@ config ARCH_HAS_DMA_MMAP_PGPROT
 config ARCH_HAS_FORCE_DMA_UNENCRYPTED
 	bool
 
+config ARCH_HAS_DMA_ADDR_IS_PHYS_ADDR
+	bool
+
 config DMA_NONCOHERENT_CACHE_SYNC
 	bool
 
-- 
1.8.3.1
