From: Glauber de Oliveira Costa <gcosta@redhat.com>
Subject: [PATCH 13/16] native versions for page table entries values
Date: Wed, 31 Oct 2007 16:14:58 -0300
Message-ID: <11938581713998-git-send-email-gcosta__9234.97843691639$1193869099$gmane$org@redhat.com>
References: <1193858101367-git-send-email-gcosta@redhat.com>
	<11938581073775-git-send-email-gcosta@redhat.com>
	<11938581133479-git-send-email-gcosta@redhat.com>
	<1193858118284-git-send-email-gcosta@redhat.com>
	<11938581242810-git-send-email-gcosta@redhat.com>
	<1193858130443-git-send-email-gcosta@redhat.com>
	<11938581351064-git-send-email-gcosta@redhat.com>
	<11938581403478-git-send-email-gcosta@redhat.com>
	<11938581451804-git-send-email-gcosta@redhat.com>
	<11938581512730-git-send-email-gcosta@redhat.com>
	<11938581562552-git-send-email-gcosta@redhat.com>
	<11938581612389-git-send-email-gcosta@redhat.com>
	<11938581663639-git-send-email-gcosta@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11938581663639-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: lguest@ozlabs.org, kvm-devel@lists.sourceforge.net, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, akpm@linux-foundation.org, Glauber de Oliveira Costa <gcosta@redhat.com>, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

This patch turns the page operations (set and make a page table)
into native_ versions. The operations itself will be later
overriden by paravirt.

It uses unsigned long long for consistency with 32-bit. So we
have to fix fault_64.c to get rid of warnings.

Signed-off-by: Glauber de Oliveira Costa <gcosta@redhat.com>
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Jeremy Fitzhardinge <jeremy@xensource.com>
---
 arch/x86/mm/fault_64.c    |    8 +++---
 include/asm-x86/page_64.h |   56 +++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/fault_64.c b/arch/x86/mm/fault_64.c
index 644b4f7..725c574 100644
--- a/arch/x86/mm/fault_64.c
+++ b/arch/x86/mm/fault_64.c
@@ -158,22 +158,22 @@ void dump_pagetable(unsigned long address)
 	pgd = __va((unsigned long)pgd & PHYSICAL_PAGE_MASK); 
 	pgd += pgd_index(address);
 	if (bad_address(pgd)) goto bad;
-	printk("PGD %lx ", pgd_val(*pgd));
+	printk("PGD %llx ", pgd_val(*pgd));
 	if (!pgd_present(*pgd)) goto ret; 
 
 	pud = pud_offset(pgd, address);
 	if (bad_address(pud)) goto bad;
-	printk("PUD %lx ", pud_val(*pud));
+	printk("PUD %llx ", pud_val(*pud));
 	if (!pud_present(*pud))	goto ret;
 
 	pmd = pmd_offset(pud, address);
 	if (bad_address(pmd)) goto bad;
-	printk("PMD %lx ", pmd_val(*pmd));
+	printk("PMD %llx ", pmd_val(*pmd));
 	if (!pmd_present(*pmd) || pmd_large(*pmd)) goto ret;
 
 	pte = pte_offset_kernel(pmd, address);
 	if (bad_address(pte)) goto bad;
-	printk("PTE %lx", pte_val(*pte)); 
+	printk("PTE %llx", pte_val(*pte));
 ret:
 	printk("\n");
 	return;
diff --git a/include/asm-x86/page_64.h b/include/asm-x86/page_64.h
index c3b52bc..71d5c27 100644
--- a/include/asm-x86/page_64.h
+++ b/include/asm-x86/page_64.h
@@ -64,16 +64,62 @@ typedef struct { unsigned long pgprot; } pgprot_t;
 
 extern unsigned long phys_base;
 
-#define pte_val(x)	((x).pte)
-#define pmd_val(x)	((x).pmd)
-#define pud_val(x)	((x).pud)
-#define pgd_val(x)	((x).pgd)
-#define pgprot_val(x)	((x).pgprot)
+static inline unsigned long long native_pte_val(pte_t pte)
+{
+	return pte.pte;
+}
+
+static inline unsigned long long native_pud_val(pud_t pud)
+{
+	return pud.pud;
+}
+
+
+static inline unsigned long long native_pmd_val(pmd_t pmd)
+{
+	return pmd.pmd;
+}
+
+static inline unsigned long long native_pgd_val(pgd_t pgd)
+{
+	return pgd.pgd;
+}
+
+static inline pte_t native_make_pte(unsigned long long pte)
+{
+	return (pte_t){ pte };
+}
+
+static inline pud_t native_make_pud(unsigned long long pud)
+{
+	return (pud_t){ pud };
+}
+
+static inline pmd_t native_make_pmd(unsigned long long pmd)
+{
+	return (pmd_t){ pmd };
+}
+
+static inline pgd_t native_make_pgd(unsigned long long pgd)
+{
+	return (pgd_t){ pgd };
+}
+
+#ifdef CONFIG_PARAVIRT
+#include <asm/paravirt.h>
+#else
+#define pte_val(x)	native_pte_val(x)
+#define pmd_val(x)	native_pmd_val(x)
+#define pud_val(x)	native_pud_val(x)
+#define pgd_val(x)	native_pgd_val(x)
 
 #define __pte(x) ((pte_t) { (x) } )
 #define __pmd(x) ((pmd_t) { (x) } )
 #define __pud(x) ((pud_t) { (x) } )
 #define __pgd(x) ((pgd_t) { (x) } )
+#endif /* CONFIG_PARAVIRT */
+
+#define pgprot_val(x)	((x).pgprot)
 #define __pgprot(x)	((pgprot_t) { (x) } )
 
 #endif /* !__ASSEMBLY__ */
-- 
1.4.4.2
