From: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] xen: introduce xen_vring_use_dma
Date: Wed, 24 Jun 2020 17:17:32 +0800
Message-ID: <20200624091732.23944-1-peng.fan@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Sender: "iommu" <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
To: sstabellini-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, boris.ostrovsky-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, jgross-IBi9RG/b67k@public.gmane.org, konrad.wilk-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-imx-3arQi8VN3Tc@public.gmane.org, xen-devel-GuqFBffKawtpuQazS67q72D2FQJk+8+b@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Export xen_swiotlb for all platforms using xen swiotlb

Use xen_swiotlb to determine when vring should use dma APIs to map the
ring: when xen_swiotlb is enabled the dma API is required. When it is
disabled, it is not required.

Signed-off-by: Peng Fan <peng.fan-3arQi8VN3Tc@public.gmane.org>
---

V2:
 This is a modified version from Stefano's patch
 https://lore.kernel.org/patchwork/patch/1033801/#1222404
 Note: This is not to address rpmsg virtio issue, this is
 to let DomU virtio not using xen swiotlb could use non dma vring
 on ARM64 platforms.

 arch/arm/xen/mm.c                      | 1 +
 arch/x86/include/asm/xen/swiotlb-xen.h | 2 --
 arch/x86/xen/pci-swiotlb-xen.c         | 2 --
 drivers/virtio/virtio_ring.c           | 2 +-
 drivers/xen/swiotlb-xen.c              | 3 +++
 include/xen/swiotlb-xen.h              | 6 ++++++
 include/xen/xen.h                      | 6 ++++++
 7 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm/xen/mm.c b/arch/arm/xen/mm.c
index d40e9e5fc52b..6a493ea087f0 100644
--- a/arch/arm/xen/mm.c
+++ b/arch/arm/xen/mm.c
@@ -139,6 +139,7 @@ static int __init xen_mm_init(void)
 	struct gnttab_cache_flush cflush;
 	if (!xen_initial_domain())
 		return 0;
+	xen_swiotlb = 1;
 	xen_swiotlb_init(1, false);
 
 	cflush.op = 0;
diff --git a/arch/x86/include/asm/xen/swiotlb-xen.h b/arch/x86/include/asm/xen/swiotlb-xen.h
index 6b56d0d45d15..bb5ce02b4e20 100644
--- a/arch/x86/include/asm/xen/swiotlb-xen.h
+++ b/arch/x86/include/asm/xen/swiotlb-xen.h
@@ -3,12 +3,10 @@
 #define _ASM_X86_SWIOTLB_XEN_H
 
 #ifdef CONFIG_SWIOTLB_XEN
-extern int xen_swiotlb;
 extern int __init pci_xen_swiotlb_detect(void);
 extern void __init pci_xen_swiotlb_init(void);
 extern int pci_xen_swiotlb_init_late(void);
 #else
-#define xen_swiotlb (0)
 static inline int __init pci_xen_swiotlb_detect(void) { return 0; }
 static inline void __init pci_xen_swiotlb_init(void) { }
 static inline int pci_xen_swiotlb_init_late(void) { return -ENXIO; }
diff --git a/arch/x86/xen/pci-swiotlb-xen.c b/arch/x86/xen/pci-swiotlb-xen.c
index 33293ce01d8d..071fbe0e1a91 100644
--- a/arch/x86/xen/pci-swiotlb-xen.c
+++ b/arch/x86/xen/pci-swiotlb-xen.c
@@ -18,8 +18,6 @@
 #endif
 #include <linux/export.h>
 
-int xen_swiotlb __read_mostly;
-
 /*
  * pci_xen_swiotlb_detect - set xen_swiotlb to 1 if necessary
  *
diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
index a2de775801af..768afd79f67a 100644
--- a/drivers/virtio/virtio_ring.c
+++ b/drivers/virtio/virtio_ring.c
@@ -252,7 +252,7 @@ static bool vring_use_dma_api(struct virtio_device *vdev)
 	 * the DMA API if we're a Xen guest, which at least allows
 	 * all of the sensible Xen configurations to work correctly.
 	 */
-	if (xen_domain())
+	if (xen_vring_use_dma())
 		return true;
 
 	return false;
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index b6d27762c6f8..25747e72e6fe 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -40,6 +40,9 @@
 
 #include <trace/events/swiotlb.h>
 #define MAX_DMA_BITS 32
+
+int xen_swiotlb __read_mostly;
+
 /*
  * Used to do a quick range check in swiotlb_tbl_unmap_single and
  * swiotlb_tbl_sync_single_*, to see if the memory was in fact allocated by this
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index ffc0d3902b71..235babcde848 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -12,4 +12,10 @@ void xen_dma_sync_for_device(dma_addr_t handle, phys_addr_t paddr, size_t size,
 extern int xen_swiotlb_init(int verbose, bool early);
 extern const struct dma_map_ops xen_swiotlb_dma_ops;
 
+#ifdef CONFIG_SWIOTLB_XEN
+extern int xen_swiotlb;
+#else
+#define xen_swiotlb (0)
+#endif
+
 #endif /* __LINUX_SWIOTLB_XEN_H */
diff --git a/include/xen/xen.h b/include/xen/xen.h
index 19a72f591e2b..c51c46f5d739 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,4 +52,10 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 extern u64 xen_saved_max_mem_size;
 #endif
 
+#include <xen/swiotlb-xen.h>
+static inline int xen_vring_use_dma(void)
+{
+	return !!xen_swiotlb;
+}
+
 #endif	/* _XEN_XEN_H */
-- 
2.16.4
