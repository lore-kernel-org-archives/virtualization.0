From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH] [RESEND] xen: portability clean up and some minor clean up
	for xencomm.c
Date: Tue, 26 Aug 2008 14:31:25 +0900
Message-ID: <20080826053125.GF1496%yamahata__16008.165133144$1219728809$gmane$org@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, "Luck,
	Tony" <tony.luck@intel.com>, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

clean up of xencomm.c. is_phys_contiguous() is arch dependent
function that depends on how virtual memory are laid out.
So split out the function into arch specific code.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: "Luck, Tony" <tony.luck@intel.com>
---
 drivers/xen/xencomm.c |   23 ++++-------------------
 1 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/xen/xencomm.c b/drivers/xen/xencomm.c
index 797cb4e..a240b2c 100644
--- a/drivers/xen/xencomm.c
+++ b/drivers/xen/xencomm.c
@@ -23,13 +23,7 @@
 #include <asm/page.h>
 #include <xen/xencomm.h>
 #include <xen/interface/xen.h>
-#ifdef __ia64__
-#include <asm/xen/xencomm.h>	/* for is_kern_addr() */
-#endif
-
-#ifdef HAVE_XEN_PLATFORM_COMPAT_H
-#include <xen/platform-compat.h>
-#endif
+#include <asm/xen/xencomm.h>	/* for xencomm_is_phys_contiguous() */
 
 static int xencomm_init(struct xencomm_desc *desc,
 			void *buffer, unsigned long bytes)
@@ -157,20 +151,11 @@ static int xencomm_create(void *buffer, unsigned long bytes,
 	return 0;
 }
 
-/* check if memory address is within VMALLOC region  */
-static int is_phys_contiguous(unsigned long addr)
-{
-	if (!is_kernel_addr(addr))
-		return 0;
-
-	return (addr < VMALLOC_START) || (addr >= VMALLOC_END);
-}
-
 static struct xencomm_handle *xencomm_create_inline(void *ptr)
 {
 	unsigned long paddr;
 
-	BUG_ON(!is_phys_contiguous((unsigned long)ptr));
+	BUG_ON(!xencomm_is_phys_contiguous((unsigned long)ptr));
 
 	paddr = (unsigned long)xencomm_pa(ptr);
 	BUG_ON(paddr & XENCOMM_INLINE_FLAG);
@@ -202,7 +187,7 @@ struct xencomm_handle *xencomm_map(void *ptr, unsigned long bytes)
 	int rc;
 	struct xencomm_desc *desc;
 
-	if (is_phys_contiguous((unsigned long)ptr))
+	if (xencomm_is_phys_contiguous((unsigned long)ptr))
 		return xencomm_create_inline(ptr);
 
 	rc = xencomm_create(ptr, bytes, &desc, GFP_KERNEL);
@@ -219,7 +204,7 @@ struct xencomm_handle *__xencomm_map_no_alloc(void *ptr, unsigned long bytes,
 	int rc;
 	struct xencomm_desc *desc = NULL;
 
-	if (is_phys_contiguous((unsigned long)ptr))
+	if (xencomm_is_phys_contiguous((unsigned long)ptr))
 		return xencomm_create_inline(ptr);
 
 	rc = xencomm_create_mini(ptr, bytes, xc_desc,
-- 
1.6.0.rc0.42.g186458
