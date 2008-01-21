From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 2/4] include/asm-x86/paravirt.h: x86_64 mmu operations
Date: Mon, 21 Jan 2008 19:48:51 -0200
Message-ID: <1200952133-31581-3-git-send-email-ehabkost__28926.0650905364$1200952586$gmane$org@redhat.com>
References: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1200952133-31581-1-git-send-email-ehabkost@redhat.com>
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
Cc: ehabkost@redhat.com, ak@suse.de, virtualization@lists.linux-foundation.org, chrisw@sous-sol.org, tglx@linutronix.de, anthony@codemonkey.ws, hpa@zytor.com, akpm@linux-foundation.org, mingo@elte.hu, roland@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

Add .set_pgd field to pv_mmu_ops.

Implement pud_val(), __pud(), set_pgd(), pud_clear(), pgd_clear().

pud_clear() and pgd_clear() are implemented simply using set_pud()
and set_pmd(). They don't have a field at pv_mmu_ops.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/asm-x86/paravirt.h |   55 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 55 insertions(+), 0 deletions(-)

diff --git a/include/asm-x86/paravirt.h b/include/asm-x86/paravirt.h
index 62cecb7..9f9ff57 100644
--- a/include/asm-x86/paravirt.h
+++ b/include/asm-x86/paravirt.h
@@ -259,6 +259,8 @@ struct pv_mmu_ops {
 #if PAGETABLE_LEVELS == 4
 	pudval_t (*pud_val)(pud_t);
 	pud_t (*make_pud)(pudval_t pud);
+
+	void (*set_pgd)(pgd_t *pudp, pgd_t pgdval);
 #endif	/* PAGETABLE_LEVELS == 4 */
 #endif	/* PAGETABLE_LEVELS >= 3 */
 
@@ -1065,6 +1067,59 @@ static inline void set_pud(pud_t *pudp, pud_t pud)
 		PVOP_VCALL2(pv_mmu_ops.set_pud, pudp,
 			    val);
 }
+#if PAGETABLE_LEVELS == 4
+static inline pud_t __pud(pudval_t val)
+{
+	pudval_t ret;
+
+	if (sizeof(pudval_t) > sizeof(long))
+		ret = PVOP_CALL2(pudval_t, pv_mmu_ops.make_pud,
+				 val, (u64)val >> 32);
+	else
+		ret = PVOP_CALL1(pudval_t, pv_mmu_ops.make_pud,
+				 val);
+
+	return (pud_t) { ret };
+}
+
+static inline pudval_t pud_val(pud_t pud)
+{
+	pudval_t ret;
+
+	if (sizeof(pudval_t) > sizeof(long))
+		ret =  PVOP_CALL2(pudval_t, pv_mmu_ops.pud_val,
+				  pud.pud, (u64)pud.pud >> 32);
+	else
+		ret =  PVOP_CALL1(pudval_t, pv_mmu_ops.pud_val,
+				  pud.pud);
+
+	return ret;
+}
+
+static inline void set_pgd(pgd_t *pgdp, pgd_t pgd)
+{
+	pgdval_t val = native_pgd_val(pgd);
+
+	if (sizeof(pgdval_t) > sizeof(long))
+		PVOP_VCALL3(pv_mmu_ops.set_pgd, pgdp,
+			    val, (u64)val >> 32);
+	else
+		PVOP_VCALL2(pv_mmu_ops.set_pgd, pgdp,
+			    val);
+}
+
+static inline void pgd_clear(pgd_t *pgdp)
+{
+	set_pgd(pgdp, __pgd(0));
+}
+
+static inline void pud_clear(pud_t *pudp)
+{
+	set_pud(pudp, __pud(0));
+}
+
+#endif	/* PAGETABLE_LEVELS == 4 */
+
 #endif	/* PAGETABLE_LEVELS >= 3 */
 
 #ifdef CONFIG_X86_PAE
-- 
1.5.3.4
