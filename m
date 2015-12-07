From: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Subject: [PATCH RFC 1/3] xen: export xen_phys_to_bus,
	xen_bus_to_phys and xen_virt_to_bus
Date: Mon, 7 Dec 2015 16:19:41 +0000
Message-ID: <1449505183-29740-1-git-send-email-stefano.stabellini__49347.7540709593$1449505812$gmane$org@eu.citrix.com>
References: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.DEB.2.02.1512071555590.24652@kaball.uk.xensource.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: Stefano Stabellini <stefano.stabellini@eu.citrix.com>, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, david.vrabel@citrix.com, xen-devel@lists.xenproject.org, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
CC: konrad.wilk@oracle.com
CC: boris.ostrovsky@oracle.com
CC: david.vrabel@citrix.com
---
 drivers/xen/swiotlb-xen.c |   31 -------------------------------
 include/xen/swiotlb-xen.h |   32 ++++++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 79bc493..56014d5 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -75,37 +75,6 @@ static unsigned long xen_io_tlb_nslabs;
 
 static u64 start_dma_addr;
 
-/*
- * Both of these functions should avoid PFN_PHYS because phys_addr_t
- * can be 32bit when dma_addr_t is 64bit leading to a loss in
- * information if the shift is done before casting to 64bit.
- */
-static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
-{
-	unsigned long bfn = pfn_to_bfn(PFN_DOWN(paddr));
-	dma_addr_t dma = (dma_addr_t)bfn << PAGE_SHIFT;
-
-	dma |= paddr & ~PAGE_MASK;
-
-	return dma;
-}
-
-static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
-{
-	unsigned long pfn = bfn_to_pfn(PFN_DOWN(baddr));
-	dma_addr_t dma = (dma_addr_t)pfn << PAGE_SHIFT;
-	phys_addr_t paddr = dma;
-
-	paddr |= baddr & ~PAGE_MASK;
-
-	return paddr;
-}
-
-static inline dma_addr_t xen_virt_to_bus(void *address)
-{
-	return xen_phys_to_bus(virt_to_phys(address));
-}
-
 static int check_pages_physically_contiguous(unsigned long pfn,
 					     unsigned int offset,
 					     size_t length)
diff --git a/include/xen/swiotlb-xen.h b/include/xen/swiotlb-xen.h
index 8b2eb93..d55aee8 100644
--- a/include/xen/swiotlb-xen.h
+++ b/include/xen/swiotlb-xen.h
@@ -3,9 +3,41 @@
 
 #include <linux/dma-direction.h>
 #include <linux/swiotlb.h>
+#include <asm/xen/page.h>
 
 extern int xen_swiotlb_init(int verbose, bool early);
 
+/*
+ * Both of these functions should avoid PFN_PHYS because phys_addr_t
+ * can be 32bit when dma_addr_t is 64bit leading to a loss in
+ * information if the shift is done before casting to 64bit.
+ */
+static inline dma_addr_t xen_phys_to_bus(phys_addr_t paddr)
+{
+	unsigned long bfn = pfn_to_bfn(PFN_DOWN(paddr));
+	dma_addr_t dma = (dma_addr_t)bfn << PAGE_SHIFT;
+
+	dma |= paddr & ~PAGE_MASK;
+
+	return dma;
+}
+
+static inline phys_addr_t xen_bus_to_phys(dma_addr_t baddr)
+{
+	unsigned long pfn = bfn_to_pfn(PFN_DOWN(baddr));
+	dma_addr_t dma = (dma_addr_t)pfn << PAGE_SHIFT;
+	phys_addr_t paddr = dma;
+
+	paddr |= baddr & ~PAGE_MASK;
+
+	return paddr;
+}
+
+static inline dma_addr_t xen_virt_to_bus(void *address)
+{
+	return xen_phys_to_bus(virt_to_phys(address));
+}
+
 extern void
 *xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 			    dma_addr_t *dma_handle, gfp_t flags,
-- 
1.7.10.4
