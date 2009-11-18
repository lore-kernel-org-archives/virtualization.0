From: Alexander Graf <agraf@suse.de>
Subject: [PATCH] Replace kvm io delay pv-ops with linux magic
Date: Wed, 18 Nov 2009 13:56:24 +0100
Message-ID: <1258548984-32433-1-git-send-email-agraf__8840.82039488039$1258549046$gmane$org@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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
To: kvm list <kvm@vger.kernel.org>
Cc: Nick Piggin <npiggin@suse.de>, Glauber Costa <glommer@redhat.com>, Avi Kivity <avi@redhat.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Currently we use pv-ops to tell linux not to do anything on io_delay.

While the basic idea is good IMHO, I don't see why we would need pv-ops
for that. The io delay function already has a switch that can do nothing
if you're so inclined.

So here's a patch (stacked on top of the previous pv-ops series) that
removes the io delay pv-ops hook and just sets the native io delay
variable instead.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/x86/Kconfig      |   14 --------------
 arch/x86/kernel/kvm.c |   16 +++-------------
 2 files changed, 3 insertions(+), 27 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 97d4f92..ebed686 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -527,20 +527,6 @@ config KVM_GUEST
 	  This option enables various optimizations for running under the KVM
 	  hypervisor.
 
-config KVM_IODELAY
-	bool "KVM IO-delay support"
-	depends on KVM_GUEST
-	select PARAVIRT_CPU
-	---help---
-	  Usually we wait for PIO access to complete. When inside KVM there's
-	  no need to do that, as we know that we're not going through a bus,
-	  but process PIO requests instantly.
-
-	  This option disables PIO waits, but drags in CPU-bound pv-ops. Thus
-	  you will probably get more speed loss than speedup using this option.
-
-	  If in doubt, say N.
-
 config KVM_MMU
 	bool "KVM PV MMU support"
 	depends on KVM_GUEST
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 7e0207f..be182e6 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -29,15 +29,6 @@
 #include <linux/hardirq.h>
 #include <asm/timer.h>
 
-#ifdef CONFIG_KVM_IODELAY
-/*
- * No need for any "IO delay" on KVM
- */
-static void kvm_io_delay(void)
-{
-}
-#endif  /* CONFIG_KVM_IODELAY */
-
 #ifdef CONFIG_KVM_MMU
 #define MMU_QUEUE_SIZE 1024
 
@@ -201,13 +192,12 @@ static void kvm_leave_lazy_mmu(void)
 
 static void __init paravirt_ops_setup(void)
 {
+	extern int io_delay_type;
 	pv_info.name = "KVM";
 	pv_info.paravirt_enabled = 1;
 
-#ifdef CONFIG_KVM_IODELAY
-	if (kvm_para_has_feature(KVM_FEATURE_NOP_IO_DELAY))
-		pv_cpu_ops.io_delay = kvm_io_delay;
-#endif
+	/* Disable IO delay */
+	io_delay_type = CONFIG_IO_DELAY_TYPE_NONE;
 
 #ifdef CONFIG_KVM_MMU
 	if (kvm_para_has_feature(KVM_FEATURE_MMU_OP)) {
-- 
1.6.0.2
