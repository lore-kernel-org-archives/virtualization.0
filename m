From: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH] iommu: spapr_tce: Disable compile testing to fix build on
 book3s_32 config
Date: Tue, 14 Apr 2020 16:26:30 +0200
Message-ID: <20200414142630.21153-1-krzk@kernel.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: virtualization@lists.linuxfoundation.org

Although SPAPR_TCE_IOMMU itself can be compile tested on certain PowerPC
configurations, its presence makes arch/powerpc/kvm/Makefile to select
modules which do not build in such configuration.

The arch/powerpc/kvm/ modules use kvm_arch.spapr_tce_tables which exists
only with CONFIG_PPC_BOOK3S_64.  However these modules are selected when
COMPILE_TEST and SPAPR_TCE_IOMMU are chosen leading to build failures:

    In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20:0,
                     from arch/powerpc/kvm/book3s_64_vio_hv.c:22:
    arch/powerpc/include/asm/book3s/64/pgtable.h:17:0: error: "_PAGE_EXEC" redefined [-Werror]
     #define _PAGE_EXEC  0x00001 /* execute permission */

    In file included from arch/powerpc/include/asm/book3s/32/pgtable.h:8:0,
                     from arch/powerpc/include/asm/book3s/pgtable.h:8,
                     from arch/powerpc/include/asm/pgtable.h:18,
                     from include/linux/mm.h:95,
                     from arch/powerpc/include/asm/io.h:29,
                     from include/linux/io.h:13,
                     from include/linux/irq.h:20,
                     from arch/powerpc/include/asm/hardirq.h:6,
                     from include/linux/hardirq.h:9,
                     from include/linux/kvm_host.h:7,
                     from arch/powerpc/kvm/book3s_64_vio_hv.c:12:
    arch/powerpc/include/asm/book3s/32/hash.h:29:0: note: this is the location of the previous definition
     #define _PAGE_EXEC 0x200 /* software: exec allowed */

Reported-by: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
Signed-off-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 58b4a4dbfc78..3532b1ead19d 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -362,7 +362,7 @@ config IPMMU_VMSA
 
 config SPAPR_TCE_IOMMU
 	bool "sPAPR TCE IOMMU Support"
-	depends on PPC_POWERNV || PPC_PSERIES || (PPC && COMPILE_TEST)
+	depends on PPC_POWERNV || PPC_PSERIES
 	select IOMMU_API
 	help
 	  Enables bits of IOMMU API required by VFIO. The iommu_ops
-- 
2.17.1
