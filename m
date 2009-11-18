From: Alexander Graf <agraf@suse.de>
Subject: [PATCH 3/3] Split the KVM pv-ops support by feature
Date: Wed, 18 Nov 2009 01:13:12 +0100
Message-ID: <1258503192-14246-4-git-send-email-agraf__13130.0346031368$1258503292$gmane$org@suse.de>
References: <1258503192-14246-1-git-send-email-agraf@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258503192-14246-1-git-send-email-agraf@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm list <kvm@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently selecting KVM guest support enabled multiple features at once that
not everyone necessarily wants to have, namely:

 - PV MMU
 - zero io delay
 - apic detection workaround

Let's split them off so we don't drag in the full pv-ops framework just to
detect we're running on KVM. That gives us more chances to tweak performance!

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/x86/Kconfig      |   29 ++++++++++++++++++++++++++++-
 arch/x86/kernel/kvm.c |   22 +++++++++++++++-------
 2 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8c150b6..97d4f92 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -522,11 +522,38 @@ config KVM_CLOCK
 
 config KVM_GUEST
 	bool "KVM Guest support"
-	select PARAVIRT_ALL
+	select PARAVIRT
 	---help---
 	  This option enables various optimizations for running under the KVM
 	  hypervisor.
 
+config KVM_IODELAY
+	bool "KVM IO-delay support"
+	depends on KVM_GUEST
+	select PARAVIRT_CPU
+	---help---
+	  Usually we wait for PIO access to complete. When inside KVM there's
+	  no need to do that, as we know that we're not going through a bus,
+	  but process PIO requests instantly.
+
+	  This option disables PIO waits, but drags in CPU-bound pv-ops. Thus
+	  you will probably get more speed loss than speedup using this option.
+
+	  If in doubt, say N.
+
+config KVM_MMU
+	bool "KVM PV MMU support"
+	depends on KVM_GUEST
+	select PARAVIRT_MMU
+	---help---
+	  This option enables the paravirtualized MMU for KVM. In most cases
+	  it's pretty useless and shouldn't be used.
+
+	  It will only cost you performance, because it drags in pv-ops for
+	  memory management.
+
+	  If in doubt, say N.
+
 source "arch/x86/lguest/Kconfig"
 
 config PARAVIRT
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 63b0ec8..7e0207f 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -29,6 +29,16 @@
 #include <linux/hardirq.h>
 #include <asm/timer.h>
 
+#ifdef CONFIG_KVM_IODELAY
+/*
+ * No need for any "IO delay" on KVM
+ */
+static void kvm_io_delay(void)
+{
+}
+#endif  /* CONFIG_KVM_IODELAY */
+
+#ifdef CONFIG_KVM_MMU
 #define MMU_QUEUE_SIZE 1024
 
 struct kvm_para_state {
@@ -43,13 +53,6 @@ static struct kvm_para_state *kvm_para_state(void)
 	return &per_cpu(para_state, raw_smp_processor_id());
 }
 
-/*
- * No need for any "IO delay" on KVM
- */
-static void kvm_io_delay(void)
-{
-}
-
 static void kvm_mmu_op(void *buffer, unsigned len)
 {
 	int r;
@@ -194,15 +197,19 @@ static void kvm_leave_lazy_mmu(void)
 	mmu_queue_flush(state);
 	paravirt_leave_lazy_mmu();
 }
+#endif  /* CONFIG_KVM_MMU */
 
 static void __init paravirt_ops_setup(void)
 {
 	pv_info.name = "KVM";
 	pv_info.paravirt_enabled = 1;
 
+#ifdef CONFIG_KVM_IODELAY
 	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
 		pv_cpu_ops.io_delay = kvm_io_delay;
+#endif
 
+#ifdef CONFIG_KVM_MMU
 	if (kvm_para_has_feature(KVM_FEATURE_MMU_OP)) {
 		pv_mmu_ops.set_pte = kvm_set_pte;
 		pv_mmu_ops.set_pte_at = kvm_set_pte_at;
@@ -226,6 +233,7 @@ static void __init paravirt_ops_setup(void)
 		pv_mmu_ops.lazy_mode.enter = kvm_enter_lazy_mmu;
 		pv_mmu_ops.lazy_mode.leave = kvm_leave_lazy_mmu;
 	}
+#endif  /* CONFIG_KVM_MMU */
 #ifdef CONFIG_X86_IO_APIC
 	no_timer_check = 1;
 #endif
-- 
1.6.0.2
