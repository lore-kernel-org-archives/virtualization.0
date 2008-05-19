From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 06/17] ia64/pv_ops: add an early setup hook for pv_ops.
Date: Mon, 19 May 2008 22:13:33 +0900
Message-ID: <1211202825173-git-send-email-yamahata__32564.1326410279$1211203850$gmane$org@valinux.co.jp>
References: <12112028241775-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12112028241775-git-send-email-yamahata@valinux.co.jp>
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

This patch adds a setup hook in the very early boot sequence
before start_kernel() to initialize paravirtualization stuff.
The hook will be set by each pv loader code or by using multi entry point.

Signed-off-by: Qing He <qing.he@intel.com>
Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/head.S     |   41 +++++++++++++++++++++++++++++++++++++++++
 include/asm-ia64/paravirt.h |    3 +++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/arch/ia64/kernel/head.S b/arch/ia64/kernel/head.S
index ddeab4e..db540e5 100644
--- a/arch/ia64/kernel/head.S
+++ b/arch/ia64/kernel/head.S
@@ -26,11 +26,14 @@
 #include <asm/mmu_context.h>
 #include <asm/asm-offsets.h>
 #include <asm/pal.h>
+#include <asm/paravirt.h>
 #include <asm/pgtable.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <asm/mca_asm.h>
+#include <linux/init.h>
+#include <linux/linkage.h>
 
 #ifdef CONFIG_HOTPLUG_CPU
 #define SAL_PSR_BITS_TO_SET				\
@@ -367,6 +370,44 @@ start_ap:
 	;;
 (isBP)	st8 [r2]=r28		// save the address of the boot param area passed by the bootloader
 
+#ifdef CONFIG_PARAVIRT
+
+	movl r14=hypervisor_setup_hooks
+	movl r15=hypervisor_type
+	mov r16=num_hypervisor_hooks
+	;;
+	ld8 r2=[r15]
+	;;
+	cmp.ltu p7,p0=r2,r16	// array size check
+	shladd r8=r2,3,r14
+	;;
+(p7)	ld8 r9=[r8]
+	;;
+(p7)	mov b1=r9
+(p7)	cmp.ne.unc p7,p0=r9,r0	// no actual branch to NULL
+	;;
+(p7)	br.call.sptk.many rp=b1
+
+	__INITDATA
+
+default_setup_hook = 0		// Currently nothing needs to be done.
+
+	.weak xen_setup_hook
+
+	.global hypervisor_type
+hypervisor_type:
+	data8		PARAVIRT_HYPERVISOR_TYPE_DEFAULT
+
+	// must have the same order with PARAVIRT_HYPERVISOR_TYPE_xxx
+
+hypervisor_setup_hooks:
+	data8		default_setup_hook
+	data8		xen_setup_hook
+num_hypervisor_hooks = (. - hypervisor_setup_hooks) / 8
+	.previous
+
+#endif
+
 #ifdef CONFIG_SMP
 (isAP)	br.call.sptk.many rp=start_secondary
 .ret0:
diff --git a/include/asm-ia64/paravirt.h b/include/asm-ia64/paravirt.h
index 26b4334..1032b21 100644
--- a/include/asm-ia64/paravirt.h
+++ b/include/asm-ia64/paravirt.h
@@ -26,6 +26,9 @@
 
 #ifdef CONFIG_PARAVIRT_GUEST
 
+#define PARAVIRT_HYPERVISOR_TYPE_DEFAULT	0
+#define PARAVIRT_HYPERVISOR_TYPE_XEN		1
+
 #ifndef __ASSEMBLY__
 
 #include <asm/hw_irq.h>
-- 
1.5.3
