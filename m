From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: [patch 15/17] revert map_pt_hook.
Date: Sun, 01 Apr 2007 22:57:07 -0700
Message-ID: <20070402055705.399001017@goop.org>
References: <20070402055652.610711908@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline; filename=revert-map_pt_hook.patch
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Back out the map_pt_hook to clear the way for kmap_atomic_pte.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Zachary Amsden <zach@vmware.com>

---
 arch/i386/kernel/paravirt.c |    2 --
 arch/i386/kernel/vmi.c      |    2 ++
 include/asm-i386/paravirt.h |    7 -------
 include/asm-i386/pgtable.h  |   23 ++++-------------------
 4 files changed, 6 insertions(+), 28 deletions(-)

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/paravirt.c
+++ b/arch/i386/kernel/paravirt.c
@@ -303,8 +303,6 @@ struct paravirt_ops paravirt_ops =3D {
 	.flush_tlb_single =3D native_flush_tlb_single,
 	.flush_tlb_others =3D native_flush_tlb_others,
 =

-	.map_pt_hook =3D paravirt_nop,
-
 	.alloc_pt =3D paravirt_nop,
 	.alloc_pd =3D paravirt_nop,
 	.alloc_pd_clone =3D paravirt_nop,
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/i386/kernel/vmi.c
+++ b/arch/i386/kernel/vmi.c
@@ -819,8 +819,10 @@ static inline int __init activate_vmi(vo
 		paravirt_ops.release_pt =3D vmi_release_pt;
 		paravirt_ops.release_pd =3D vmi_release_pd;
 	}
+#if 0
 	para_wrap(map_pt_hook, vmi_map_pt_hook, set_linear_mapping,
 		  SetLinearMapping);
+#endif
 =

 	/*
 	 * These MUST always be patched.  Don't support indirect jumps
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/paravirt.h
+++ b/include/asm-i386/paravirt.h
@@ -128,8 +128,6 @@ struct paravirt_ops
 	void (*flush_tlb_single)(unsigned long addr);
 	void (*flush_tlb_others)(const cpumask_t *cpus, struct mm_struct *mm,
 				 unsigned long va);
-
-	void (*map_pt_hook)(int type, pte_t *va, u32 pfn);
 =

 	void (*alloc_pt)(u32 pfn);
 	void (*alloc_pd)(u32 pfn);
@@ -740,11 +738,6 @@ static inline void flush_tlb_others(cpum
 	PVOP_VCALL3(flush_tlb_others, &cpumask, mm, va);
 }
 =

-static inline void paravirt_map_pt_hook(int type, pte_t *va, u32 pfn)
-{
-	PVOP_VCALL3(map_pt_hook, type, va, pfn);
-}
-
 static inline void paravirt_alloc_pt(unsigned pfn)
 {
 	PVOP_VCALL1(alloc_pt, pfn);
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-i386/pgtable.h
+++ b/include/asm-i386/pgtable.h
@@ -272,7 +272,6 @@ static inline void vmalloc_sync_all(void
  */
 #define pte_update(mm, addr, ptep)		do { } while (0)
 #define pte_update_defer(mm, addr, ptep)	do { } while (0)
-#define paravirt_map_pt_hook(slot, va, pfn)	do { } while (0)
 =

 #define raw_ptep_get_and_clear(xp)     native_ptep_get_and_clear(xp)
 #endif
@@ -481,24 +480,10 @@ extern pte_t *lookup_address(unsigned lo
 #endif
 =

 #if defined(CONFIG_HIGHPTE)
-#define pte_offset_map(dir, address)				\
-({								\
-	pte_t *__ptep;						\
-	unsigned pfn =3D pmd_val(*(dir)) >> PAGE_SHIFT;	   	\
-	__ptep =3D (pte_t *)kmap_atomic(pfn_to_page(pfn),KM_PTE0);\
-	paravirt_map_pt_hook(KM_PTE0,__ptep, pfn);		\
-	__ptep =3D __ptep + pte_index(address);			\
-	__ptep;							\
-})
-#define pte_offset_map_nested(dir, address)			\
-({								\
-	pte_t *__ptep;						\
-	unsigned pfn =3D pmd_val(*(dir)) >> PAGE_SHIFT;	   	\
-	__ptep =3D (pte_t *)kmap_atomic(pfn_to_page(pfn),KM_PTE1);\
-	paravirt_map_pt_hook(KM_PTE1,__ptep, pfn);		\
-	__ptep =3D __ptep + pte_index(address);			\
-	__ptep;							\
-})
+#define pte_offset_map(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE0) + pte_index(address))
+#define pte_offset_map_nested(dir, address) \
+	((pte_t *)kmap_atomic(pmd_page(*(dir)),KM_PTE1) + pte_index(address))
 #define pte_unmap(pte) kunmap_atomic(pte, KM_PTE0)
 #define pte_unmap_nested(pte) kunmap_atomic(pte, KM_PTE1)
 #else

-- =
