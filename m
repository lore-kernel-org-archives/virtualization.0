From: Eduardo Habkost <ehabkost@redhat.com>
Subject: [PATCH 4/4] Fill in missing pv_mmu_ops entries for PAGETABLE_LEVELS
	>= 3
Date: Mon, 21 Jan 2008 19:48:53 -0200
Message-ID: <1200952133-31581-5-git-send-email-ehabkost__4948.23794947496$1200952761$gmane$org@redhat.com>
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

This finally makes paravirt-ops able to compile and boot under x86_64.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 arch/x86/kernel/paravirt.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 37f38b7..075962c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -398,16 +398,23 @@ struct pv_mmu_ops pv_mmu_ops = {
 	.kmap_atomic_pte = kmap_atomic,
 #endif
 
+#if PAGETABLE_LEVELS >= 3
 #ifdef CONFIG_X86_PAE
 	.set_pte_atomic = native_set_pte_atomic,
 	.set_pte_present = native_set_pte_present,
-	.set_pud = native_set_pud,
 	.pte_clear = native_pte_clear,
 	.pmd_clear = native_pmd_clear,
-
+#endif
+	.set_pud = native_set_pud,
 	.pmd_val = native_pmd_val,
 	.make_pmd = native_make_pmd,
+
+#if PAGETABLE_LEVELS == 4
+	.pud_val = native_pud_val,
+	.make_pud = native_make_pud,
+	.set_pgd = native_set_pgd,
 #endif
+#endif /* PAGETABLE_LEVELS >= 3 */
 
 	.pte_val = native_pte_val,
 	.pgd_val = native_pgd_val,
-- 
1.5.3.4
