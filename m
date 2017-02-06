From: Waiman Long <longman@redhat.com>
Subject: [PATCH] x86/paravirt: Avoid setting IF flag, if not necessary
Date: Mon,  6 Feb 2017 16:02:41 -0500
Message-ID: <1486414961-1065-1-git-send-email-longman@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>, Chris Wright <chrisw@sous-sol.org>, Alok Kataria <akataria@vmware.com>, Rusty Russell <rusty@rustcorp.com.au>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Waiman Long <longman@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Setting the IF flag can cause an VM exit. So we should avoid touching
the IF flag until absolutely necessary. This patch change the way
the paravirt arch_local_irq_restore() works by checking the previous
flags value and call arch_local_irq_enable() only if the IF flag was
set previously.

On a 32 vCPUs KVM guest running the AIM7 five-sec workload,
the performance increased slightly from 302136.32 jobs/min to
306185.57 (about 1.3%) jobs/min and the %CPU time consumed by
_raw_spin_unlock_irqrestore decreased slightly from 1.68% to 1.53%
with this patch.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 arch/x86/include/asm/paravirt.h | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 1eea6ca..864f57b 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -6,6 +6,7 @@
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
+#include <asm/processor-flags.h>
 
 #include <asm/paravirt_types.h>
 
@@ -762,11 +763,6 @@ static inline notrace unsigned long arch_local_save_flags(void)
 	return PVOP_CALLEE0(unsigned long, pv_irq_ops.save_fl);
 }
 
-static inline notrace void arch_local_irq_restore(unsigned long f)
-{
-	PVOP_VCALLEE1(pv_irq_ops.restore_fl, f);
-}
-
 static inline notrace void arch_local_irq_disable(void)
 {
 	PVOP_VCALLEE0(pv_irq_ops.irq_disable);
@@ -786,6 +782,16 @@ static inline notrace unsigned long arch_local_irq_save(void)
 	return f;
 }
 
+/*
+ * In a VM, setting the IF flag can cause an expensive VM exit. So if
+ * interrupt was disabled before arch_local_irq_save(), we don't need to
+ * do anything at all, thus saving an VM exit.
+ */
+static inline notrace void arch_local_irq_restore(unsigned long f)
+{
+	if (f & X86_EFLAGS_IF)
+		arch_local_irq_enable();
+}
 
 /* Make sure as little as possible of this mess escapes. */
 #undef PARAVIRT_CALL
-- 
1.8.3.1
