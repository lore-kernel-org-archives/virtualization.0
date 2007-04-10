From: Zachary Amsden <zach@vmware.com>
Subject: [PATCH 8/10] Vmi kmap_atomic_pte fix.patch
Date: Mon, 9 Apr 2007 17:06:24 -0700
Message-ID: <200704100006.l3A06OeU020638@zach-dev.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Jeremy Fitzhardinge <jeremy@goop.org>, Rusty Russell <rusty@rustcorp.com.au>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zachary Amsden <zach@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

Implement vmi_kmap_atomic_pte in terms of the backend set_linear_mapping
operation.  The conversion is rather straighforward; call kmap_atomic
and then inform the hypervisor of the page mapping.

The _flush_tlb damage is due to macros being pulled in from highmem.h.

Signed-off-by: Zachary Amsden <zach@vmware.com>

diff -r 2207a31829e7 arch/i386/kernel/vmi.c
--- a/arch/i386/kernel/vmi.c	Mon Apr 09 13:43:06 2007 -0700
+++ b/arch/i386/kernel/vmi.c	Mon Apr 09 15:05:33 2007 -0700
@@ -26,6 +26,7 @@
 #include <linux/cpu.h>
 #include <linux/bootmem.h>
 #include <linux/mm.h>
+#include <linux/highmem.h>
 #include <asm/vmi.h>
 #include <asm/io.h>
 #include <asm/fixmap.h>
@@ -65,8 +66,8 @@ static struct {
 	void (*release_page)(u32, u32);
 	void (*set_pte)(pte_t, pte_t *, unsigned);
 	void (*update_pte)(pte_t *, unsigned);
-	void (*set_linear_mapping)(int, u32, u32, u32);
-	void (*flush_tlb)(int);
+	void (*set_linear_mapping)(int, void *, u32, u32);
+	void (*_flush_tlb)(int);
 	void (*set_initial_ap_state)(int, int);
 	void (*halt)(void);
   	void (*set_lazy_mode)(int mode);
@@ -217,12 +218,12 @@ static void vmi_load_esp0(struct tss_str
 =

 static void vmi_flush_tlb_user(void)
 {
-	vmi_ops.flush_tlb(VMI_FLUSH_TLB);
+	vmi_ops._flush_tlb(VMI_FLUSH_TLB);
 }
 =

 static void vmi_flush_tlb_kernel(void)
 {
-	vmi_ops.flush_tlb(VMI_FLUSH_TLB | VMI_FLUSH_GLOBAL);
+	vmi_ops._flush_tlb(VMI_FLUSH_TLB | VMI_FLUSH_GLOBAL);
 }
 =

 /* Stub to do nothing at all; used for delays and unimplemented calls */
@@ -345,8 +346,11 @@ static void vmi_check_page_type(u32 pfn,
 #define vmi_check_page_type(p,t) do { } while (0)
 #endif
 =

-static void vmi_map_pt_hook(int type, pte_t *va, u32 pfn)
-{
+#ifdef CONFIG_HIGHPTE
+static void *vmi_kmap_atomic_pte(struct page *page, enum km_type type)
+{
+	void *va =3D kmap_atomic(page, type);
+
 	/*
 	 * Internally, the VMI ROM must map virtual addresses to physical
 	 * addresses for processing MMU updates.  By the time MMU updates
@@ -360,8 +364,11 @@ static void vmi_map_pt_hook(int type, pt
 	 *  args:                 SLOT                 VA    COUNT PFN
 	 */
 	BUG_ON(type !=3D KM_PTE0 && type !=3D KM_PTE1);
-	vmi_ops.set_linear_mapping((type - KM_PTE0)+1, (u32)va, 1, pfn);
-}
+	vmi_ops.set_linear_mapping((type - KM_PTE0)+1, va, 1, page_to_pfn(page));
+
+	return va;
+}
+#endif
 =

 static void vmi_allocate_pt(u32 pfn)
 {
@@ -656,7 +663,7 @@ void vmi_bringup(void)
 {
  	/* We must establish the lowmem mapping for MMU ops to work */
 	if (vmi_ops.set_linear_mapping)
-		vmi_ops.set_linear_mapping(0, __PAGE_OFFSET, max_low_pfn, 0);
+		vmi_ops.set_linear_mapping(0, (void *)__PAGE_OFFSET, max_low_pfn, 0);
 }
 =

 /*
@@ -793,8 +800,8 @@ static inline int __init activate_vmi(vo
 	para_wrap(set_lazy_mode, vmi_set_lazy_mode, set_lazy_mode, SetLazyMode);
 =

 	/* user and kernel flush are just handled with different flags to FlushTL=
B */
-	para_wrap(flush_tlb_user, vmi_flush_tlb_user, flush_tlb, FlushTLB);
-	para_wrap(flush_tlb_kernel, vmi_flush_tlb_kernel, flush_tlb, FlushTLB);
+	para_wrap(flush_tlb_user, vmi_flush_tlb_user, _flush_tlb, FlushTLB);
+	para_wrap(flush_tlb_kernel, vmi_flush_tlb_kernel, _flush_tlb, FlushTLB);
 	para_fill(flush_tlb_single, InvalPage);
 =

 	/*
@@ -840,9 +847,12 @@ static inline int __init activate_vmi(vo
 		paravirt_ops.release_pt =3D vmi_release_pt;
 		paravirt_ops.release_pd =3D vmi_release_pd;
 	}
-#if 0
-	para_wrap(map_pt_hook, vmi_map_pt_hook, set_linear_mapping,
-		  SetLinearMapping);
+
+	/* Set linear is needed in all cases */
+	vmi_ops.set_linear_mapping =3D vmi_get_function(VMI_CALL_SetLinearMapping=
);
+#ifdef CONFIG_HIGHPTE
+	if (vmi_ops.set_linear_mapping)
+		paravirt_ops.kmap_atomic_pte =3D vmi_kmap_atomic_pte;
 #endif
 =

 	/*
