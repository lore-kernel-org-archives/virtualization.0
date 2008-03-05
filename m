From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: [PATCH 16/50] ia64/pv_ops: hook pal_call_static() for
	paravirtualization.
Date: Thu,  6 Mar 2008 03:18:31 +0900
Message-ID: <12047411461848-git-send-email-yamahata__14704.1264492602$1204749236$gmane$org@valinux.co.jp>
References: <12047411453864-git-send-email-yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <12047411453864-git-send-email-yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-ia64@vger.kernel.org
Cc: yamahata@valinux.co.jp, virtualization@lists.linux-foundation.org, kvm-ia64-devel@lists.sourceforge.net, xen-ia64-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org


Signed-off-by: Isaku Yamahata <yamahata@valinux.co.jp>
---
 arch/ia64/kernel/pal.S    |    5 +++--
 include/asm-ia64/privop.h |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/ia64/kernel/pal.S b/arch/ia64/kernel/pal.S
index 0b53344..d52fd70 100644
--- a/arch/ia64/kernel/pal.S
+++ b/arch/ia64/kernel/pal.S
@@ -16,6 +16,7 @@
 #include <asm/processor.h>
 
 	.data
+	.globl pal_entry_point
 pal_entry_point:
 	data8 ia64_pal_default_handler
 	.text
@@ -52,7 +53,7 @@ END(ia64_pal_default_handler)
  * in0         Index of PAL service
  * in1 - in3   Remaining PAL arguments
  */
-GLOBAL_ENTRY(ia64_pal_call_static)
+GLOBAL_ENTRY(native_pal_call_static)
 	.prologue ASM_UNW_PRLG_RP|ASM_UNW_PRLG_PFS, ASM_UNW_PRLG_GRSAVE(4)
 	alloc loc1 = ar.pfs,4,5,0,0
 	movl loc2 = pal_entry_point
@@ -86,7 +87,7 @@ GLOBAL_ENTRY(ia64_pal_call_static)
 	;;
 	srlz.d				// seralize restoration of psr.l
 	br.ret.sptk.many b0
-END(ia64_pal_call_static)
+END(native_pal_call_static)
 
 /*
  * Make a PAL call using the stacked registers calling convention.
diff --git a/include/asm-ia64/privop.h b/include/asm-ia64/privop.h
index 11d26f7..7b9de4f 100644
--- a/include/asm-ia64/privop.h
+++ b/include/asm-ia64/privop.h
@@ -21,6 +21,7 @@
 #define ia64_leave_syscall		native_leave_syscall
 #define ia64_work_processed_syscall	native_work_processed_syscall
 #define ia64_leave_kernel		native_leave_kernel
+#define ia64_pal_call_static		native_pal_call_static
 #endif /* !IA64_PARAVIRTUALIZED_ENTRY */
 
 #endif /* _ASM_IA64_PRIVOP_H */
-- 
1.5.3
