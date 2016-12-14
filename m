From: Piotr Gregor <piotrgregor@rsyncme.org>
Subject: [PATCH] arch: x86: kernel: fixed unused label issue
Date: Wed, 14 Dec 2016 11:15:13 +0000
Message-ID: <20161214111510.GA23861__33450.0052188106$1481829978$gmane$org@westernst>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tglx@linutronix.de
Cc: jeremy@goop.org, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, hpa@zytor.com, akataria@vmware.com
List-Id: virtualization@lists.linuxfoundation.org

The patch_default label is only used from within
	case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock)
and
	case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted)
i.e. when #if defined(CONFIG_PARAVIRT_SPINLOCKS) is true.
Therefore no code jumps to this label in case CONFIG_PARAVIRT_SPINLOCKS
is not defined and label should be removed in that case.
Moving #endif directive just after that label fixes the issue.

In addition,there are three errors reported by checkpatch script
on this file. This commit fixes two of them. The last one is
	ERROR: Macros with multiple statements should be enclosed
	in a do - while loop
which probably is a false alarm here as PATCH_SITE macro defines
a case in switch local to native_patch function not meant to be used
in other places.

Signed-off-by: Piotr Gregor <piotrgregor@rsyncme.org>
---
 arch/x86/kernel/paravirt_patch_64.c | 67 +++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/arch/x86/kernel/paravirt_patch_64.c b/arch/x86/kernel/paravirt_patch_64.c
index f4fcf26..7ce2848 100644
--- a/arch/x86/kernel/paravirt_patch_64.c
+++ b/arch/x86/kernel/paravirt_patch_64.c
@@ -44,43 +44,44 @@ unsigned native_patch(u8 type, u16 clobbers, void *ibuf,
 	const unsigned char *start, *end;
 	unsigned ret;
 
-#define PATCH_SITE(ops, x)					\
-		case PARAVIRT_PATCH(ops.x):			\
-			start = start_##ops##_##x;		\
-			end = end_##ops##_##x;			\
-			goto patch_site
-	switch(type) {
-		PATCH_SITE(pv_irq_ops, restore_fl);
-		PATCH_SITE(pv_irq_ops, save_fl);
-		PATCH_SITE(pv_irq_ops, irq_enable);
-		PATCH_SITE(pv_irq_ops, irq_disable);
-		PATCH_SITE(pv_cpu_ops, usergs_sysret64);
-		PATCH_SITE(pv_cpu_ops, swapgs);
-		PATCH_SITE(pv_mmu_ops, read_cr2);
-		PATCH_SITE(pv_mmu_ops, read_cr3);
-		PATCH_SITE(pv_mmu_ops, write_cr3);
-		PATCH_SITE(pv_mmu_ops, flush_tlb_single);
-		PATCH_SITE(pv_cpu_ops, wbinvd);
+#define PATCH_SITE(ops, x)				\
+	case PARAVIRT_PATCH(ops.x):			\
+		start = start_##ops##_##x;		\
+		end = end_##ops##_##x;			\
+		goto patch_site
+
+	switch (type) {
+	PATCH_SITE(pv_irq_ops, restore_fl);
+	PATCH_SITE(pv_irq_ops, save_fl);
+	PATCH_SITE(pv_irq_ops, irq_enable);
+	PATCH_SITE(pv_irq_ops, irq_disable);
+	PATCH_SITE(pv_cpu_ops, usergs_sysret64);
+	PATCH_SITE(pv_cpu_ops, swapgs);
+	PATCH_SITE(pv_mmu_ops, read_cr2);
+	PATCH_SITE(pv_mmu_ops, read_cr3);
+	PATCH_SITE(pv_mmu_ops, write_cr3);
+	PATCH_SITE(pv_mmu_ops, flush_tlb_single);
+	PATCH_SITE(pv_cpu_ops, wbinvd);
 #if defined(CONFIG_PARAVIRT_SPINLOCKS)
-		case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
-			if (pv_is_native_spin_unlock()) {
-				start = start_pv_lock_ops_queued_spin_unlock;
-				end   = end_pv_lock_ops_queued_spin_unlock;
-				goto patch_site;
-			}
-			goto patch_default;
+	case PARAVIRT_PATCH(pv_lock_ops.queued_spin_unlock):
+		if (pv_is_native_spin_unlock()) {
+			start = start_pv_lock_ops_queued_spin_unlock;
+			end   = end_pv_lock_ops_queued_spin_unlock;
+			goto patch_site;
+		}
+		goto patch_default;
 
-		case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
-			if (pv_is_native_vcpu_is_preempted()) {
-				start = start_pv_lock_ops_vcpu_is_preempted;
-				end   = end_pv_lock_ops_vcpu_is_preempted;
-				goto patch_site;
-			}
-			goto patch_default;
-#endif
+	case PARAVIRT_PATCH(pv_lock_ops.vcpu_is_preempted):
+		if (pv_is_native_vcpu_is_preempted()) {
+			start = start_pv_lock_ops_vcpu_is_preempted;
+			end   = end_pv_lock_ops_vcpu_is_preempted;
+			goto patch_site;
+		}
+		goto patch_default;
 
-	default:
 patch_default:
+#endif
+	default:
 		ret = paravirt_patch_default(type, clobbers, ibuf, addr, len);
 		break;
 
-- 
2.1.4
