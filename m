From: Glauber Costa <gcosta@redhat.com>
Subject: [PATCH 1/3] [PATCH] allow machine_crash_shutdown to be replaced
Date: Tue, 18 Mar 2008 07:30:04 -0300
Message-ID: <1205836213477-git-send-email-gcosta__8055.33815077997$1205836852$gmane$org@redhat.com>
References: <1205836206192-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1205836206192-git-send-email-gcosta@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel@lists.sourceforge.net
Cc: Glauber Costa <gcosta@redhat.com>, anthony@codemonkey.ws, akpm@linux-foundation.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

This patch a llows machine_crash_shutdown to
be replaced, just like any of the other functions
in machine_ops

Signed-off-by: Glauber Costa <gcosta@redhat.com>
---
 arch/x86/kernel/crash.c  |    3 ++-
 arch/x86/kernel/reboot.c |   11 ++++++++++-
 include/asm-x86/reboot.h |    1 +
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
index 9a5fa0a..d262306 100644
--- a/arch/x86/kernel/crash.c
+++ b/arch/x86/kernel/crash.c
@@ -25,6 +25,7 @@
 #include <asm/hpet.h>
 #include <linux/kdebug.h>
 #include <asm/smp.h>
+#include <asm/reboot.h>
 
 #ifdef CONFIG_X86_32
 #include <mach_ipi.h>
@@ -121,7 +122,7 @@ static void nmi_shootdown_cpus(void)
 }
 #endif
 
-void machine_crash_shutdown(struct pt_regs *regs)
+void native_machine_crash_shutdown(struct pt_regs *regs)
 {
 	/* This function is only called after the system
 	 * has panicked or is otherwise in a critical state.
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
index 55ceb8c..ea95f11 100644
--- a/arch/x86/kernel/reboot.c
+++ b/arch/x86/kernel/reboot.c
@@ -453,7 +453,10 @@ struct machine_ops machine_ops = {
 	.shutdown = native_machine_shutdown,
 	.emergency_restart = native_machine_emergency_restart,
 	.restart = native_machine_restart,
-	.halt = native_machine_halt
+	.halt = native_machine_halt,
+#ifdef CONFIG_KEXEC
+	.crash_shutdown = native_machine_crash_shutdown,
+#endif
 };
 
 void machine_power_off(void)
@@ -481,3 +484,9 @@ void machine_halt(void)
 	machine_ops.halt();
 }
 
+#ifdef CONFIG_KEXEC
+void machine_crash_shutdown(struct pt_regs *regs)
+{
+	machine_ops.crash_shutdown(regs);
+}
+#endif
diff --git a/include/asm-x86/reboot.h b/include/asm-x86/reboot.h
index e9e3ffc..ff9b546 100644
--- a/include/asm-x86/reboot.h
+++ b/include/asm-x86/reboot.h
@@ -16,5 +16,6 @@ struct machine_ops
 extern struct machine_ops machine_ops;
 
 void machine_real_restart(unsigned char *code, int length);
+void native_machine_crash_shutdown(struct pt_regs *regs);
 
 #endif	/* _ASM_REBOOT_H */
-- 
1.5.0.6
