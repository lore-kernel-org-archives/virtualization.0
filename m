From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 17/23] ia64/pv_ops/xen: paravirtualize entry.S for ia64/xen.
Date: Tue, 20 May 2008 08:08:04 +0900
Message-ID: <12112384912532-git-send-email-yamahata__25344.2805297256$1211240703$gmane$org@valinux.co.jp>
References: <12112384902859-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12112384902859-git-send-email-yamahata@valinux.co.jp>
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

paravirtualize entry.S for ia64/xen by multi compile.

Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/xen/Makefile      |    2 +-
 arch/ia64/xen/xen_pv_ops.c  |   18 ++++++++++++++++++
 include/asm-ia64/xen/inst.h |    8 ++++++++
 3 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/arch/ia64/xen/Makefile b/arch/ia64/xen/Makefile
index 5c87e4a..9b77e8a 100644
--- a/arch/ia64/xen/Makefile
+++ b/arch/ia64/xen/Makefile
@@ -8,7 +8,7 @@ obj-y := hypercall.o xenivt.o xensetup.o xen_pv_ops.o \
 AFLAGS_xenivt.o += -D__IA64_ASM_PARAVIRTUALIZED_XEN
 
 # xen multi compile
-ASM_PARAVIRT_MULTI_COMPILE_SRCS = ivt.S
+ASM_PARAVIRT_MULTI_COMPILE_SRCS = ivt.S entry.S
 ASM_PARAVIRT_OBJS = $(addprefix xen-,$(ASM_PARAVIRT_MULTI_COMPILE_SRCS:.S=.o))
 obj-y += $(ASM_PARAVIRT_OBJS)
 define paravirtualized_xen
diff --git a/arch/ia64/xen/xen_pv_ops.c b/arch/ia64/xen/xen_pv_ops.c
index aa73942..e483d47 100644
--- a/arch/ia64/xen/xen_pv_ops.c
+++ b/arch/ia64/xen/xen_pv_ops.c
@@ -273,6 +273,22 @@ static const struct pv_cpu_ops xen_cpu_ops __initdata = {
 			= xen_intrin_local_irq_restore,
 };
 
+/******************************************************************************
+ * replacement of hand written assembly codes.
+ */
+
+extern char xen_switch_to;
+extern char xen_leave_syscall;
+extern char xen_work_processed_syscall;
+extern char xen_leave_kernel;
+
+const struct pv_cpu_asm_switch xen_cpu_asm_switch = {
+	.switch_to		= (unsigned long)&xen_switch_to,
+	.leave_syscall		= (unsigned long)&xen_leave_syscall,
+	.work_processed_syscall	= (unsigned long)&xen_work_processed_syscall,
+	.leave_kernel		= (unsigned long)&xen_leave_kernel,
+};
+
 /***************************************************************************
  * pv_ops initialization
  */
@@ -284,4 +300,6 @@ xen_setup_pv_ops(void)
 	pv_info = xen_info;
 	pv_init_ops = xen_init_ops;
 	pv_cpu_ops = xen_cpu_ops;
+
+	paravirt_cpu_asm_init(&xen_cpu_asm_switch);
 }
diff --git a/include/asm-ia64/xen/inst.h b/include/asm-ia64/xen/inst.h
index e1e4435..9015bd3 100644
--- a/include/asm-ia64/xen/inst.h
+++ b/include/asm-ia64/xen/inst.h
@@ -25,6 +25,14 @@
 #define ia64_ivt				xen_ivt
 #define DO_SAVE_MIN				XEN_DO_SAVE_MIN
 
+#define __paravirt_switch_to			xen_switch_to
+#define __paravirt_leave_syscall		xen_leave_syscall
+#define __paravirt_work_processed_syscall	xen_work_processed_syscall
+#define __paravirt_leave_kernel			xen_leave_kernel
+#define __paravirt_pending_syscall_end		xen_work_pending_syscall_end
+#define __paravirt_work_processed_syscall_target \
+						xen_work_processed_syscall
+
 #define MOV_FROM_IFA(reg)	\
 	movl reg = XSI_IFA;	\
 	;;			\
-- 
1.5.3
