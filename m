From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 01/15] ia64: preparation: remove extern in irq_ia64.c
Date: Wed, 30 Apr 2008 21:29:14 +0900
Message-ID: <1209558568892-git-send-email-yamahata__1916.32697028599$1209561713$gmane$org@valinux.co.jp>
References: <12095585682308-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12095585682308-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tony.luck@intel.com, linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, xen-ia64-devel@lists.xensource.com, eddie.dong@intel.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

remove extern declaration of handle_IPI() in irq_ia64.c.
Instead, declare it in asm-ia64/smp.h.
Later handle_IPI() will be referenced from another file.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/irq_ia64.c |    1 -
 include/asm-ia64/smp.h      |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/kernel/irq_ia64.c b/arch/ia64/kernel/irq_ia64.c
index 5538471..c48171b 100644
--- a/arch/ia64/kernel/irq_ia64.c
+++ b/arch/ia64/kernel/irq_ia64.c
@@ -600,7 +600,6 @@ static irqreturn_t dummy_handler (int irq, void *dev_id)
 {
 	BUG();
 }
-extern irqreturn_t handle_IPI (int irq, void *dev_id);
 
 static struct irqaction ipi_irqaction = {
 	.handler =	handle_IPI,
diff --git a/include/asm-ia64/smp.h b/include/asm-ia64/smp.h
index ec5f355..2984e26 100644
--- a/include/asm-ia64/smp.h
+++ b/include/asm-ia64/smp.h
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/cpumask.h>
 #include <linux/bitops.h>
+#include <linux/irqreturn.h>
 
 #include <asm/io.h>
 #include <asm/param.h>
@@ -123,6 +124,7 @@ extern void __init smp_build_cpu_map(void);
 extern void __init init_smp_config (void);
 extern void smp_do_timer (struct pt_regs *regs);
 
+extern irqreturn_t handle_IPI(int irq, void *dev_id);
 extern void smp_send_reschedule (int cpu);
 extern void lock_ipi_calllock(void);
 extern void unlock_ipi_calllock(void);
-- 
1.5.3
